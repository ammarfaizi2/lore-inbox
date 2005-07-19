Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVGSLuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVGSLuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 07:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGSLuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 07:50:15 -0400
Received: from office.servervault.com ([216.12.128.136]:19106 "EHLO
	mail1.dulles.sv.int") by vger.kernel.org with ESMTP id S261201AbVGSLuN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 07:50:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Suddenly getting APIC errors on SMP system using 2.4.20-8smp, mobo dying?
Date: Tue, 19 Jul 2005 07:50:12 -0400
Message-ID: <F8B974E70BDE1745ABB27AF04788FA0099883E@mail1.dulles.sv.int>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Suddenly getting APIC errors on SMP system using 2.4.20-8smp, mobo dying?
Thread-Index: AcWMWAVelOMCiXDmRwmgsyqgI15bKg==
From: "Piszcz, Justin" <jpiszcz@servervault.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From the archives:

-----------

http://lkml.org/lkml/2003/5/18/64 (the problem we are having)

The response to him:

"You're getting a lot of receive and send (checksum and accept) errors
and 
as a result invalid vectors being sent to your processors, your APIC bus

is seeing a lot of data corruption, looks like your motherboard might be

on it's way out. Try running with 'noapic' to see if it's the IOAPIC or 
local APICs (my bet is on the IOAPIC which would be on your motherboard 
chipset)"

----------

Is my box/motherboard "on its way out" as well?
Is there any additional tests I can run to debug the problem?
Please cc me as I am not on the list.

I am not getting the vector/IRQ trap problems, but I am getting these:

APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(02)
APIC error on CPU1: 02(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(01)
APIC error on CPU0: 02(02)
APIC error on CPU1: 01(02)
APIC error on CPU0: 02(02)

$ cat /proc/interrupts
           CPU0       CPU1
  0: 2188238756 2133947687    IO-APIC-edge  timer
  1:       1303        761    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 14:   15784472   15773627    IO-APIC-edge  ide0
 16:          8          7   IO-APIC-level  aic7xxx
 17:          8          7   IO-APIC-level  aic7xxx
 23: 1070343095 1070235174   IO-APIC-level  eth1
 26:   63761814   63781213   IO-APIC-level  gdth
 27:   61990600   61958787   IO-APIC-level  eth2
NMI:          0          0
LOC:   27007773   27007830
ERR:        272
MIS:          0

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
215IIC [Mach64 GT IIC] (rev 7a)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
00:06.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT
6113RS/6513RS
00:07.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
01:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0d)
01:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0d)
02:04.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:04.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

# lsmod
Module                  Size  Used by    Not tainted
nls_iso8859-1           3516   0  (autoclean)
vfat                   13196   0  (autoclean)
fat                    40088   0  (autoclean) [vfat]
ide-cd                 35772   0  (autoclean)
cdrom                  34176   0  (autoclean) [ide-cd]
nfsd                   81104   8  (autoclean)
lockd                  59536   1  (autoclean) [nfsd]
sunrpc                 87516   1  (autoclean) [nfsd lockd]
e100                   62340   2
ext3                   73376   3
jbd                    56336   3  [ext3]
aic7xxx               142548   0
gdth                   83968   4
sd_mod                 13452   8
scsi_mod              110488   3  [aic7xxx gdth sd_mod]
