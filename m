Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131489AbRCQBou>; Fri, 16 Mar 2001 20:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRCQBok>; Fri, 16 Mar 2001 20:44:40 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:40456
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130902AbRCQBoZ>; Fri, 16 Mar 2001 20:44:25 -0500
Date: Fri, 16 Mar 2001 17:43:36 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: CODEZ <DACODECZ_KERN@PHREAKER.NET>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE poweroff -> hangup
In-Reply-To: <009e01c0ae7c$bd441fb0$20add6d2@ninzazrouter>
Message-ID: <Pine.LNX.4.10.10103161733330.15955-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2001, CODEZ wrote:

> Andrew wrote.........

Oh and and it is "Andre" with an accent grav....

> > All of the 440*X Chipsets using a PIIX4/PIIX4AB/PIIX4EB are broken beyond
> > repair.  Several weeks ago, the old hat and I discussed the issue and
> > after sending him the same docs I have from Intel, we both laugh because
> > the errata clear states "NO FIX"
> 
> 
> Well andrew,
> I yet have to find something like absolute perfect in the technology domain,
> me agree with you that the following chipsets are broken but then there
> is'nt any for which any of us can claim that it'z not broken or will not in
> sometimez in future, anyway here is some information that i think guruz
> dealing with ATA development must know about it to bring sanity of those who
> are not guruz.

I try but I see one of us missed the boat....

> At the time of  (e-ide) driver initialisation
> (LOG)
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 21
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
> hda: ST317221A, ATA DISK drive
> hdc: CRD-8480M, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 33683328 sectors (17246 MB) w/512KiB Cache, CHS=2096/255/63, UDMA(33)
> *hmmmmm why this*
> hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hdc: set_drive_speed_status: error=0xb4
> hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> 
> After pokin through the /proc/ide/*/hdx/settings i found....
> 
> name   value  min  max  mode
> ----   -----  ---  ---  ----
> breada_readahead        4               0               127             rw
> current_speed           66              0               69              rw

Just maybe if you did some math!

66 == 0x42	that is Ultra 33

64 == 0x40	that is Ultra 16
65 == 0x41	that is Ultra 25
66 == 0x42	that is Ultra 33
67 == 0x43	that is Ultra 44
68 == 0x44	that is Ultra 66
69 == 0x45	that is Ultra 100

> *check this*
> dsc_overlap             0               0               1               rw
> file_readahead          0               0               2097151         rw
> ide_scsi                0               0               1               rw
> init_speed              66              0               69              rw

Did it not occur to you that a max speed of Ultra 69 is stupid??

> *check this*
> io_32bit                0               0               3               rw
> keepsettings            0               0               1               rw
> max_kb_per_request      64              1               127             rw
> nice1                   1               0               1               rw
> number                  2               0               3               rw
> pio_mode                write-only      0               255             w
> slow                    0               0               1               rw
> unmaskirq               0               0               1               rw
> using_dma               1               0               1               rw
> 
> AFAIK inetl's 82371AB chipset never supported UDMA 66 mode then why driver
> initialised it like this...
> Right now i placed a line somewhere in my rc.sysinit script
> hdpatm -d1 -X34 /dev/hdX to reslove the dead lock i was facing whenever

Oh....

34 == 0x22	MultiWord DMA mode 2
33 == 0x21	MultiWord DMA mode 1
32 == 0x20	MultiWord DMA mode 0

18 == 0x12	SingleWord DMA mode 2
17 == 0x11	SingleWord DMA mode 1
16 == 0x10	SingleWord DMA mode 0

Just maybe you can see that the timings for HEX represented values are ==

	8421:8421
	RUMS:yyyy

R == Reserved
U == Ultra
M == MultiWord
S == SingleWord

> tried to mount the specified drive.
> 
> Any suggestion........

Read before blowing heat, I wear asbestos!

> Regardz
> daCodez
> 
> 
> ****************************************************************************
> ******************
> Simplicity is the only comlexity I know about.
> 
> 
> 
> 
> 
> 

Andre Hedrick
Linux ATA Development

