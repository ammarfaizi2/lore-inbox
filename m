Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTHaUGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 16:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTHaUGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 16:06:45 -0400
Received: from pasky.ji.cz ([213.226.226.138]:3315 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262023AbTHaUGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 16:06:42 -0400
Date: Sun, 31 Aug 2003 22:06:39 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: IDE DMA breakage w/ 2.4.21+ and 2.6.0-test4(-mm4)
Message-ID: <20030831200639.GA573@pasky.ji.cz>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andre Hedrick <andre@linux-ide.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831161634.GA695@pasky.ji.cz> <1062352643.11140.0.camel@dhcp23.swansea.linux.org.uk> <200308312032.47638.bzolnier@elka.pw.edu.pl> <20030831185706.GB695@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831185706.GB695@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Aug 31, 2003 at 08:57:06PM CEST, I got a letter,
where Petr Baudis <pasky@ucw.cz> told me, that...
> Dear diary, on Sun, Aug 31, 2003 at 08:32:47PM CEST, I got a letter,
> where Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> told me, that...
> > On Sunday 31 of August 2003 19:57, Alan Cox wrote:
> > > On Sul, 2003-08-31 at 17:16, Petr Baudis wrote:
> > > >   Hello,
> > > >
> > > >   when upgrading from 2.4.20 to 2.4.22, I hit a strange problem - the
> > > > machine mysteriously freezed (totally, interrupts blocked) in few seconds
> > > > when I tried to do anything with the soundcard. It turned out to be a DMA
> > > > conflict between soundcard and disk, since it disappears when I disable
> > > > the (now defaultly on) DMA-by-default IDE option.
> > >
> > > Sound and IDE work together on my MVP3 board. Maybe your hardware is
> > > just broken.
> > 
> > Or maybe sound driver is doing some funny things (?).
> 
> sb: ESS ES1869 Plug and Play AudioDrive detected
> sb: ISAPnP reports 'ESS ES1869 Plug and Play AudioDrive' at i/o 0x220, irq 10, dma 1, 3
> SB 3.01 detected OK (220)
> ESS chip ES1869 detected
> <ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 10 dma 1,3
> sb: 1 Soundblaster PnP card(s) found.
> 
> ...worked just fine in the past. Oh and under 2.6.0-test I was using ALSA.

I did few more experiments, and one strange thing is that /proc/dma does not
change when turning using_dma on thru hdparm:

 1: SoundBlaster8
 4: cascade

I'd expect some entry for ide to appear or so. Or is this normal?

When I'm playing something thru the soundcard and turn using_dma in the middle
of the playback, it freezes the first time it tries to do any disk i/o, it
seems.

In case it matters, here is /proc/ide/via :

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x1b IDE 0x6
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xd000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns     120ns     120ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns     330ns      90ns
Data Recovery:       30ns     270ns     270ns      30ns
Cycle Time:         120ns     600ns     600ns     120ns
Transfer Rate:   16.6MB/s   3.3MB/s   3.3MB/s  16.6MB/s

Settings are:

root@machine:~# cat /proc/ide/ide0/hda/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
acoustic                0               0               254             rw
address                 0               0               2               rw
bios_cyl                79780           0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
breada_readahead        8               0               255             rw
bswap                   0               0               1               r
current_speed           66              0               70              rw
failures                0               0               65535           rw
file_readahead          124             0               16384           rw
init_speed              12              0               70              rw
io_32bit                1               0               3               rw
keepsettings            0               0               1               rw
lun                     0               0               7               rw
max_failures            1               0               65535           rw
max_kb_per_request      128             1               255             rw
multcount               16              0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
number                  0               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               1               0               1               rw
using_dma               0               0               1               rw
wcache                  0               0               1               rw

(before doing hdparm -d 1 /dev/hda)

(By the way, there are two 'capacity' entries in /proc/ide/ide*/hd*/.)

I tried to somehow disable the DMA usage in the sound driver or at least
convince it to use dma 3, but I didn't succeed - if I don't let isapnp do the
job, sb fails to reset dsp even if i manually insert the identical stuff that
isapnp autodetected :/ :

root@machine:~# insmod sb
Using /lib/modules/2.4.22/kernel/drivers/sound/sb.o
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: ESS ES1869 Plug and Play AudioDrive detected
sb: ISAPnP reports 'ESS ES1869 Plug and Play AudioDrive' at i/o 0x220, irq 10, dma 1, 3
SB 3.01 detected OK (220)
ESS chip ES1869 detected
<ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 10 dma 1,3
sb: 1 Soundblaster PnP card(s) found.

root@machine:~# rmmod sb
root@machine:~# insmod sb isapnp=0 io=0x220 irq=10 dma=1
Using /lib/modules/2.4.22/kernel/drivers/sound/sb.o
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: dsp reset failed.
/lib/modules/2.4.22/kernel/drivers/sound/sb.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

root@machine:~# insmod sb isapnp=0 io=0x220 irq=10 dma=1,3
Using /lib/modules/2.4.22/kernel/drivers/sound/sb.o
/lib/modules/2.4.22/kernel/drivers/sound/sb.o: too many values for dma (max 1)

Regards,

-- 
 
				Petr "Pasky" Baudis
.
Perfection is reached, not when there is no longer anything to add, but when
there is no longer anything to take away.
	-- Antoine de Saint-Exupery
.
Stuff: http://pasky.ji.cz/
