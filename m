Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUAQVZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUAQVZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 16:25:29 -0500
Received: from lucifer.czad.org ([80.55.246.78]:58529 "EHLO lucifer.czad.org")
	by vger.kernel.org with ESMTP id S266161AbUAQVZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 16:25:27 -0500
Subject: VIA Apollo - 2.4.21 - usb-uhci, USB errors
From: "Marek \"Tilk\" Materzok" <tilk@lucifer.czad.org>
Reply-To: tilk@lucifer.czad.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074374728.32010.35.camel@lucifer.czad.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 17 Jan 2004 22:25:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When running a Sagem 800 DSL modem (eagle adiusbadsl drivers from
http://eagle-usb.fr.st/) I've run into following problem. When sending
lots of data through the DSL link, an USB error appears, modem device is
disconnected, and then reconnected. The kernel.log says:

Jan 17 21:44:02 osama kernel: usb-uhci.c: interrupt, status 3, frame# 952
Jan 17 21:44:02 osama kernel: [Adi] transmit error with URB status -110
Jan 17 21:44:02 osama kernel: [Adi] transmit error with URB status -110
Jan 17 21:44:02 osama kernel: [ADI] adi_irq : URB status indicates error (-84)
Jan 17 21:44:02 osama kernel: [ADI] adi_irq : URB status indicates error (-84)
Jan 17 21:44:02 osama kernel: hub.c: already running port 2 disabled by hub (EMI?), re-enabling...
Jan 17 21:44:02 osama kernel: usb.c: USB disconnect on device 00:07.2-2 address 61
Jan 17 21:44:02 osama kernel: [adi] adi_irq : URB canceled by user.
Jan 17 21:44:02 osama kernel: [adi] ADSL device removed
Jan 17 21:44:02 osama kernel: hub.c: new USB device 00:07.2-2, assigned address 62

Sometimes it's "interrupt, status 2", frame# is always different.

The motherboard is using a VIA Apollo VPX chipset, names from /proc/pci:
Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] (rev 35).
ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 65).
IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 6).
USB Controller: VIA Technologies, Inc. USB (rev 2).
Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI (rev 16).

My kernel is vanilla 2.4.21 with grsecurity patches.

The problem is pretty similar to one already reported on LKML: 
http://lkml.org/lkml/2003/12/19/173. That problem was triggered by
writes to USB disk, also plugged to VIA Apollo USB controller. Because
of that I think, that my problem isn't in DSL modem drivers.

What can I do to solve this problem? Thanks.

-- 
 _____ _ _ _   
|_   _(_) | |__ | Marek "Tilk" Materzok - ICQ 70650849 - GG 1543661  |
  | | | | | / / | Mail,Jabber: tilk@lucifer.czad.org - linux.gery.pl |
  |_| |_|_|_\_\ |  --  Linux - Where Don't We Want To Go Today?  --  |

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCS d- s: a--- C++ UL+++$ P-- L+++>++++$ E- W++ N+ o? K? w--- O? M? V?
PS+ PE- Y+ PGP+ !t 5? X R* tv b+ DI+ D G e- h! !r y- 
------END GEEK CODE BLOCK------
