Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbTDWTm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTDWTmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 15:42:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44932 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263631AbTDWTkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 15:40:46 -0400
Subject: Re: Can one build 2.5.68 with allyesconfig?
From: John Cherry <cherry@osdl.org>
To: root@chaos.analogic.com
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0304221701320.17809@chaos>
References: <3EA5AABF.4090303@techsource.com>
	 <Pine.LNX.4.53.0304221701320.17809@chaos>
Content-Type: text/plain
Organization: 
Message-Id: <1051127561.20214.20.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 23 Apr 2003 12:52:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in other mail, compile statistics for the latest 2.5
kernels are at: http://www.osdl.org/archive/cherry/stability/

However, these statistics are based on defconfig and allmodconfig builds
(not allyesconfig).  The allmodconfig build contains the riscom8 errors
that you have observed as well as most other warnings/errors you would
find in an allyesconfig build.

I have also compiled a list of cli/sti removal candidates. The files
that flag cli/save_flags conversions are:
                                                          
===========================================
cli, save_flags conversions: 66 files
===========================================
drivers/atm/ambassador.c
drivers/atm/uPD98402.c
drivers/atm/zatm.c
drivers/cdrom/cdu31a.c
drivers/cdrom/cm206.c
drivers/cdrom/sbpcd.c
drivers/cdrom/sonycd535.c
drivers/char/cyclades.c
drivers/char/epca.c
drivers/char/esp.c
drivers/char/ftape/lowlevel/fdc-io.c
drivers/char/ftape/lowlevel/ftape-calibr.c
drivers/char/ftape/lowlevel/ftape-format.c
drivers/char/generic_serial.c
drivers/char/ip2main.c
drivers/char/isicom.c
drivers/char/istallion.c
drivers/char/moxa.c
drivers/char/mxser.c
drivers/char/rocket.c
drivers/char/stallion.c
drivers/i2c/i2c-elektor.c
drivers/isdn/act2000/capi.h
drivers/isdn/divert/divert_init.c
drivers/isdn/divert/divert_procfs.c
drivers/isdn/divert/isdn_divert.c
drivers/isdn/hardware/avm/b1.c
drivers/isdn/hardware/avm/c4.c
drivers/isdn/hardware/avm/t1isa.c
drivers/isdn/hysdn/boardergo.c
drivers/isdn/hysdn/hysdn_proclog.c
drivers/isdn/hysdn/hysdn_sched.c
drivers/isdn/i4l/isdn_audio.c
drivers/isdn/i4l/isdn_tty.c
drivers/isdn/i4l/isdn_ttyfax.c
drivers/isdn/icn/icn.c
drivers/isdn/isdnloop/isdnloop.c
drivers/isdn/pcbit/edss1.c
drivers/isdn/pcbit/layer2.c
drivers/isdn/sc/command.c
drivers/isdn/sc/message.c
drivers/isdn/sc/shmem.c
drivers/isdn/sc/timer.c
drivers/net/3c527.c
drivers/net/82596.c
drivers/net/hamradio/6pack.c
drivers/net/hamradio/dmascc.c
drivers/net/hamradio/mkiss.c
drivers/net/irda/toshoboe.c
drivers/net/ni5010.c
drivers/net/ni65.c
drivers/net/pcmcia/fmvj18x_cs.c
drivers/net/pcmcia/nmclan_cs.c
drivers/net/sk_mca.c
drivers/net/tulip/xircom_tulip_cb.c
drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx.c
drivers/net/wan/sdla.c
drivers/net/wan/sdla_x25.c
drivers/net/wan/x25_asy.c
drivers/scsi/AM53C974.c
drivers/scsi/mca_53c9x.c
drivers/scsi/psi240i.c
fs/nfsd/nfs4proc.c

The complete list of porting items that I have pulled from compiler
output can be found at:
http://www.osdl.org/archive/cherry/stability/linus-tree/port_items.txt

Sorry about occasional 404 problems.  This is an update artifact that we
are working on.  Just try again.

John

On Tue, 2003-04-22 at 14:06, Richard B. Johnson wrote:
> On Tue, 22 Apr 2003, Timothy Miller wrote:
> 
> > Is anyone else able to build 2.5.68 w
> ith allyesconfig?
> >
> > I'm using RH7.2, so the first thing I did was edit the main Makefile to
> > replace gcc with "gcc3" (3.0.4).  Maybe the compiler is STILL my
> > problem.  The problem doesn't stand out clearly to me, but I also
> > haven't put much thought into it.  I'll try to use some more of my
> > brain.  But if it's not going to be fixable by me, I humbly request help.
> >
> > Before the compile terminates, there are a number of the same warning
> > for other files, being the same as the ones below for 'flags'.
> >
> > The compile dies thusly:
> >
> >   gcc3 -Wp,-MD,drivers/char/.riscom8.o.d -D__KERNEL__ -Iinclude -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> > -pipe -mpreferred-stack-boundary=2 -march=i686
> > -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
> > -DKBUILD_BASENAME=riscom8 -DKBUILD_MODNAME=riscom8 -c -o
> > drivers/char/.tmp_riscom8.o drivers/char/riscom8.c
> [SNIPPED...]
> 
> drivers/char/riscom8.c uses old methods including 'cli' and 'sti'.
> It hasn't been fixed yet. Remove this from your configuration
> and try again.
> 
> No code should use cli and sti. If any compile errors out on 2.5.n.n,
> as a result of this, and you need the driver, you might try to inspect
> the source and contact its maintainer. There are a lot of cleanups
> on-going in this version.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

