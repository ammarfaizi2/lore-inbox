Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129546AbRCAIuf>; Thu, 1 Mar 2001 03:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRCAIu1>; Thu, 1 Mar 2001 03:50:27 -0500
Received: from ip110.herrera.iphil.net ([203.176.28.110]:56844 "HELO
	mail.q-linux.com") by vger.kernel.org with SMTP id <S129546AbRCAIuJ>;
	Thu, 1 Mar 2001 03:50:09 -0500
Date: Thu, 1 Mar 2001 16:49:59 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: Nicholas Lee <nj.lee@plumtree.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange hdparm behaviour with Via 686b and 2.4.2
Message-ID: <20010301164959.A11065@mail.q-linux.com>
In-Reply-To: <20010301205930.B9243@cone.kiwa.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010301205930.B9243@cone.kiwa.co.nz>; from nj.lee@plumtree.co.nz on Thu, Mar 01, 2001 at 08:59:30PM +1300
Organization: Q Linux Solutions, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this one is related.  This is on an AMD K6-2 450
with MS-5187 board and VIA VT82C686A chipset...

# hdparm -tT /dev/hda /dev/hdc
 
/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.16 seconds = 40.51 MB/sec
 Timing buffered disk reads:  64 MB in 11.84 seconds =  5.41 MB/sec
 
/dev/hdc:
 Timing buffer-cache reads:   128 MB in  3.12 seconds = 41.03 MB/sec
 Timing buffered disk reads:  64 MB in  5.17 seconds = 12.38 MB/sec
 
# dmesg | grep 'hd[a|c]: '
hda: ST320413A, ATA DISK drive
hdc: SAMSUNG SV0761D, ATA DISK drive
hda: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=2434/255/63, UDMA(66)
hdc: 14948640 sectors (7654 MB) w/434KiB Cache, CHS=14830/16/63, UDMA(66)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
 hdc: [PTBL] [930/255/63] hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 >

On Thu, Mar 01, 2001 at 08:59:30PM +1300, Nicholas Lee wrote:
> 
> I've got a new Athlon 900 with Abit KT7A motherboard and a 20Gb Seagate 
> ST320414A 7200 ATA100 HDD.
> 
> I've been trying to figure out why my hdparm -t rates where so low.
> 
> Then I stumbled across this:
> 
> At this point dnetc (www.distributed.net client running RC5) is going
> full hog.
> 
> nic@thunder:~/dnetc$ ./dnetc -hide -nice 19
> nic@thunder:~/dnetc$ sudo nice -n '-19' hdparm -m16 -tT /dev/hda
> 
> /dev/hda:
>  setting multcount to 16
>  multcount    = 16 (on)
>  Timing buffer-cache reads:   128 MB in  0.92 seconds =139.13 MB/sec
>  Timing buffered disk reads:  64 MB in  2.06 seconds = 31.07 MB/sec
> nic@thunder:~/dnetc$ ./dnetc -shutdown
> dnetc: 1 distributed.net client was shutdown. 0 failures.
> nic@thunder:~/dnetc$ sudo nice -n '-19' hdparm -m16 -tT /dev/hda
> 
> /dev/hda:
>  setting multcount to 16
>  multcount    = 16 (on)
>  Timing buffer-cache reads:   128 MB in  0.90 seconds =142.22 MB/sec
>  Timing buffered disk reads:  64 MB in  4.46 seconds = 14.35 MB/sec
> 
> nic@thunder:~/dnetc$ sudo hdparm /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 2434/255/63, sectors = 39102336, start = 0
> 
> nic@thunder:~/dnetc$ dmesg | grep --regexp 'DMA\|hda\|ide'
> BIOS-provided physical RAM map:
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
> hda: ST320414A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63, UDMA(100)
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 >
>   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.

--
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
