Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282965AbRK0VLs>; Tue, 27 Nov 2001 16:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282957AbRK0VLj>; Tue, 27 Nov 2001 16:11:39 -0500
Received: from ulima.unil.ch ([130.223.144.143]:2689 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S282944AbRK0VL1>;
	Tue, 27 Nov 2001 16:11:27 -0500
Date: Tue, 27 Nov 2001 22:11:13 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't acess ide ZIP under 2.4.16 with devfs
Message-ID: <20011127221113.A14806@ulima.unil.ch>
In-Reply-To: <20011127202112.A13757@ulima.unil.ch> <3C03FEC5.3000003@paulbristow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C03FEC5.3000003@paulbristow.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 09:59:49PM +0100, Paul Bristow wrote:
> Gregoire,
> 
> I'm working (right this minute) on devfs support for ide-floppy
> 
> but... your problem doesn't look like an ide-floppy/devfs problem.
> 
> On my system, the output from fdisk on a zip 250 looks like
> 
>  [root@zoltar ide]# fdisk /dev/hdf
> 
>   Command (m for help): p
> 
>   Disk /dev/hdf: 64 heads, 32 sectors, 239 cylinders
>   Units = cylinders of 2048 * 512 bytes
> 
>      Device    Boot    Start       End    Blocks   Id  System
>      /dev/hdf4   *         1       239    244720    6  FAT16

Well, I have of course tried this (not in fstab, but in
sudo mount -t ext3 /dev/ide/host0/bus1/target0/lun0/disc /mnt/ext2/

My ZIP 250 isn't shown at all correctly: all infos are the one from my
first HD hda... even if I call /dev/hdc or
/dev/ide/host0/bus1/target0/lun0/disc...

If that's could help, some more infos:

Nov 27 19:21:08 localhost kernel: Real Time Clock Driver v1.10e
Nov 27 19:21:08 localhost kernel: block: 128 slots per queue, batch=32
Nov 27 19:21:08 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Nov 27 19:21:08 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Nov 27 19:21:08 localhost kernel: PIIX4: IDE controller on PCI bus 00 dev 21
Nov 27 19:21:08 localhost kernel: PIIX4: chipset revision 1
Nov 27 19:21:08 localhost kernel: PIIX4: not 100%% native mode: will probe irqs later
Nov 27 19:21:08 localhost kernel: hda: IBM-DTTA-371440, ATA DISK drive
Nov 27 19:21:08 localhost kernel: hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
Nov 27 19:21:08 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 27 19:21:08 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 27 19:21:08 localhost kernel: hda: 28229040 sectors (14453 MB) w/462KiB Cache, CHS=1757/255/63
Nov 27 19:21:08 localhost kernel: ide-floppy driver 0.97.sv
Nov 27 19:21:08 localhost kernel: hdc: 244766kB, 489532 blocks, 512 sector size
Nov 27 19:21:08 localhost kernel: hdc: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
Nov 27 19:21:08 localhost kernel: hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664Nov 27 19:21:08 localhost kernel: Partition check:
Nov 27 19:21:08 localhost kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
Nov 27 19:21:08 localhost kernel:  /dev/ide/host0/bus1/target0/lun0: unknown partition table
Nov 27 19:21:08 localhost kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html

[root@localhost root]# hdparm -I /dev/hdc

/dev/hdc:

non-removable ATA device, with non-removable media
        Model Number:           IBM-DTTA-371440                         
        Serial Number:                   WK0WKG05742
        Firmware Revision:      T71OA73A
Standards:
        Used: ATA/ATAPI-4 T13 1153D revision 17 
        Supported: 1 2 3 4 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 28229040
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 462.0kB    ECC bytes: 34   Queue depth: 32
        Standby timer values: spec'd by standard, no device specific minimum
        r/w multiple sector transfer: Max = 16  Current = 0
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                release interrupt
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    READ/WRITE DMA QUEUED
Security: 
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        28min for SECURITY ERASE UNIT. 

[root@localhost root]# hdparm -I /dev/hda

Gives the same...

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
