Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUITWQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUITWQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUITWQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:16:29 -0400
Received: from mail.gmx.de ([213.165.64.20]:9643 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267377AbUITWQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:16:24 -0400
Date: Tue, 21 Sep 2004 00:16:23 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "lkml " <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <27351.1095718583@www35.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for the scrambled reply,
i'm not subscribed
(please add me to the CC list)

in reply to:
-----------------------
List:       linux-kernel
Subject:    Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
From:       Shane Shrybman <shrybman () aei ! ca>
Date:       2004-09-20 21:16:07
Message-ID: <1095714967.3646.14.camel () mars>
[Download message RAW]

I am having what appears to be IDE DMA problems with 2.6.9-rc2-mm1-S1.
2.6.9-rc2-mm1 does not show this problem and runs fine. Before this I
was happily using 2.6.8-rc3-O5.

I tried booting with acpi=off but was unable to enter my user name at
the login prompt, it just hung with no response to sysreq. I also tried
turning off irq threading for that irq but it made no difference.

There is one drive on the secondary channel of this Promise TX133. This
is what appears in the log after a minute or two of using the drive.

hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
hdg: DMA interrupt recovery
hdg: lost interrupt
hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
hdg: DMA interrupt recovery
hdg: lost interrupt
hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
[..many repeats..]

......
---------------------------------------

i'm getting the same problem
(although not sure if the dma status was the same)
if i enable hardirq preemption
turning acpi on/off doesn't change anything
io/up apic is on (haven't tried disabling it)

with hardirq preemption disabled in .config
everything looks fine sofar (~5h )


-----------------------------
  666 root      16 -10     0    0    0 S  0.0  0.0   0:00.00 IRQ 17
  670 root      15 -10     0    0    0 S  0.0  0.0   0:00.00 IRQ 14
  673 root      15 -10     0    0    0 S  0.0  0.0   0:00.00 IRQ 15
  711 root      25   0     0    0    0 S  0.0  0.0   0:00.23 khubd
  712 root      16 -10     0    0    0 S  0.0  0.0   0:00.00 IRQ 21

----------------------------
this puzzles me a bit
aren't those hardirqs ?
why are they listed as threads, in case i compiled
with 
----------------
[svetljo@svetljo rc2mm1]$ grep PREEMPT .config
# CONFIG_PREEMPT_TIMING is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT_SOFTIRQS=y
# CONFIG_PREEMPT_HARDIRQS is not set
----------------

best,

svetljo
PS.

PC is up amd xp 2700 KT400 VT8235 (Epox 8k9A3+)
[svetljo@svetljo rc2mm1]$ cat /proc/interrupts
           CPU0
  0:   20809263    IO-APIC-edge  timer
  2:          0          XT-PIC  cascade
 14:        516    IO-APIC-edge  ide4
 15:        478    IO-APIC-edge  ide5
 16:    1763130   IO-APIC-level  radeon@pci:0000:01:00.0
 17:     894337   IO-APIC-level  ide0, ide2, ide3, eth0
 18:      59771   IO-APIC-level  EMU10K1
 21:    1120812   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd, ehci_hcd
 23:    2395783   IO-APIC-level  eth1
NMI:          0
LOC:   20810017
ERR:          0
MIS:        485

-- 
+++ GMX DSL Premiumtarife 3 Monate gratis* + WLAN-Router 0,- EUR* +++
Clevere DSL-Nutzer wechseln jetzt zu GMX: http://www.gmx.net/de/go/dsl

