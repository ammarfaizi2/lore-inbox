Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSHIVSz>; Fri, 9 Aug 2002 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSHIVSz>; Fri, 9 Aug 2002 17:18:55 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:26391 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S315942AbSHIVSy>;
	Fri, 9 Aug 2002 17:18:54 -0400
Date: Fri, 9 Aug 2002 23:22:31 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dave Hansen <haveblue@us.ibm.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261!
Message-ID: <20020809212231.GB1252@win.tue.nl>
References: <200208091732.g79HW4q02868@eng2.beaverton.ibm.com> <3D542C06.50008@us.ibm.com> <3D542D75.7FEA9DDF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D542D75.7FEA9DDF@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 02:00:37PM -0700, Andrew Morton wrote:

> > > Code;  c0160d0f <d_unhash+f/70>   <=====

> It would be much more useful if the oops code were to dump the
> text preceding the exception EIP rather than after it, actually.

I think I already mentioned what the stack trace is for this oops:
for me, it is sd_detach -> driverfs_remove_partitions ->
put_device -> driverfs_remove_dir -> driverfs_rmdir -> d_unhash.

I have seen lots of other oopses related to driverfs.
Submitted a stopgap patch to prevent some of them, but withdrew it
when it became clear that even the ugly stopgap did not prevent all.

This driverfs partition stuff is messy. The code paths where partitions
are created are very different from those where partitions are removed,
and it can easily happen that a partition is removed that was never
created, leading to an oops.

Andries

