Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281163AbRKEOYG>; Mon, 5 Nov 2001 09:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281164AbRKEOX6>; Mon, 5 Nov 2001 09:23:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12181 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281163AbRKEOXx>;
	Mon, 5 Nov 2001 09:23:53 -0500
Date: Mon, 5 Nov 2001 09:23:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au>
Message-ID: <Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Andrew Morton wrote:

> OK, that's one possible reason.  Not sure I buy it though.  If
> the files are created a few days after their parent directory
> then the chance of their data or metadata being within device
> readhead scope of any of the parent dir's blocks seems small?

Algorithm for inode allocation had been written by Kirk back in
'84.  You can find some analisys in the original paper (A Fast
Filesystem for UNIX).

BTW, what you want is not "readahead scope of parent dir block".
You want inodes of files in given directory close to each other.
That matters a lot when you do stat() on directory contents,
etc.  Moreover, since we attempt to keep data blocks close to
inodes, we want to keep use of cylinder groups more or less
even.

