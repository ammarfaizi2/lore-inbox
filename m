Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131269AbRC0MaT>; Tue, 27 Mar 2001 07:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRC0MaJ>; Tue, 27 Mar 2001 07:30:09 -0500
Received: from fireball.blast.net ([207.162.131.33]:19207 "EHLO
	fireball.blast.net") by vger.kernel.org with ESMTP
	id <S131244AbRC0M3x>; Tue, 27 Mar 2001 07:29:53 -0500
Message-ID: <3AC080F3.6A09863C@voicenet.com>
Date: Tue, 27 Mar 2001 07:00:51 -0500
From: Uncle George <gatgul@voicenet.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-7.0 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org, Jeremy Jackson <jerj@coplanar.net>
Subject: Re: slow latencies on IDE disk drives( controller? )
In-Reply-To: <Pine.LNX.4.10.10103260844310.12547-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system is a Compaq XP1000 ( 667Mhz Alpha processor ). The
ON-motherboard IDE controller ( there is only one ) originally just had
a cdrom attached. When I got the system I added a 30gig maxtor drive.
There is no second controller ( ergo no /dev/hdc * /dev/hdd ) builtin,
so the IDE system was probably not a main selling point of the system.
changing the parameters for the IDE disk drive does not do much in terms
if the timing tests. I'll see if it changes the 'sound effects' as soon
as i look on the motherboard for the ide controller chip.

The system specs as the Redhat/linux/6.2 with linux-2.2.14-7.0 (
floating point fixes ) /var/log/messages has:

Mar 27 06:38:08 Java kernel: rtc: Digital UNIX epoch (1952) detected
Mar 27 06:38:08 Java kernel: PCI_IDE: unknown IDE controller on PCI bus
00 device 39, VID=1080, DID=c693
Mar 27 06:38:08 Java kernel: PCI_IDE: not 100% native mode: will probe
irqs later
Mar 27 06:38:08 Java kernel:     ide0: BM-DMA at 0x1100-0x1107, BIOS
settings: hda:pio, hdb:pio
Mar 27 06:38:08 Java kernel:     ide1: BM-DMA at 0x1108-0x110f, BIOS
settings: hdc:pio, hdd:pio
Mar 27 06:38:08 Java kernel: PCI_IDE: unknown IDE controller on PCI bus
00 device 3a, VID=1080, DID=c693
Mar 27 06:38:08 Java kernel: PCI_IDE: not 100% native mode: will probe
irqs later
Mar 27 06:38:08 Java kernel: PCI_IDE: port 0x01f0 already claimed by
ide0
Mar 27 06:38:08 Java kernel: PCI_IDE: port 0x0170 already claimed by
ide1
Mar 27 06:38:08 Java kernel: PCI_IDE: neither IDE port enabled (BIOS)
Mar 27 06:38:08 Java kernel: hda: Maxtor 53073U6, ATA DISK drive
Mar 27 06:38:08 Java kernel: hdb: Compaq CRD-8322B, ATAPI CDROM drive
Mar 27 06:38:08 Java kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 27 06:38:08 Java kernel: hda: Maxtor 53073U6, 29311MB w/2048kB
Cache, CHS=59554/16/63, (U)DMA
Mar 27 06:38:09 Java kernel: hdb: ATAPI 32X CD-ROM drive, 128kB Cache
Mar 27 06:38:09 Java kernel: Uniform CDROM driver Revision: 2.56
Mar 27 06:38:09 Java kernel: Floppy drive(s): fd0 is 2.88M


[root@Java gat]# /sbin/hdparm -i /dev/hda

/dev/hda:

 Model=Maxtor 53073U6, FwRev=DAC10SC0, SerialNo=K60CR35C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16,
MultSect=off
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=60030432
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 mode3 mode4 

[root@Java gat]# /sbin/hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in 20.11 seconds =  3.18 MB/sec
[root@Java gat]# 

[root@Java gat]# /sbin/hdparm -u 1 -m 16 -c 1 -d 1 /dev/hda

/dev/hda:
 setting 32-bit I/O support flag to 1
 setting multcount to 16
 setting unmaskirq to 1 (on)
 setting using_dma to 1 (on)
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
[root@Java gat]# /sbin/hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in 20.05 seconds =  3.19 MB/sec
[root@Java gat]# 



Andre Hedrick wrote:
> 
> Hello GAT,
> 
> Can you be more specific?  I need a kernel and hardware info and generally
> more info than what is given.  Is this a PIO/DMA process is it a laptop or
> unsupported hardware?
> 
> On Mon, 26 Mar 2001, Uncle George wrote:
> 
> > I am processing sound data on /dev/dsp. Generally the ~61k devive buffer
> > is enough to keep the device satiated && gives the program time to fill
> > up the device buffer when there is 16k of buffer space that needs to be
> > filled.
> >
> > But on occasion the /dev/dsp device "slurrs" ( sounds like what happens
> > when the speed of a tape recorder slows down due to a finger placed down
> > on the capstain ) unexpectedly. This was eventually traced to the usage
> > of an IDE disk drive. using the scsi drive does not cause the problem to
> 
> How did you derive this path to the ATA driver?
> What is the drive, and how fast (or how slow) is it?
> 
> > manifest itself( at least my ears say so ). but using "dd if=/dev/hda4
> > of=/dev/null ) does immediately cause the slurring to happen.
> >
> >
> > I think I can create a simple pgm to demo this problem, but the DATA
> > file that gets feed into /dev/dsp is a little large for e-mail.
> 
> The content of the barf is not important, but the process you are doing to
> create this issue is.
> 
> Andre Hedrick
> Linux ATA Development

