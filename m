Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWHGU1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWHGU1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWHGU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:27:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751009AbWHGU1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:27:36 -0400
Date: Mon, 7 Aug 2006 13:24:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Matt Reuther <mreuther@umich.edu>, LKML <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@sgi.com>
Subject: Re: [-mm patch] add timespec_to_us() and use it in kernel/tsacct.c
Message-Id: <20060807132418.037048a5.akpm@osdl.org>
In-Reply-To: <20060807133240.GB3691@stusta.de>
References: <200608062330.19628.mreuther@umich.edu>
	<20060806222129.f1cfffb9.akpm@osdl.org>
	<20060807133240.GB3691@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 15:32:41 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> On Sun, Aug 06, 2006 at 10:21:29PM -0700, Andrew Morton wrote:
> > On Sun, 6 Aug 2006 23:30:19 -0400
> > Matt Reuther <mreuther@umich.edu> wrote:
> > 
> > > I got an Error while compiling 2.6.18-rc3-mm2:
> > > 
> > >   AR      arch/i386/lib/lib.a
> > >   GEN     .version
> > >   CHK     include/linux/compile.h
> > >   UPD     include/linux/compile.h
> > >   CC      init/version.o
> > >   LD      init/built-in.o
> > >   LD      .tmp_vmlinux1
> > > kernel/built-in.o(.text+0x45667): In function `bacct_add_tsk':
> > > include/linux/time.h:130: undefined reference to `__divdi3'
> > > make: *** [.tmp_vmlinux1] Error 1
> > > 
> > > I attached the .config file.
> > > 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/hot-fixes/csa-basic-accounting-over-taskstats-fix.patch
> > should fix this, thanks.  
> 
> This doesn't look correct since do_div() does not guarantee to return 
> more than 32bit.

eh?  We use do_div() to do 64bit/something all the time??

> What about the patch below that adds a timespec_to_us() to time.h and 
> uses this function in kernel/tsacct.c?

Seems reasonable, but it'd be better as two patches..

Do we do timespec->microseconds anywhere else?
