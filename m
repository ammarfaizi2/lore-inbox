Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbRFGAW7>; Wed, 6 Jun 2001 20:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbRFGAWt>; Wed, 6 Jun 2001 20:22:49 -0400
Received: from lithium.nac.net ([64.21.52.68]:14611 "HELO lithium.nac.net")
	by vger.kernel.org with SMTP id <S263298AbRFGAWj>;
	Wed, 6 Jun 2001 20:22:39 -0400
Date: Wed, 6 Jun 2001 20:22:24 -0400
To: linux-kernel@vger.kernel.org
Subject: irqtune in kernel 2.4
Message-ID: <20010606202224.B29242@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: <tcm@nac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi. I will try to keep this as informative as possible, just in
case I've missed something.

First off, I've already searched all the kernel archives I could,
google, I've looked around on IRC for help in four different networks,
I've emailed the debian hwtools package maintainer (who misdirected me
to use /dev/irq to do what I wanted to do), and the irqtune
author (I have not yet recieved a reply), and come up with absolutely
no way to get this to work.

Problem: Irqtune is not working under any 2.4 kernel I've tried as it
did in kernel 2.2.x, in fact it is not doing anything at all, despite
the fact it says it's working fine. The symptoms of it not working are
that whenever my hard disk writes, all serial and ethernet operations
stop. As you can imagine, this generates quite a bit of packet loss,
which is unacceptable, especially if I have to be writing/reading at the
same time the modem is going.

Description of my configuration:
Kernel: 2.4.5-ac7

irqtune: Debian unstable, using irqtune 0.6 from the hwtools package

hdparm: version v3.9 from the debian unstable hwtools package

Hardware: IBM PS/1 486 dx 50 with 16MB of ram, a add on ISA card
which provides a 16550A uart for the external zoom 56K faxmodem, a
NE2000 compatible ethernet card

irqtune -e 7 10 output:
irqtune: version is 0.6
irqtune: kernel version 0.0.0
probe: irqtune must be invoked via the full path -- OK
probe: /sbin in $PATH -- YES
probe: insmod found in $PATH (/sbin) -- OK
probe: insmod simple execution -- OK
probe: insmod has version (2.4.6) -- YES
probe: rmmod found in insmod directory -- OK
probe: insmod version supports command line options -- OK
probe: insmod version (2.4.6) compatible with kernel version (0.0.0) --
OK
probe: insmod version should be 2.1.34 (or better) -- OK
probe: insmod and kernel compatible with CONFIG_MODVERSIONS -- OK
probe: irqtune_mod loading will be tried -- OK
probe: kernel version irqtune built under (1.0.0) matches current system
-- NO
probe: kernel IRQ handling is compatible -- OK
probe: kernel has module support (CONFIG_MODULES) -- OK
probe: kernel has symbols -- OK
probe: kernel is using versions (CONFIG_MODVERSIONS) -- NO
probe: kernel symbols are checksummed (CONFIG_MODVERSIONS) -- NO
probe: kernel has /proc/interrupts -- OK
irqtune: setting system IRQ priority to 7/10
irqtune: trying command -- insmod -x -o irqtune_mod -f
/usr/lib/hwtools/irqtune_mod.o priority=7,10
Warning: kernel-module version mismatch
        /usr/lib/hwtools/irqtune_mod.o was compiled for kernel version
1.0.0
        while this kernel is version 2.4.5-ac7
irqtune: trying command -- rmmod irqtune_mod
tblread: SYNTAX 'ERR:          0'
I00/P01:    34152281          XT-PIC  timer
I01/P02:           2          XT-PIC  keyboard
I02/P03:           0          XT-PIC  cascade
I03/P11:           1          XT-PIC  serial
I07/P00:     5957335          XT-PIC  serial
I10/P03:      202481          XT-PIC  NE2000
I13/P06:           0          XT-PIC  fpu
I14/P07:     8104967          XT-PIC  ide0
I15/P08:           0          XT-PIC  ide1
irqtune: complete

As you can imagine I'm slightly perturbed. I think the syntax error is
OK, it's likely barfing on the new 'cpu 0' part of /proc/interrupts...
However the misdetection of the kernel version is making we worry, as
well as the fact that although it SAYS it has done something, in fact
the problems I have been having since I upgraded to 2.4.x continue.
(hard disk reads/writes cause all serial/eth0 operations to generate
massive PL)

hdparm /dev/hda output:

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4956/16/63, sectors = 4996476, start = 0

As you can see, I've enabled unmaskirq, as it has been reported to help
in my situation... It does in fact, although I wish I had a way to get
irqtune working again. Note that DMA is NOT available on this old
system, and I will actually go back to a 2.2.x kernel rather than spend
money on a dma compatible controller if irqtune or another solution
cannot be found.

I will accept any ideas anyone has to offer. If irqtune is obsolete,
please say so. If there is an in kernel solution PLEASE say so.
(/dev/irq is used for smp systems. This is a single cpu system) If there
is NO present solution, please tell me that too. :)

I am quite willing to downgrade my system to kernel 2.2 if this can't be
fixed somehow, kernel 2.2.x works just fine on my old 486, although
kernel 2.4.x tends to simply do some things better. (It's VM, although
some report it to do strange things, manages memory better in many cases
on my 486 - less disk thrashing when it swaps things, runs obese perl
scripts etc.) The fact I'd be missing out on reiserfs in the kernel
makes me sad though, I really do like that filesystem.

Anyway, please reply to the list with ideas, I'll see them.

Timothy C. McGrath
