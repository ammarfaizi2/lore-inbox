Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbTGKILN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266633AbTGKILM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:11:12 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:58636 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266630AbTGKILJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:11:09 -0400
Date: Fri, 11 Jul 2003 09:25:32 +0100
From: Joe Thornber <thornber@sistina.com>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm3
Message-ID: <20030711082532.GA432@fib011235813.fsnet.co.uk>
References: <20030708223548.791247f5.akpm@osdl.org> <200307101821.h6AIL87u013299@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307101821.h6AIL87u013299@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 02:21:08PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 08 Jul 2003 22:35:48 PDT, Andrew Morton <akpm@osdl.org>  said:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm3/
> 
> OK, I'm finally getting around to actually commenting, this has been a niggling issue for
> a while...
> 
> > All 113 patches:
> 
> > 64-bit-dev_t-kdev_t.patch
> >   64-bit dev_t and kdev_t
> 
> Yes, this patch says "not ready for prime time, it breaks things".
> 
> In particular, this gives the device-mapper userspace indigestion, because the
> ioctl passes something other than a 64-bit kdev_t in from libdevmapper. Upshot
> is that the LVM2 'vgchange -ay' fails gloriously.
> 
> Workaround:  Compile the devmapper/LVM stuff with a private copy of include/
> linux/kdev_t.h that matches the one the kernel uses.  No, I didn't actually get
> that to work, so I backed out the 64-bit patch...
> 
> (And no, the recent devmapper/LVM2 stuff posted doesn't fix this).

The v1 ioctl interface passes the dev in as a __kernel_dev_t, so
unfortunately if you change the size of __kernel_dev_t you will have
to rebuild the tools.

The v4 ioctl interface just uses a __u64 which I hope will be future
proof.

- Joe
