Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSILKni>; Thu, 12 Sep 2002 06:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSILKni>; Thu, 12 Sep 2002 06:43:38 -0400
Received: from web14008.mail.yahoo.com ([216.136.175.124]:61773 "HELO
	web14008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315275AbSILKng>; Thu, 12 Sep 2002 06:43:36 -0400
Message-ID: <20020912104826.48917.qmail@web14008.mail.yahoo.com>
Date: Thu, 12 Sep 2002 03:48:26 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: Linux 2.4.20pre5-ac5
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
In-Reply-To: <1031818662.2902.43.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I tagged piix as modular and removed the task file stuff.
The DVD and burner showedup. Running atapci, showed 
the drives as DMA enabled (I had to pick Generic PCI bus-master 
DMA support to get the piix option).
Hdparm would not work with piix loaded, I got similiar errors
when trying to mount (see below).

I could mount a cd and copy files no problem(without piix loaded). 
I then loaded the piix module. It loaded sucessfully. I tried to 
mount the cd  and got errors. 
Also /proc/ide/piix did not show up.

Log snips below, I also put links to full files at end of message.

If I missed something or you need anything else
let me know. Thanks!

Tony


atapci before piix load (it's the same afterward):
pcibus = 33333
00:1f.1 vendor=8086 device=24cb class=0101 irq=16 base4=cc01
----------PIIX BusMastering IDE Configuration---------------
Driver Version:                     1.3
South Bridge:                       9419
Revision:                           IDE 0x1
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xcc00
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Prefetch+Post:        yes        no       yes        no
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       90ns      90ns      90ns      90ns
Cmd Active:         360ns     360ns     360ns     360ns
Cmd Recovery:       540ns     540ns     540ns     540ns
Data Active:         90ns     360ns      90ns     360ns
Data Recovery:       30ns     540ns      30ns     540ns
Cycle Time:          60ns     900ns      60ns     900ns
Transfer Rate:   33.3MB/s   2.2MB/s  33.3MB/s   2.2MB/s
********
piix loading:
localhost kernel: ICH4: IDE controller at PCI slot 00:1f.1
localhost kernel: ICH4: chipset revision 1
localhost kernel: ICH4: not 100%% native mode: will probe irqs later
localhost kernel:     ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings:
hda:DMA, hdb:pio
localhost kernel:     ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings:
hdc:DMA, hdd:pio
********
errors when mounting cdrom after loading piix:
localhost kernel: ide0: reset timed-out, status=0xff
localhost kernel: end_request: I/O error, dev 03:00 (hda), sector 0
localhost last message repeated 4 times
localhost kernel: end_request: I/O error, dev 03:00 (hda), sector 64
localhost kernel: isofs_read_super: bread failed, dev=03:00,
iso_blknum=16, block=32
localhost kernel: end_request: I/O error, dev 03:00 (hda), sector 0
******* dmesg when booting without piix:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: LITEON DVD-ROM LTD163, ATAPI CD/DVD-ROM drive
hdc: LITE-ON LTR-48125W, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: ATAPI 48X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache
**********

Links to full files:
http://ac.marywood.edu/tspin/www/atapci.txt
http://ac.marywood.edu/tspin/www/dmesgnopiix.txt
Mounting errors after piix load
http://ac.marywood.edu/tspin/www/mount.txt
modprobing piix
http://ac.marywood.edu/tspin/www/piixload.txt
Kernel config
http://ac.marywood.edu/tspin/www/config.txt
gigabyte lspci
http://ac.marywood.edu/tspin/www/lspcigb.txt

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Thu, 2002-09-12 at 01:02, Tony Spinillo wrote:
> > I just fired it up an an Asus P4B533-V (845G-Award Medallion Bios
> > v6.0) 
> > board. Seemed to work well  :) . Full DMA on the DVD drive.
> >  
> > I took a gamble to see if my old "non-appearing" drives
> > problem was fixed, and tried it on the Gigabyte 845IGX
> > (845G-Award Modular Bios V6.0PG),  I was not
> > as lucky. I think my next board will be an Asus. ;)
> 
> Can you try one thing for me on the problem board. Build the PIIX
> driver
> modular, and build with ide task file disabled
> 
> Next boot the system (single user read only if you want)- you
> should get
> the drives in basic PIO mode. Then modprobe piix and see if it
> finds the
> drives that way around
> 


__________________________________________________
Do you Yahoo!?
Yahoo! News - Today's headlines
http://news.yahoo.com
