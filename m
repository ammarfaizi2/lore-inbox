Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130831AbQJ1FbT>; Sat, 28 Oct 2000 01:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130915AbQJ1FbA>; Sat, 28 Oct 2000 01:31:00 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:27652
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130831AbQJ1Far>; Sat, 28 Oct 2000 01:30:47 -0400
Date: Fri, 27 Oct 2000 22:30:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Hisaaki Shibata <shibata@luky.org>
cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001028141056T.shibata@luky.org>
Message-ID: <Pine.LNX.4.10.10010272223240.14599-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hdparm -r0 /dev/hdc

smsc:/proc/ide/hdc # cat model driver media
MATSHITADVD-RAM LF-D210
ide-cdrom version 4.99
cdrom

smsc:/proc/ide/hdc # hdparm -r0 /dev/hdc

/dev/hdc:
 setting readonly to 0 (off)
 readonly     =  0 (off)

smsc:/ # mke2fs -b 2048 /dev/hdc -m 0
mke2fs 1.18, 11-Nov-1999 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=2048 (log=1)
Fragment size=2048 (log=1)
561152 inodes, 2236704 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
137 block groups
16384 blocks per group, 16384 fragments per group
4096 inodes per group
Superblock backups stored on blocks:
        16384, 49152, 81920, 114688, 147456, 409600, 442368, 802816, 1327104,
        2048000

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

That is how it is DONE!

On Sat, 28 Oct 2000, Hisaaki Shibata wrote:

> Hello
> 
> I did patch 2.2.17 tree with dvd-ram-2217p17.diff.bz2.
> 
> At that time, following patch is rejected.
> I think these lines should be removed from patchs.
> 
> 	@@ -1329,7 +1369,7 @@
> 	 static
> 	  void cdrom_sleep (int time)
> 	   {
> 	   -       current->state = TASK_INTERRUPTIBLE;
> 	   +       __set_current_state(TASK_INTERRUPTIBLE);
> 	           schedule_timeout(time);
> 	    }
> 
> After removing these, I could make bzImage.
> 
> But I could not mkudf nor mkext2fs to my ATAPI 9.4GB new DVD-RAM drive.
> 
> dmesg shows;
> --------------------------------------------------------------------------
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> PDC20262: IDE controller on PCI bus 00 dev 60
> PDC20262: chipset revision 1
> PDC20262: not 100% native mode: will probe irqs later
> PDC20262: ROM enabled at 0xe7000000
> PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> PDC20262: FORCING PRIMARY MODE BIT 0x00 -> 0x01 MASTER
> PDC20262: FORCING SECONDARY MODE BIT 0x00 -> 0x01 MASTER
>     ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
> hdc: HITACHI DVD-RAM GF-2000, ATAPI CDROM drive
> hde: IBM-DTLA-305020, ATA DISK drive
> hdg: IBM-DTLA-305020, ATA DISK drive
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xdc00-0xdc07,0xe002 on irq 16
> ide3 at 0xe400-0xe407,0xe802 on irq 16
> hde: IBM-DTLA-305020, 19623MB w/380kB Cache, CHS=39870/16/63, UDMA(66)
> hdg: IBM-DTLA-305020, 19623MB w/380kB Cache, CHS=39870/16/63, UDMA(66)
> 
> [SNIP]
> 
> hdc: ATAPI DVD-ROM DVD-RAM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> VFS: Disk change detected on device ide1(22,0)
> Uniform CD-ROM driver unloaded
> --------------------------------------------------------------------------
> 
> /proc/ide/hdc/media shows;
> cdrom
> 
> How can I read/write DVD-RAM media like MO drive?
> 
> I can read/write ATAPI 5.2GB DVD-RAM media with 2.2.16 ide-scsi mode in ext2fs.
> 
> Best Regards,
> 
> 
> > I've put up patches for 2.2 and 2.4 adding native ATAPI dvd-ram support.
> > The 2.2 patch is completely untested, but the 2.4 version appears to
> > work well.
> > 
> > *.kernel.org/pub/linux/kernel/people/axboe/dvdram
> 
> -- 
>  WWWWW  shibata@luky.org
>  |O-O|  Hisaaki Shibata
> 0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
>    ~    http://his.luky.org/ last update:2000.3.12
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
The Linux ATA/IDE guy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
