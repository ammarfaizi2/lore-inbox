Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131293AbRCQAsa>; Fri, 16 Mar 2001 19:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131402AbRCQAsV>; Fri, 16 Mar 2001 19:48:21 -0500
Received: from [202.144.76.10] ([202.144.76.10]:16774 "HELO
	inbound3.maa.sify.net") by vger.kernel.org with SMTP
	id <S131293AbRCQAsP>; Fri, 16 Mar 2001 19:48:15 -0500
Message-ID: <009e01c0ae7c$bd441fb0$20add6d2@ninzazrouter>
From: "CODEZ" <DACODECZ_KERN@PHREAKER.NET>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10103142010300.7091-100000@master.linux-ide.org>
Subject: Re: IDE poweroff -> hangup
Date: Sat, 17 Mar 2001 06:23:50 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote.........
> All of the 440*X Chipsets using a PIIX4/PIIX4AB/PIIX4EB are broken beyond
> repair.  Several weeks ago, the old hat and I discussed the issue and
> after sending him the same docs I have from Intel, we both laugh because
> the errata clear states "NO FIX"


Well andrew,
I yet have to find something like absolute perfect in the technology domain,
me agree with you that the following chipsets are broken but then there
is'nt any for which any of us can claim that it'z not broken or will not in
sometimez in future, anyway here is some information that i think guruz
dealing with ATA development must know about it to bring sanity of those who
are not guruz.
At the time of  (e-ide) driver initialisation
(LOG)
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: ST317221A, ATA DISK drive
hdc: CRD-8480M, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 33683328 sectors (17246 MB) w/512KiB Cache, CHS=2096/255/63, UDMA(33)
*hmmmmm why this*
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0xb4
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12

After pokin through the /proc/ide/*/hdx/settings i found....

name   value  min  max  mode
----   -----  ---  ---  ----
breada_readahead        4               0               127             rw
current_speed           66              0               69              rw
*check this*
dsc_overlap             0               0               1               rw
file_readahead          0               0               2097151         rw
ide_scsi                0               0               1               rw
init_speed              66              0               69              rw
*check this*
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      64              1               127             rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

AFAIK inetl's 82371AB chipset never supported UDMA 66 mode then why driver
initialised it like this...
Right now i placed a line somewhere in my rc.sysinit script
hdpatm -d1 -X34 /dev/hdX to reslove the dead lock i was facing whenever
tried to mount the specified drive.

Any suggestion........

Regardz
daCodez


****************************************************************************
******************
Simplicity is the only comlexity I know about.






