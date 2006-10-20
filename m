Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946415AbWJTQLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946415AbWJTQLb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992624AbWJTQLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:11:31 -0400
Received: from xenotime.net ([66.160.160.81]:40893 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1946415AbWJTQL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:11:29 -0400
Date: Fri, 20 Oct 2006 09:13:02 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-Id: <20061020091302.a2a85fb1.rdunlap@xenotime.net>
In-Reply-To: <45389662.6010604@s5r6.in-berlin.de>
References: <20061017005025.GF29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610161847210.3962@g5.osdl.org>
	<20061017043726.GG29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610170821580.3962@g5.osdl.org>
	<20061018044054.GH29920@ftp.linux.org.uk>
	<20061018091944.GA5343@martell.zuzino.mipt.ru>
	<20061018093126.GM29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610180759070.3962@g5.osdl.org>
	<20061018160609.GO29920@ftp.linux.org.uk>
	<Pine.LNX.4.64.0610180926380.3962@g5.osdl.org>
	<20061020005337.GV29920@ftp.linux.org.uk>
	<20061019213545.bf5a51c1.rdunlap@xenotime.net>
	<45389662.6010604@s5r6.in-berlin.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 11:26:58 +0200 Stefan Richter wrote:

> Randy Dunlap wrote:
> > Here's about half of checking includers of linux/smp_lock.h to see
> > if they actually use any of its interfaces.  (most don't)
> > 
> > Yet to do:  fs/* and arch/*
> > Built only on x86_64.
> [...]
> >  drivers/acpi/osl.c                            |    1 -
> >  drivers/block/acsi_slm.c                      |    1 -
> >  drivers/block/umem.c                          |    1 -
> >  drivers/char/ds1620.c                         |    1 -
> >  drivers/char/dsp56k.c                         |    1 -
> >  drivers/char/dtlk.c                           |    1 -
> >  drivers/char/ec3104_keyb.c                    |    1 -
> >  drivers/char/ftape/zftape/zftape-init.c       |    1 -
> >  drivers/char/hangcheck-timer.c                |    1 -
> >  drivers/char/ip27-rtc.c                       |    1 -
> >  drivers/char/lp.c                             |    1 -
> >  drivers/char/mem.c                            |    1 -
> >  drivers/char/mxser.c                          |    1 -
> >  drivers/char/ppdev.c                          |    1 -
> >  drivers/char/sysrq.c                          |    1 -
> >  drivers/char/vc_screen.c                      |    1 -
> >  drivers/char/watchdog/omap_wdt.c              |    1 -
> >  drivers/char/watchdog/pcwd_usb.c              |    1 -
> >  drivers/i2c/busses/scx200_acb.c               |    1 -
> >  drivers/i2c/i2c-dev.c                         |    1 -
> >  drivers/ieee1394/raw1394.c                    |    1 -
> >  drivers/infiniband/ulp/iser/iser_verbs.c      |    1 -
> >  drivers/input/evdev.c                         |    1 -
> >  drivers/input/input.c                         |    1 -
> [... etc. pp. ...]
> >  sound/oss/swarm_cs4297a.c                     |    1 -
> >  sound/oss/trident.c                           |    1 -
> >  sound/oss/via82cxxx_audio.c                   |    1 -
> >  166 files changed, 166 deletions(-)
> [...]
> 
> I am afraid in many of these cases a proper cleanup would _replace_ the
> include by the correct one, not just delete it. For example,
> drivers/ieee1394/raw1394.c should include linux/spinlock.h. AFAICS it
> does so at the moment only indirectly via another header.

I don't think that we can fix it all at once.  This is just one step.
AFAICT for raw1394.c, it's not incorrect as is, but more is needed,
sure.

Yes, we have lots of header include indirection going on.
I don't know of a good tool to detect/fix it.

What Al is doing is good stuff, but I'd still prefer to see an even
better tool, like gcc-preprocessor or sparse based (I guess).

---
~Randy
