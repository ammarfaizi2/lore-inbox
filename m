Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273934AbRIRVNl>; Tue, 18 Sep 2001 17:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273932AbRIRVNc>; Tue, 18 Sep 2001 17:13:32 -0400
Received: from forge.redmondlinux.org ([209.81.49.42]:35559 "EHLO
	forge.redmondlinux.org") by vger.kernel.org with ESMTP
	id <S273929AbRIRVM0>; Tue, 18 Sep 2001 17:12:26 -0400
Message-ID: <3BA7B849.4010104@cheek.com>
Date: Tue, 18 Sep 2001 14:10:33 -0700
From: Joseph Cheek <joseph@cheek.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Steven Walter <srwalter@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ide-]scsi timeouts while writing cdrom
In-Reply-To: <Pine.LNX.4.10.10109142131030.28176-100000@forge.redmondlinux.org> <20010915122542.A23825@hapablap.dyn.dhs.org> <3BA79F09.9060509@cheek.com> <20010918160040.A27239@hapablap.dyn.dhs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

piix4.  this is an older p2/350 udma-33 machine.

Sep 18 08:58:22 sanfrancisco kernel: block: queued sectors max/low 
169288kB/56429kB, 512 slots per queue
Sep 18 08:58:22 sanfrancisco kernel: RAMDISK driver initialized: 16 RAM 
disks of 4096K size 1024 blocksize
Sep 18 08:58:22 sanfrancisco kernel: Uniform Multi-Platform E-IDE driver 
Revision: 6.31
Sep 18 08:58:22 sanfrancisco kernel: ide: Assuming 33MHz system bus 
speed for PIO modes; override with idebus=xx
Sep 18 08:58:22 sanfrancisco kernel: PIIX4: IDE controller on PCI bus 00 
dev a1
Sep 18 08:58:22 sanfrancisco kernel: PIIX4: chipset revision 1
Sep 18 08:58:22 sanfrancisco kernel: PIIX4: not 100%% native mode: will 
probe irqs later
Sep 18 08:58:22 sanfrancisco kernel:     ide0: BM-DMA at 0x10e0-0x10e7, 
BIOS settings: hda:DMA, hdb:DMA
Sep 18 08:58:22 sanfrancisco kernel:     ide1: BM-DMA at 0x10e8-0x10ef, 
BIOS settings: hdc:DMA, hdd:DMA
Sep 18 08:58:22 sanfrancisco kernel: hda: IBM-DJNA-370910, ATA DISK drive
Sep 18 08:58:22 sanfrancisco kernel: hdb: QUANTUM FIREBALL EX12.7A, ATA 
DISK drive
Sep 18 08:58:22 sanfrancisco kernel: hdc: LITE-ON LTR-12101B, ATAPI 
CD/DVD-ROM drive
Sep 18 08:58:22 sanfrancisco kernel: hdd: Compaq CRD-8322B, ATAPI 
CD/DVD-ROM drive
Sep 18 08:58:22 sanfrancisco kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep 18 08:58:22 sanfrancisco kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep 18 08:58:22 sanfrancisco kernel: hda: 17773500 sectors (9100 MB) 
w/1966KiB Cache, CHS=18807/15/63, UDMA(33)
Sep 18 08:58:22 sanfrancisco kernel: hdb: 24901632 sectors (12750 MB) 
w/418KiB Cache, CHS=26350/15/63, UDMA(33)
Sep 18 08:58:22 sanfrancisco kernel: Partition check:
Sep 18 08:58:22 sanfrancisco kernel:  hda: [PTBL] [1175/240/63] hda1 
hda2 hda3 hda4
Sep 18 08:58:22 sanfrancisco kernel:  hdb: [EZD] [remap 0->1] 
[1550/255/63] hdb1 hdb2

Steven Walter wrote:

>What chipset are you using?
>
>On Tue, Sep 18, 2001 at 12:22:49PM -0700, Joseph Cheek wrote:
>
>>cool, i turned off DMA on both cd's and it works now!  i still get 
>>timeouts but not enough to crash the system.
>>
>>Steven Walter wrote:
>>
>>>With what drive chipset is this?
>>>
>>>In any event, try doing an 'hdparm -d0 /dev/hdd' and see if that fixes
>>>it.  That will turn off DMA on the CD-RW, which is probably causing the
>>>trouble.  If not, see if turning off DMA on /all/ the drives fixes it.
>>>
>>>I had a problem similar to this on my system, with an AMD-751 ide
>>>controller.  To fix it, all I had to do was turn on CONFIG_EXPERIMENTAL
>>>and then "AMD Viper ATA-66 Override (WIP)".  After that, the problem
>>>went away.
>>>
>>>On Fri, Sep 14, 2001 at 09:36:26PM -0700, Joseph Cheek wrote:
>>>
>>>>hello all,
>>>>
>>>>my shiny new cdrw hangs the system when i try to burn a cdrom.  i've got a
>>>>a completely IDE system.  hda and hdb are hard drives while hdc is a
>>>>standard cdrom and hdd is a cdrw.
>>>>
>>>>while burning cdrecord writes a couple of tracks and then the whole system
>>>>freezes [i need to hard power off].  i can blank cdrw's in the drive just
>>>>fine, however.  i'm running 2.4.9-ac10 SMP [on a single-proc system] and
>>>>all partitions are ext3.  ide-scsi is loaded as a module at boot.
>>>>
>>>>here's what /var/log/messages shows:
>>>>
>>>>Sep 14 21:12:45 sanfrancisco kernel: scsi : aborting command due to
>>>>timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x00 00 00 00 00 00
>>>>Sep 14 21:12:54 sanfrancisco kernel: Device not ready.  Make sure there is
>>>>a disc in the drive.
>>>>Sep 14 21:12:55 sanfrancisco last message repeated 2 times
>>>>Sep 14 21:13:20 sanfrancisco kernel: hdb: timeout waiting for DMA
>>>>Sep 14 21:13:20 sanfrancisco kernel: ide_dmaproc: chipset supported
>>>>ide_dma_timeout func only: 14
>>>>Sep 14 21:13:26 sanfrancisco kernel: scsi : aborting command due to
>>>>timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x43 00 00 00 00 00 00 00
>>>>0c 00
>>>>Sep 14 21:13:37 sanfrancisco kernel: scsi : aborting command due to
>>>>timeout : pid 0, scsi0, channel 0, id 0, lun 0 0x2a 00 00 00 05 92 00 00
>>>>1f 00
>>>>Sep 14 21:13:37 sanfrancisco kernel: hdc: timeout waiting for DMA
>>>>Sep 14 21:13:37 sanfrancisco kernel: ide_dmaproc: chipset supported
>>>>ide_dma_timeout func only: 14
>>>>Sep 14 21:13:37 sanfrancisco kernel: hdd: status timeout: status=0xd8 {
>>>>Busy }
>>>>Sep 14 21:13:37 sanfrancisco kernel: hdd: DMA disabled
>>>>Sep 14 21:13:37 sanfrancisco kernel: hdd: drive not ready for command
>>>>Sep 14 21:13:41 sanfrancisco kernel: hdd: ATAPI reset complete
>>>>Sep 14 21:13:41 sanfrancisco kernel: hdd: irq timeout: status=0xd0 { Busy
>>>>}
>>>>Sep 14 21:13:42 sanfrancisco kernel: hdd: ATAPI reset complete
>>>>Sep 14 21:13:42 sanfrancisco kernel: hdd: irq timeout: status=0x80 { Busy
>>>>}
>>>>Sep 14 21:13:42 sanfrancisco kernel: scsi0 channel 0 : resetting for
>>>>second half of retries.
>>>>Sep 14 21:13:42 sanfrancisco kernel: SCSI bus is being reset for host 0
>>>>channel 0.
>>>>
>>>>any guesses?
>>>>
>>>>thanks!
>>>>
>>>>joe
>>>>
>>>>-
>>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>>the body of a message to majordomo@vger.kernel.org
>>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>


