Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSFCWb2>; Mon, 3 Jun 2002 18:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSFCWb1>; Mon, 3 Jun 2002 18:31:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315629AbSFCWb1>;
	Mon, 3 Jun 2002 18:31:27 -0400
Message-ID: <3CFBEDEE.EE74C5B1@zip.com.au>
Date: Mon, 03 Jun 2002 15:30:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Chris Mason <mason@suse.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <1023142233.31475.23.camel@tiny> <Pine.LNX.4.44.0206031514110.868-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On 3 Jun 2002, Chris Mason wrote:
> >
> > Or am I missing something?
> 
> No. I think that in the long run we really would want all of the writeback
> preallocation should happen in the "struct file", not in "struct inode".
> And they should be released at file close ("release()"), not at iput()
> time.

That would be a lot nicer.

But why does ext2_put_inode() even exist?  We're already throwing
away the prealloc window in ext2_release_file?  I guess for
shared mappings over spares files: if all file handles have
closed off, we still need to make allocations against that
inode, yes?

-
