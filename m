Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbSIZNSa>; Thu, 26 Sep 2002 09:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261177AbSIZNSa>; Thu, 26 Sep 2002 09:18:30 -0400
Received: from thunk.org ([140.239.227.29]:11168 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261165AbSIZNS3>;
	Thu, 26 Sep 2002 09:18:29 -0400
Date: Thu, 26 Sep 2002 09:23:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Cumming <ryan@completely.kicks-ass.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020926132303.GB5612@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Cumming <ryan@completely.kicks-ass.org>,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209252223.13758.ryan@completely.kicks-ass.org> <20020926055755.GA5612@think.thunk.org> <200209260041.59855.ryan@completely.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209260041.59855.ryan@completely.kicks-ass.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 12:41:54AM -0700, Ryan Cumming wrote:
> 
> Using GCC 2.95.4 seems to stabilize dir_index nicely, both before and after 
> the hdparm -fD run. Only the kernel was recompiled with 2.95.4, I reused the 
> original GCC 3.2 compiled e2fsprogs.
> 

Thanks for willing to be a Guienea Pig; now I know what to look for.  

I didn't have a chance to answer your question last night about how to
test it without risking your data, but the answer is that that patch
doesn't change how ext3 works unless the dir_index feature flag is
set.  So it would have been safe to boot the patched, kernel, and then
create a test filesystem in a plain file, and the mount it using the
loop device:

	dd if=/dev/zero of=test.img bs=1024k count=32
	mke2fs -f -j test.img
	mount -o loop test.img /mnt

So I'll take a look at things and try to figure out what GCC bug we
might be triggering.  It's strange; it's not like the code using
inline instructions, or anything else that might be triggering a GCC
bug or discrepancy between how GCC 2.95.4 and GCC 3.2 works.  In fact,
it's all relatively straightforward C code.

Anyway, thanks.

						- Ted

