Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTHTAvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTHTAvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:51:45 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:64870 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261665AbTHTAvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:51:39 -0400
Message-ID: <3F42C632.6060701@sbcglobal.net>
Date: Tue, 19 Aug 2003 19:52:02 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3-mm2 -- IDE PDC20269 + Maxtor 92048D8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is off-topic I suppose, since this doesn't seem to be a kernel 
issue...I'm hoping someone can tell me more about how to diagnose the 
cause of the problem and/or the probably sequence of commands that lead 
up to this.

With this combination of of the Maxtor 92048D8 and the PDC20269, when I 
enable dma with "hdparm -d1 /dev/hdi", I'm getting the error as listed 
below in my log (plus a nice delay while it times out and then resets 
the interface).  Usually the first reset does the trick, but sometimes 
it has to reset twice.  I have two PDC20269 cards in my computer, and I 
get this behavior regardless of which card the drive is attached to or 
to which channel it is attached.  I've tried several cables as well, 
currently it is on an 80 conductor cable (though I've tried other "known 
good" cables).

The cards are actually Maxtor Ultra133TX2 with the same BIOS versions 
(and the only one available from Maxtor).  I've tried every DMA mode it 
supports, and as soon as I write to the drive in DMA, it will timeout, 
reset the interface and disable DMA.  After that, it is fine, but 
because it is using PIO, the performance is pretty sad.  I'm having the 
same trouble in WinXP, so I know it's not a Linux issue.  However, what 
I'd like to know is what would be causing this problem?  Just to head 
off defective hardware (well, as far as "the drive is going bad" 
responses), not too long ago the drive was replaced by Maxtor with the 
same model and firmware version which was experiencing the same 
problem.  The other drive was not "defective" besides this problem with 
interacting with the PCD20269.  It did work "fine" in UDMA/ATA-33 with 
my VIA MVP3 (except for that nasty MVP3 bug that corrupts the data).

I've tried all the different hdparm options  for {-m, -c, -u} which had 
no effect on the problem.

Has anyone else heard of this problem?  Any idea if it is the card or 
the drive?

Thanks,

Wes


*****hdparm -i output:
rybBIT:/home/sprchkn # hdparm -i /dev/hdi
 
/dev/hdi:
 HDIO_GETGEO_BIG failed: Invalid argument
 
 Model=Maxtor 92048D8, FwRev=NAN5271A, SerialNo=W8H4D3TA
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=54
 BuffType=DualPortCache, BuffSize=1024kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=40000464
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 
ATA-4

*****log output when DMA enabled and large transfer to drive (> 1MB):

Aug 19 18:13:59 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 18:14:09 rybBIT kernel: hdi: DMA timeout error
Aug 19 18:14:09 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 18:14:09 rybBIT kernel:
Aug 19 18:14:09 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 18:14:09 rybBIT kernel:
Aug 19 18:14:09 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 18:14:09 rybBIT kernel: hdi: drive not ready for command
Aug 19 18:14:10 rybBIT kernel: ide4: reset: success
Aug 19 18:14:30 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 18:14:40 rybBIT kernel: hdi: DMA timeout error
Aug 19 18:14:40 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 18:14:40 rybBIT kernel:
Aug 19 18:14:40 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 18:14:40 rybBIT kernel:
Aug 19 18:14:40 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 18:14:40 rybBIT kernel: hdi: drive not ready for command
Aug 19 18:14:40 rybBIT kernel: ide4: reset: success
Aug 19 18:15:00 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 18:15:10 rybBIT kernel: hdi: DMA timeout error
Aug 19 18:15:10 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 18:15:10 rybBIT kernel:
Aug 19 18:15:10 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 18:15:10 rybBIT kernel:
Aug 19 18:15:10 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 18:15:10 rybBIT kernel: hdi: drive not ready for command
Aug 19 18:15:10 rybBIT kernel: ide4: reset: success
Aug 19 18:15:30 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 18:15:40 rybBIT kernel: hdi: DMA timeout error
Aug 19 18:15:40 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 18:15:40 rybBIT kernel:
Aug 19 18:15:40 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 18:15:40 rybBIT kernel:
Aug 19 18:15:40 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 18:15:40 rybBIT kernel: hdi: drive not ready for command
Aug 19 18:15:40 rybBIT kernel: ide4: reset: success
Aug 19 18:35:48 rybBIT kernel: hdg: drive_cmd: status=0x01 { Error }
Aug 19 18:35:48 rybBIT kernel: hdg: drive_cmd: error=0x04Aborted Command
Aug 19 18:58:01 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 18:58:11 rybBIT kernel: hdi: DMA timeout error
Aug 19 18:58:11 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 18:58:11 rybBIT kernel:
Aug 19 18:58:11 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 18:58:11 rybBIT kernel:
Aug 19 18:58:11 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 18:58:11 rybBIT kernel: hdi: drive not ready for command
Aug 19 18:58:11 rybBIT kernel: ide4: reset: success
Aug 19 19:05:42 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 19:05:52 rybBIT kernel: hdi: DMA timeout error
Aug 19 19:05:52 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 19:05:52 rybBIT kernel:
Aug 19 19:05:52 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 19:05:52 rybBIT kernel:
Aug 19 19:05:52 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 19:05:52 rybBIT kernel: hdi: drive not ready for command
Aug 19 19:05:52 rybBIT kernel: ide4: reset: success
Aug 19 19:12:32 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 19:12:42 rybBIT kernel: hdi: DMA timeout error
Aug 19 19:12:42 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 19:12:42 rybBIT kernel:
Aug 19 19:12:42 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 19:12:42 rybBIT kernel:
Aug 19 19:12:42 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 19:12:42 rybBIT kernel: hdi: drive not ready for command
Aug 19 19:12:42 rybBIT kernel: ide4: reset: success
Aug 19 19:14:33 rybBIT kernel: hdi: dma_timer_expiry: dma status == 0x21
Aug 19 19:14:43 rybBIT kernel: hdi: DMA timeout error
Aug 19 19:14:43 rybBIT kernel: hdi: dma timeout error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Aug 19 19:14:43 rybBIT kernel:
Aug 19 19:14:43 rybBIT kernel: hdi: status timeout: status=0xd0 { Busy }
Aug 19 19:14:43 rybBIT kernel:
Aug 19 19:14:43 rybBIT kernel: PDC202XX: Primary channel reset.
Aug 19 19:14:43 rybBIT kernel: hdi: drive not ready for command
Aug 19 19:14:45 rybBIT kernel: ide4: reset: success





