Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbRCAH75>; Thu, 1 Mar 2001 02:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRCAH7s>; Thu, 1 Mar 2001 02:59:48 -0500
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:22984
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S129091AbRCAH7f>; Thu, 1 Mar 2001 02:59:35 -0500
Date: Thu, 1 Mar 2001 20:59:30 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Strange hdparm behaviour with Via 686b and 2.4.2 
Message-ID: <20010301205930.B9243@cone.kiwa.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[Please CC:, not subscribed]


I've got a new Athlon 900 with Abit KT7A motherboard and a 20Gb Seagate 
ST320414A 7200 ATA100 HDD.

I've been trying to figure out why my hdparm -t rates where so low.

Then I stumbled across this:


At this point dnetc (www.distributed.net client running RC5) is going
full hog.


nic@thunder:~/dnetc$ ./dnetc -hide -nice 19
nic@thunder:~/dnetc$ sudo nice -n '-19' hdparm -m16 -tT /dev/hda

/dev/hda:
 setting multcount to 16
 multcount    = 16 (on)
 Timing buffer-cache reads:   128 MB in  0.92 seconds =139.13 MB/sec
 Timing buffered disk reads:  64 MB in  2.06 seconds = 31.07 MB/sec
nic@thunder:~/dnetc$ ./dnetc -shutdown
dnetc: 1 distributed.net client was shutdown. 0 failures.
nic@thunder:~/dnetc$ sudo nice -n '-19' hdparm -m16 -tT /dev/hda

/dev/hda:
 setting multcount to 16
 multcount    = 16 (on)
 Timing buffer-cache reads:   128 MB in  0.90 seconds =142.22 MB/sec
 Timing buffered disk reads:  64 MB in  4.46 seconds = 14.35 MB/sec

nic@thunder:~/dnetc$ sudo hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2434/255/63, sectors = 39102336, start = 0



Very strange.

nic@thunder:~/dnetc$ dmesg | grep --regexp 'DMA\|hda\|ide'
BIOS-provided physical RAM map:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
hda: ST320414A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.




Note this is just a report.  Not sure if it means anything, not I've
noted the problems with the Via IDE chitset recent and thought this
might interest.  

If anyone can explain this I'd be most please to find out why.



Nicholas

