Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUL0Af1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUL0Af1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUL0Af1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:35:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33178 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261442AbUL0AfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:35:13 -0500
Subject: Linux 2.6.10-ac1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104103881.16545.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 23:31:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.6.10-ac1 is a merge of the stuff that has not yet been accepted
upstream along with a couple of small extra changes that are needed because
of changes in 2.6.10 base. In addition the generic IRQ work in 2.6.10 means
that the forward port of the irqpoll code now covers a lot more platforms.

While this has had a lot less testing than 2.6.9-ac16 it does contain much
better core USB and SCSI code so may in some cases be worth an early move.

Arjan van de Ven is now building RPMS of the kernel and those can be found
in the RPM subdirectory and should be yum-able. Expect the RPMS to lag the
diff a little as the RPM builds and tests do take time.


Key:	o	- only in -ac
	*	- already fixed upstream
	X	- discarded later as wrong
	+	- ac specific (fix not relevant to non -ac)

2.6.10-ac1
o	Revert AX.25 protocol breakage			(Alan Cox)
o	Remove bogus obsolete option junk from 2.6.10	(Alan Cox)
	ide changes
	| Options are often useful, so should be kept.
	| Especially stuff like serialize
o	Fix bogus dma_ naming in the 2.6.10 patch	(Alan Cox)
o	Initial CS5520 fixups for VDMA and 2.6.10
	| Must set vdma flag before command issue
	| ?? could we just set it at boot and leave it - probably (check)

Forward ported from 2.6.9-ac
o	Smbfs improved parsing fixes			(Chuck Ebhert)
o	Fix several IDE drivers that assumed > 0 was	(Alan Cox)
	also an error return for pci probe functions
o	Fix sys5 semaphore wakeups			(Manfred Spraul)
o	Suggest irqpoll when we get screaming irqs	(Alan Cox)
o	Fix reset problems with older 3c59x/3c90x	(John Linville)
o	Configurable 100/1Khz clock for x86		(James Bottomley)
	| 100Hz is great for battery life
o	Delkin cardbus IDE support			(Mark Lord)
o	IT8212 IDE support				(Alan Cox)
o	Add more AC97 table data
o	Token ring locking fix
o	Fix URL for lanana				(Alexander Stohr)
o	Add a 1620 byte slab cache for ethernet frames	(Arjan van de Ven)
o	EDD boot options				(Matt Domsch)
o	Don't probe legacy ISA ide2,3,4,5 on PCI boxes	(Alan Cox)
o	Restore PWC driver				(Luc Saillard)
	| Please port away from remap_page_range
o	Fix AT2701FX AMD PCnet32 on fibre		(Guido Guenther)
o	Fix build of CS461x gameport			(Adrian Bunk)
o	Fix crash with aacraid double complete	(Mark Salyzyn, Tom Coughlan,
						 Alan Cox)
o	Fix getblk_slow hang				(Chris Mason)
+	Fix SMP hang with IDE unregister		(Mark Lord)
o	Working IDE locking				(Alan Cox)
	| And a great deal of review by Bartlomiej
o	Allow IDE to grab all unknown generic IDE	(Alan Cox)
	devices (boot with "all-generic-ide")
o	More ATI IDE PCI identifiers			(Enrico Scholza)
o	Initial patch for ide_abort hang		(Alan Cox)
o	Fix serveral ide timing violations on reset	(Alan Cox)
o	Support CSB6-R Serverworks raid			(Alan Cox)
o	Teach ide-cd to use sense data for file system	(Alan Cox)
	requests
	- This means you get better diagonstics on CD errors
	- It means a partial I/O failure will get you back the ok sectors
	- It may fix the problem some users have with ISO copying and ide-cd
o	Lock ide-proc against driver unload		(Alan Cox)
	(very low severity)
o	Fix ide /proc and legacy devices problem	(Alan Cox)
o	Watchdog support for early cobalt ALi hardware	(Mike Waychison)
o	Make sx8 naming follow LANANA			(Jeremy Katz)
o	Don't warn on scsi ioctl kmalloc fail		(Arjan van de Ven)
o	Fix Paul Laufer's email address			(Paul Laufer)
o	Fix misleading microcode message		(Arjan van de Ven)
o	Allow cross compile of x86_32 kernel on x86_64	(Arjan van de Ven)
o	Kill "open failed" cdrom message.		(Alan Cox)
	| This is a natural event from code poking around
	| doing CD detection etc
o	Minor typo fix in cdrom driver			(efalk@google)
o	Add support for newer ALi AGP			(Clear Zhang)
o	Handle E7xxx boxes with USB legacy flaws	(Alan Cox)

Cleanups in porting
o	Draw ->taskfile hooks in the IDE layer 		(Alan Cox)
	(->fixup replaces)
o	Fix up IT8212 for 2.6.10 ide_use_dma cleanups	(Alan Cox)
	and other 2.6.10 cleaning

Dropped for now
o	VIA extra quirk
o	HP Cardbus routing fixup

