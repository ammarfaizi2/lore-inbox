Return-Path: <linux-kernel-owner+w=401wt.eu-S1754605AbWLZAic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbWLZAic (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 19:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbWLZAic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 19:38:32 -0500
Received: from lucidpixels.com ([66.45.37.187]:46123 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754605AbWLZAib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 19:38:31 -0500
Date: Mon, 25 Dec 2006 19:38:29 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.17.13: eth2: TX underrun, threshold adjusted.
Message-ID: <Pine.LNX.4.64.0612251933120.12104@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a dual port Intel NIC on an A-Bit IC7-G; any reason why I get 
these?

[4298634.444000] eth2: TX underrun, threshold adjusted.
[4299146.645000] eth2: TX underrun, threshold adjusted.
[4299146.645000] eth2: TX underrun, threshold adjusted.
[4299147.437000] eth2: TX underrun, threshold adjusted.
[4299147.454000] eth2: TX underrun, threshold adjusted.
[4299149.442000] eth2: TX underrun, threshold adjusted.
[4299155.247000] eth2: TX underrun, threshold adjusted.
[4299159.271000] eth2: TX underrun, threshold adjusted.
[4299165.291000] eth2: TX underrun, threshold adjusted.

I see in the mailing list archives this error was most prevalent in 2.4.

However, it also shows up in 2.6:
http://lkml.org/lkml/2005/6/7/49
http://lkml.org/lkml/2004/5/19/20
http://www.ussg.iu.edu/hypermail/linux/kernel/0506.0/1512.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0405.2/0535.html

I am using the e100 driver, MAC addr commented out with **.

[4294675.208000] eth2: 0000:04:04.0, 00:**:**:**:**:**, IRQ 18.
[4294675.209000]   Receiver lock-up bug exists -- enabling work-around.
[4294675.209000]   Board assembly 711269-003, Physical connectors present: 
RJ45
[4294675.209000]   Primary interface chip i82555 PHY #1.
[4294675.209000]   General self-test: passed.
[4294675.209000]   Serial sub-system self-test: passed.
[4294675.209000]   Internal registers self-test: passed.
[4294675.209000]   ROM checksum self-test: passed (0x24c9f043).
[4294675.211000]   Receiver lock-up workaround activated.
[4294675.211000] ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 23 (level, 
low) -> IRQ 17
[4294675.221000] eth3: 0000:04:05.0, 00:**:**:**:**:**, IRQ 17.
[4294675.222000]   Receiver lock-up bug exists -- enabling work-around.
[4294675.222000]   Board assembly 711269-003, Physical connectors present: 
RJ45
[4294675.222000]   Primary interface chip i82555 PHY #1.
[4294675.222000]   General self-test: passed.
[4294675.222000]   Serial sub-system self-test: passed.
[4294675.222000]   Internal registers self-test: passed.
[4294675.222000]   ROM checksum self-test: passed (0x24c9f043).
[4294675.222000]   Receiver lock-up workaround activated.

I have other boards and I do not recall seeing the message about the 
Receiver lock-up bug, could this be part of the reason for the TX 
underrun?

Does it matter which PCI slot I place this card in?  It is currently right 
next to a PCI 3com 509 (thinnet).

$ cat /proc/interrupts 
           CPU0       CPU1       
  0:    6938534          0    IO-APIC-edge  timer
  1:        205          0    IO-APIC-edge  i8042
  4:      75106          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:       9106          0    IO-APIC-edge  i8042
 14:     157428          2    IO-APIC-edge  ide0
 15:      63295          2    IO-APIC-edge  ide1
 16:    1224358          0   IO-APIC-level  eth0
 17:     171170          0   IO-APIC-level  eth2, eth3
 18:       4017          0   IO-APIC-level  eth1
 19:      68950          0   IO-APIC-level  ide2, ide3
 20:       6090          0   IO-APIC-level  Intel ICH5
NMI:          0          0 
LOC:    6938508    6938562 
ERR:          0
MIS:          0

Would increasing the txqueuelen fix this issue?  Or should I replace the 
NIC to get rid of these messages?

Any help would be much appreciated.

Thanks,

Justin.

