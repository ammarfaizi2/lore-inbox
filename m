Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132010AbQLVPzn>; Fri, 22 Dec 2000 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132093AbQLVPzd>; Fri, 22 Dec 2000 10:55:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:37968 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132010AbQLVPzU>; Fri, 22 Dec 2000 10:55:20 -0500
Date: Fri, 22 Dec 2000 16:24:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test13-pre4
Message-ID: <20001222162441.B29397@athlon.random>
In-Reply-To: <Pine.LNX.4.10.10012211726060.968-100000@penguin.transmeta.com> <3A43506B.6CEF84BB@eyal.emu.id.au> <20001222153145.A15733@athlon.random> <20001222160150.A28385@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001222160150.A28385@athlon.random>; from andrea@suse.de on Fri, Dec 22, 2000 at 04:01:50PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 04:01:50PM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 22, 2000 at 03:31:45PM +0100, Andrea Arcangeli wrote:
> > On Sat, Dec 23, 2000 at 12:00:27AM +1100, Eyal Lebedinsky wrote:
> > > Linus Torvalds wrote:
> > > >  - pre4:
> > > >    - Andrea Arkangeli: update to LVM-0.9
> > > 
> > > gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall
> > > -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> > > -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE
> > > -DMODVERSIONS -include
> > > /usr/local/src/linux/include/linux/modversions.h   -c -o lvm.o lvm.c
> > > lvm.c: In function `lvm_do_vg_extend':
> > > lvm.c:2024: warning: implicit declaration of function
> > > `lvm_do_create_proc_entry_of_pv'
> > > lvm.c: In function `lvm_do_create_proc_entry_of_lv':
> > > lvm.c:3016: `pde' undeclared (first use in this function)
> > > lvm.c:3016: (Each undeclared identifier is reported only once
> > > lvm.c:3016: for each function it appears in.)
> > > lvm.c: At top level:
> > > lvm.c:3044: warning: type mismatch with previous implicit declaration
> > > lvm.c:2024: warning: previous implicit declaration of
> > > `lvm_do_create_proc_entry_of_pv'
> > > lvm.c:3044: warning: `lvm_do_create_proc_entry_of_pv' was previously
> > > implicitly declared to return `int'
> > > lvm.c: In function `lvm_do_create_proc_entry_of_pv':
> > > lvm.c:3050: `pde' undeclared (first use in this function)
> > > lvm.c: At top level:
> > > lvm.c:147: warning: `lvm_short_version' defined but not used
> > > make[2]: *** [lvm.o] Error 1
> > > make[2]: Leaving directory `/data2/usr/local/src/linux-2.4/drivers/md'
> > 
> > Strange, test13-pre3 plus the 0.9 lvm patch compiled and worked fine
> > for me. I'll try to compile test13-pre4 now and I'll let you know.
> 
> Ok, found it, you can workaround it with:
> 
> CONFIG_LVM_PROC_FS=y
> 
> (I never tried to compile LVM without procfs support, you really
> want /proc support too, anyways of course it should compile also
> without /proc support so it's a minor bug...)

Ok this should fix the problem and it cleanups a little bit the code:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test13-pre4/lvm-proc-fixes-1

Please confirm and then I'll sumbit it to Linus.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
