Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFJQk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFJQk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVFJQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:40:58 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:51110 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261300AbVFJQk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:40:27 -0400
Date: Fri, 10 Jun 2005 11:43:34 -0500
From: Wes Newell <w.newell@verizon.net>
Subject: [Re: sis5513.c patch]
To: linux-kernel@vger.kernel.org
Message-id: <42A9C336.9090905@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jun 2005 09:16:44 +0000, Bartlomiej Zolnierkiewicz wrote:

> On 6/8/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>> On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
>> > Bartlomiej Zolnierkiewicz wrote:
>> > > On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
>> > >
>> > >>I'm not sure if a similar patch has been submitted or not, but here is a
>> > >>patch to get DMA working on ASUS K8S-MX with a SiS 760GX/SiS 965L
>> > >>chipset combo.
>> > >
>> > >
>> > > This patch is incorrect, it adds PCI ID of SiS IDE controller (this ID
>> > > is common for almost all SiS IDE controllers and is already present in
>> > > sis5513_pci_tbl[]) to the table of SiS Host PCI IDs.  As a result driver
>> > > will try to use ATA_133 on all _unknown_ IDE controllers.  You need
>> > > to add PCI ID of the Host chipset (lspci should reveal it) instead.
> 
> Second look into sis5513.c and another problem turns out - patch breaks 
> support for IDE controllers integrated into 961 and 961B South Bridges
> (ATA_133 is used instead of ATA_100 and ATA133a).
> 
> For unknown Host Bridges driver checks for presence of 961/961B/962/963
> South Bridges by checking true device ID (please see sis5513.c for details) 
> and assigns 'chipset_family' accordingly (ATA_100/ATA_133a or ATA_133).
> 
> You have 965L South Bridge so probably it has newer true device ID 
> and  may also require different programming sequence.
> 
>> Could you please send full lspci -vvv output?
> 
> and lspci -xxx
> 
I've been looking for pata support for the SIS180. If you can handle that
or tell me how i might get it, I'd be interested. Here's the revevant
output.

00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID bus 
controller 180 SATA/PATA  [SiS] (prog-if 85)
         Subsystem: Silicon Integrated Systems [SiS] RAID bus controller 
180 SATA/PATA  [SiS]
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at dc00 [size=8]
         Region 1: I/O ports at e000 [size=4]
         Region 2: I/O ports at e400 [size=8]
         Region 3: I/O ports at e800 [size=4]
         Region 4: I/O ports at ec00 [size=16]
         Region 5: I/O ports at <unassigned>
         Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID bus 
controller 180 SATA/PATA  [SiS]
00: 39 10 80 01 07 04 20 02 00 85 04 01 00 80 00 00
10: 01 dc 00 00 01 e0 00 00 01 e4 00 00 01 e8 00 00
20: 01 ec 00 00 01 00 00 00 00 00 00 00 39 10 80 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 56 23 06 04 56 23 06 04 00 00 00 00 00 00 00 00
50: 82 20 82 00 2a 96 00 03 00 00 00 00 00 00 00 00
60: ff aa 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: bd 33 72 40 bd 33 72 40 00 00 00 00 00 00 00 00
90: 08 00 00 03 4f 14 00 00 cc 04 0c 10 c0 05 c0 05
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 01 00 18 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 00 18 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


I guess sata_sis is not going to support the pata drives. I've tried
the ones from sis too. This is a real SIS180 on a Jetway S755MAX. Any
chance in hell of getting a driver for the pata ports on this thing? I
tried patching and renaming sis5513.c and got it to compile into a kernel
as a module (s180ata) after putting it in kconfig, but It didn't work. I'm
obviously drowning not being a C programmer. I think it conflicted with
the real sis5513 for one thing.:-)

