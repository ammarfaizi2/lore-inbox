Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281835AbRLKQ0i>; Tue, 11 Dec 2001 11:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281772AbRLKQ03>; Tue, 11 Dec 2001 11:26:29 -0500
Received: from newyork.ethz.ch ([129.132.189.66]:4617 "EHLO phys.ethz.ch")
	by vger.kernel.org with ESMTP id <S281835AbRLKQ0K> convert rfc822-to-8bit;
	Tue, 11 Dec 2001 11:26:10 -0500
Date: Tue, 11 Dec 2001 17:26:06 +0100 (CET)
From: Tobias Vancura <tvancura@phys.ethz.ch>
Reply-To: Tobias Vancura <tvancura@phys.ethz.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Tobias Vancura <tvancura@solid.phys.ethz.ch>
Subject: "bad special flag" on Vaio PCG-Z600NE (ide.c)
Message-ID: <Pine.LNX.4.21.0112111723190.1418-100000@bermuda.ethz.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello everybody

I get the following error message when I plug the PCMCIA CDROM
drive into my brother's Vaio PCG-Z600NE:

Dec 11 14:58:54 grisu kernel: hde: bad special flag: 0x03

The kernel I am running is 2.4.16. The CDROM actually works,
but I have this error message which I don't understand. The whole
excerpt from /var/log/messages is:

here I plug in the PCMCIA card:

Dec 11 14:58:51 grisu cardmgr[283]: socket 0: Ninja ATA
Dec 11 14:58:51 grisu cardmgr[283]: executing: 'modprobe ide-cs'
Dec 11 14:58:54 grisu kernel: hde: TOSHIBA CD-ROM XM-7002Bc, ATAPI
CD/DVD-ROM drive
Dec 11 14:58:54 grisu kernel: ide2 at 0x180-0x187,0x386 on irq 3
Dec 11 14:58:54 grisu kernel: ide_cs: hde: Vcc = 5.0, Vpp = 0.0
Dec 11 14:58:54 grisu cardmgr[283]: executing: './ide start hde'
Dec 11 14:58:54 grisu kernel: hde: bad special flag: 0x03

here the PCMCIA is removed:

Dec 11 14:59:03 grisu kernel: ide2: unexpected interrupt, status=0xff,
count=4
Dec 11 14:59:03 grisu cardmgr[283]: executing: './ide stop hde'
Dec 11 14:59:03 grisu modprobe: modprobe: Can't locate module
block-major-33
Dec 11 14:59:03 grisu cardmgr[283]: + open() failed: Device not configured
Dec 11 14:59:03 grisu cardmgr[283]: executing: 'modprobe -r ide-cs'

I guess the "unexpected interrupt" is okay, because who should
expect the PCMCIA card to be removed. The "Can't locate module
block-major-33" isn't that important either, I guess, I have to
see how I can fix that.

The line with the special flag is generated at line 1080 in
the file drivers/ide/ide.c within the function 

static ide_startstop_t do_special (ide_drive_t *drive)

I do not understand the code there and it does not seem to matter
anyway. The function returns "ide_stopped" and all that is done
is that a local variable "special_t *s" is set to "s->all =
0;" and the printk command is issued.

Could any comment on this?

Thank you very much,

Tobias

P.S.: I tried to mail the maintainer of IDE, Andre Hedrik, but I
did not get an answer from <andre@linux-ide.org> and
<andre@suse.com> does not exist anymore.


-- 
Tobias Vancura				Email: tvancura@phys.ethz.ch
Solid State Physics Laboratory		Phone: +41-(0)1-633 3767
HPF C 13				Fax:   +41-(0)1-633 1146
ETH Zürich				
CH - 8093 Zurich/Switzerland




