Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTF2UCK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTF2UCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:02:10 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:30701 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S263990AbTF2UCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:02:03 -0400
Subject: [2.5.73] What causes this high interrupt count?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1056917780.4001.16.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 29 Jun 2003 22:16:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.5.73 with ACPI enabled on my P4 HT system irq 18 seems to be
very busy:
           CPU0       CPU1
  0:     633529      76869    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  9:          0          0   IO-APIC-level  acpi
 14:      12139          0    IO-APIC-edge  ide0
 15:          2          0    IO-APIC-edge  ide1
 16:      58707          0   IO-APIC-level  uhci-hcd, uhci-hcd, nvidia
 17:      56840          0   IO-APIC-level  Intel ICH5
 18:   88494437   48181320   IO-APIC-level  ide2, uhci-hcd
 19:      15975          0   IO-APIC-level  uhci-hcd
 20:        183          0   IO-APIC-level  ohci1394
 21:       1647          0   IO-APIC-level  eth0
 23:         68          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:     710285     710628
ERR:          0
MIS:          0

ide2 is the onboard Intel SATA (ICH5) controller. I am not sure what is
causing these interrupts.

Top shows a lot of CPU load being generated caused by the high interrupt
count:

81 processes: 80 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:   2.0% user  58.0% system    0.0% nice   0.0% iowait  40.0%
idle
CPU1 states:   3.0% user   0.0% system    0.0% nice   0.0% iowait  97.0%
idle
Mem:   515480k av,  198452k used,  317028k free,       0k shrd,   14760k
buff
       122252k active,              50596k inactive
Swap:  787176k av,       0k used,  787176k free                   94040k
cached

I've had the same problem with 2.4.21 plus a recent ACPI. What can be
the culprit?

Cheers,

Jurgen


