Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRAXCGq>; Tue, 23 Jan 2001 21:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbRAXCGg>; Tue, 23 Jan 2001 21:06:36 -0500
Received: from kanga.kvack.org ([216.129.200.3]:65286 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S132117AbRAXCGW>;
	Tue, 23 Jan 2001 21:06:22 -0500
Date: Tue, 23 Jan 2001 21:03:09 -0500 (EST)
From: "Benjamin C.R. LaHaise" <blah@kvack.org>
To: David Wragg <dpw@doc.ic.ac.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: limit on number of kmapped pages
In-Reply-To: <y7rofwxeqin.fsf@sytry.doc.ic.ac.uk>
Message-ID: <Pine.LNX.3.96.1010123205643.7482A-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2001, David Wragg wrote:

> ebiederm@xmission.com (Eric W. Biederman) writes:
> > Why do you need such a large buffer? 
> 
> ext2 doesn't guarantee sustained write bandwidth (in particular,
> writing a page to an ext2 file can have a high latency due to reading
> the block bitmap synchronously).  To deal with this I need at least a
> 2MB buffer.

This is the wrong way of going about things -- you should probably insert
the pages into the page cache and write them into the filesystem via
writepage.  That way the pages don't need to be mapped while being written
out.  For incoming data from a network socket, making use of the
data_ready callbacks and directly copying from the skbs in one pass with a
kmap of only one page at a time.

Maybe I'm guessing incorrect at what is being attempted, but kmap should
be used sparingly and as briefly as possible.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
