Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWHGUqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWHGUqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWHGUqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:46:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25873 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932350AbWHGUqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:46:09 -0400
Date: Mon, 7 Aug 2006 22:46:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Reuther <mreuther@umich.edu>, LKML <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@sgi.com>
Subject: Re: [-mm patch] add timespec_to_us() and use it in kernel/tsacct.c
Message-ID: <20060807204606.GN3691@stusta.de>
References: <200608062330.19628.mreuther@umich.edu> <20060806222129.f1cfffb9.akpm@osdl.org> <20060807133240.GB3691@stusta.de> <20060807132418.037048a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807132418.037048a5.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 01:24:18PM -0700, Andrew Morton wrote:
> On Mon, 7 Aug 2006 15:32:41 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Sun, Aug 06, 2006 at 10:21:29PM -0700, Andrew Morton wrote:
> > > On Sun, 6 Aug 2006 23:30:19 -0400
> > > Matt Reuther <mreuther@umich.edu> wrote:
> > > 
> > > > I got an Error while compiling 2.6.18-rc3-mm2:
> > > > 
> > > >   AR      arch/i386/lib/lib.a
> > > >   GEN     .version
> > > >   CHK     include/linux/compile.h
> > > >   UPD     include/linux/compile.h
> > > >   CC      init/version.o
> > > >   LD      init/built-in.o
> > > >   LD      .tmp_vmlinux1
> > > > kernel/built-in.o(.text+0x45667): In function `bacct_add_tsk':
> > > > include/linux/time.h:130: undefined reference to `__divdi3'
> > > > make: *** [.tmp_vmlinux1] Error 1
> > > > 
> > > > I attached the .config file.
> > > > 
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/hot-fixes/csa-basic-accounting-over-taskstats-fix.patch
> > > should fix this, thanks.  
> > 
> > This doesn't look correct since do_div() does not guarantee to return 
> > more than 32bit.
> 
> eh?  We use do_div() to do 64bit/something all the time??

Sorry, this was my thinko.

> > What about the patch below that adds a timespec_to_us() to time.h and 
> > uses this function in kernel/tsacct.c?
> 
> Seems reasonable, but it'd be better as two patches..

Feel free to split this patch however you want, I thought it was not 
worth splitting it.

> Do we do timespec->microseconds anywhere else?

I haven't found another place.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

