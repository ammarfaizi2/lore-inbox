Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWDQNBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWDQNBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWDQNBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:01:17 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:44512 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S1750763AbWDQNBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:01:17 -0400
Date: Mon, 17 Apr 2006 15:00:55 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
cc: Randy Dunlap <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andre Hedrick <andre@linux-ide.org>,
       Manfred Spraul <manfreds@colorfullife.com>, Alan Cox <alan@redhat.com>,
       Kamal Deen <kamal@kdeen.net>
Subject: irqbalance mandatory on SMP kernels? 
Message-ID: <Pine.LNX.4.44.0604171438490.14894-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.3 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I noticed that the latest editions of RedHat EL 4.3 and direct
descendants today need a program called irqbalance to activate
true SMP IRQ load balancing for your machine's hardware.

If one boots a SMP kernel (2.4.xx or 2.6.xx) kernel on a machine
which either has 2 or more physical CPU's (also dual-core CPU's) 
, and one does not start up the irqbalance util from the
kernel-utils package ( see e.g. 

ftp://ftp.nluug.nl/pub/os/Linux/distr/RedHat/ftp/redhat/linux/updates/enterprise/4Desktop/en/os/SRPMS/kernel-utils-2.4-13.1.80.src.rpm

) Then basicly your SMP kernel falls back to a ordinary MP kernel and
we see this happening :

[jackson:stock]:(/usr/src/linux)$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    3139568          0    IO-APIC-edge  timer
  1:       8923          0    IO-APIC-edge  i8042
  3:         10          0    IO-APIC-edge  serial
  4:         37          0    IO-APIC-edge  serial
  8:          0          0    IO-APIC-edge  rtc
  9:        240          0   IO-APIC-level  acpi
 12:      75316          0    IO-APIC-edge  i8042
 14:      64291          0    IO-APIC-edge  ide0
 15:      64291          0    IO-APIC-edge  ide1
 16:     235408          0   IO-APIC-level  HiSax, nvidia
 17:      15823          0   IO-APIC-level  libata, AMD AMD8111
 19:        241          0   IO-APIC-level  ohci_hcd, ohci_hcd, ohci1394
 24:      50761          0   IO-APIC-level  eth0
NMI:         89         28 
LOC:    3139042    3139125 
ERR:          0
MIS:          0
[jackson:stock]:(/usr/src/linux)$ 

Only when firing up the irqbalance util at boot time will activate
true SMP, distributing IRQ's across CPU's. Is this on purpose?
Because afaik a Linux SMP kernel, 2.4.xx or 2.6.xx should always
result in distributed IRQ loads across CPU's.

Regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

