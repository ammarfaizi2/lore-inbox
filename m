Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTFYGcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTFYGcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 02:32:12 -0400
Received: from [64.65.189.210] ([64.65.189.210]:51928 "EHLO
	mail.pacrimopen.com") by vger.kernel.org with ESMTP id S262011AbTFYGcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 02:32:10 -0400
Subject: ACPI 100002 IRQ 9 problem.
From: Joshua Schmidlkofer <menion@asylumwear.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1056523589.2023.38.camel@menion.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 24 Jun 2003 23:46:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

   First is there a different list for ACPI questions?

   For the sake of disclosure, the dump I am reporting is 2.5.73, plus
the Davide Libenzis' SiS-96x patch.  I also am currently using the
nvidia driver, I was able to reproduce this in vanilla 2.5.72 (no
nvidia), and I will try tomorrow with a vanilla setup of 2.5.73-bk3.
[unless bk4 is available].

   I have a Soyo P4S-645D, with the SiS 645 chipset.  I have had some
problems w/ the IRQ routing, but 2.5.7[123] have sorted it out (mostly) 
I am having problems ACPI, it is better if I say 'pci=noacpi', but what
happens is when the ACPI interrupt count hit 100002, then I get the
following message on all consoles:

menion kernel: Disabling IRQ #9


Then, I have the following as part of dmesg:

Call Trace: [<c010cad4>]  [<c010cbad>]  [<c010ce46>]  [<c010880e>] 
[<c010880e>]  [<c010b320>]  [<c010880e>]  [<c010880e>]  [<c0108832>] 
[<c010889a>]  [<c0105000>]  [<c041c6bd>]  [<c041c41e>]
[<c0247446>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c010cad4 <__report_bad_irq+2a/7a>
Trace; c010cbad <note_interrupt+6f/a0>
Trace; c010ce46 <do_IRQ+130/140>
Trace; c010880e <default_idle+0/28>
Trace; c010880e <default_idle+0/28>
Trace; c010b320 <common_interrupt+18/20>
Trace; c010880e <default_idle+0/28>
Trace; c010880e <default_idle+0/28>
Trace; c0108832 <default_idle+24/28>
Trace; c010889a <cpu_idle+2e/38>
Trace; c0105000 <_stext+0/0>
Trace; c041c6bd <start_kernel+175/19c>
Trace; c041c41e <unknown_bootoption+0/fc>
Trace; c0247446 <acpi_irq+0/16>

If I say 'pci=noacpi' it take about 20 minutes. The ACPI interrupt count
begins at a reasonable low number and climbs over the course of 20
minutes.

If i don't add the pci line, then I start out w/ ACPI interrupt count at
100000 interrupt count, and about 5 - 10 minutes later, I get 2 ACPI
interrupts and then the message follows.

SiS 645 chipset
P4 2.4 gig
PC2700 ram
3 HD's, 2 CDRW's.
NVidia Geforce4, w/ and w/o binary driver.[4363 + www.minion.de patches]

RedHat 8.0, gcc 3.2, 2.5.72 & 2.5.73.  

2.5.73 only verified w/ NVIDIA driver, not w/o.  



