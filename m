Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUF1MsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUF1MsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 08:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUF1MsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 08:48:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:34766 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264929AbUF1MsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 08:48:17 -0400
From: Patrick Dreker <patrick@dreker.de>
To: linux-kernel@vger.kernel.org
Subject: IDE Timeout problem on Intel PIIX3 (Triton 2) chipset
Date: Mon, 28 Jun 2004 14:48:15 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406281448.15725.patrick@dreker.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:55d40479e9cc6e4ab087ddd2b9b4bce4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello...

Any kernel above and including 2.4.21 (including 2.6.5 and 2.6.7, others not 
tested) produces the following errors quite often (once or twice per minute, 
with the corresponding delay) and the harddisk drops out of DMA.

-------------------------------------------------
hda: dma_timer_expiry: dma status == 0x20
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
-----------------------------------------------

I have checked that the drive and cable are OK (tested in another machine) and 
no matter what drive I connect to the IDE controller, they *all* produce the 
above error and drop DMA after some seconds.

Currently I am stuck at kernel version 2.4.20, as any later kernel severely 
degrades the performance of the machine (Pentium Pro 200).

At http://www.uwsg.iu.edu/hypermail/linux/kernel/0304.1/0332.html I found a 
thread which hints that IRQ sharing maybe the culprit, but /proc/interrupts 
shows that the ide interrupt is not shared...

lspci and /proc/interrupts are included at the end of this mail.

What can I do to debug this problem?

Thanks,
Patrick

lspci:
-----------------------
0000:00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
0000:00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 
01)
0000:00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
0000:00:0a.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 2] 
(rev 01)
0000:00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
--------------------------

/proc/interrupts:
-------------------------
           CPU0
  0:   55623224    IO-APIC-edge  timer
  1:          2    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
 10:   59404185   IO-APIC-level  eth1
 11:   64467911   IO-APIC-level  eth0
 14:    9031698    IO-APIC-edge  ide0
NMI:          0
LOC:   55623074
ERR:          0
MIS:      13142
----------------------------

-- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
