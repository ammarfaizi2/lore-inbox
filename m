Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289730AbSA2QQ2>; Tue, 29 Jan 2002 11:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289732AbSA2QQT>; Tue, 29 Jan 2002 11:16:19 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:59091 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S289730AbSA2QQB>;
	Tue, 29 Jan 2002 11:16:01 -0500
Date: Tue, 29 Jan 2002 17:15:51 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
Subject: ANNOUNCE - 2.4.x ide backport for 2.2.21pre2 kernel
Message-ID: <Pine.LNX.4.33.0201291654480.17318-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems Andre Hedrick is no longer working on ide patch for 2.2.x
kernels. So, for last two weeks I have prepared backport of IDE
system from linux-2.4.17+ide.2.4.16.12102001.patch. Ofcourse, not
everything is ready but I think that my patch could be usefull.

What I have already done:
+	IDE goes from drivers/block into drivers/ide like in 2.4.x
+	new versions of most ide drivers
+	flushing/stopping ide disk at reboot/halt/shutdown
+	LBA48 (only for pdc202xx)
+	lot of changes taken from 2.4.x: ide.c, ide-disk, ide-cd,
	ide-scsi.c, other related files...
+	some changes in ide-tape, ide-floppy, etc

ide.2.2.21.01282002-Ole seems to be enough stable to be known as RC
version. I'm using it on 4 serwers (2xMVP3, 1xKT133A+PDC20265, 1x430VX)
for about 30 hours and I haven't seen any problems. So, it may work. If
not, don't use it :)

And this is full changelog:
ide.2.2.21.01282002-Ole for linux kernel 2.2.21pre2: (rc version)
o	backport from linux-2.4.17+ide.2.4.16.12102001.patch:
		ide-cd.c - ver 4.59
		hpt34x.c - ver 0.31
		trm290.c - ver 1.02
		amd74xx.c - ver 0.05
		aec62xx.c - ver 0.09
		pdcadma.c - ver 0.01
		pdc4030.c, pdc4030.h, q40ide.c
o	changes in pdc202xx.c, ide.c, hd.c, ide-pci.c,
		ide-dma.c, ide.h

ide.2.2.21.01242002-Ole for linux kernel 2.2.21pre2: (test version)
o	backport from linux-2.4.17+ide.2.4.16.12102001.patch:
		ide-scsi.c:
			It has been broken since ide.2.2.21.01182002-Ole.
			Needs little more work in future.
		ide-taskfile.c
			backported in 100% :)
		ide-disk.c - ver 1.12:
			LBA48 addressing code is ready. It may work.
			Don't have required hardware to test it.
		sis5513.c - ver 0.11
o	pdc202xx.c:
		Enable lba48 addressing mode - may work, untested.
o	ide-cd.c, ide-pci.c, pdc4030.c:
		only small changes.
o	hdreg.h, ide.h, ide-cd.h
		more changes required by new ide-taskfile.c, ide-disk.c
			pdc202xx.c, ide-cd.c

ide.2.2.21.01212002-Ole for linux kernel 2.2.21pre2: (test version)
o	backport from linux 2.4.17:
		opti621.c, rz1000.c, umc8672.c, ali14xx.c,
		cmd640, cs5530.c, ht6560b.c, ide_modes.h
o	backport from ide.2.4.16.12102001.patch:
		qd65xx.c,
		flushing ide devices at halt/shutdown/reboot
o	fix alpha/arm/m68k/mips/ppc/sparc/sparc64
o	changes in ide-disk.c, ide-cd.c, ide-tape.c, ide-floppy.c,
		ide-probe.c, ide.c, ide-taskfile.c, ide-dma.c, ide.h,
		hdreg.h

ide.2.2.21.01182002-Ole for linux kernel 2.2.21pre2: (test version)
o	move IDE STUFF from drivers/block into drivers/ide
		only x86, need some more work
o	backport from ide.2.4.16.12102001.patch:
		serverworks.c - ver 0.3
		piix.c - ver 0.32
o	backport from linux 2.4.17:
		ide=reverse
			This one doesn't look nice but there is no
			 dev->prev for PCI in 2.2.x
		ide=nodma
			works only with pdc202xx, piix, serverworks, via82cxxx
o	some chages in ide-cd.h, ide.h, ide-taskfile.c, ide.c, ide-disk.c, ...
		There were so many changes between linux kernel 2.2 and 2.4
		and just can't backport everything at once.
		I hope my changes didn't breake anything. :)

ide.2.2.21.01152002-Ole for linux kernel 2.2.21pre2:
o	backport from ide.2.4.16.12102001.patch: pdc202xx.c - ver 0.30
		- no 48-bit lba - this requires changes in other files:
		   ide-disk.c, ide.c, ide.h, ... Maybe in future...
o	fix missing DEVID_MR_IDE definition in ide-pci.c for VIA_82C576_1
o	add PROMISE_20268R, PROMISE_20269, PROMISE_20275 in ide-pci.c
o	add CONFIG_PDC202XX_FORCE option into Config.in, ide-pci.c

ide.2.2.21.05042001-Ole for linux kernel 2.2.21pre2:
o	backport from linux 2.4.17: via82cxxx.c - ver 3.29

Best regards,


				Krzysztof Oledzki

