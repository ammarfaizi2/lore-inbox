Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRKEXzD>; Mon, 5 Nov 2001 18:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRKEXyv>; Mon, 5 Nov 2001 18:54:51 -0500
Received: from femail33.sdc1.sfba.home.com ([24.254.60.23]:8371 "EHLO
	femail33.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S275778AbRKEXya>; Mon, 5 Nov 2001 18:54:30 -0500
Message-ID: <000c01c16655$78a1af80$0300a8c0@theburbs.com>
From: "Jamie" <darkshad@home.com>
To: <becker@webserv.gsfc.nasa.gov>
Cc: <jam@McQuil.com>, <hendriks@lanl.gov>, <jgolds@resilience.com>,
        <sdegler@degler.net>, <jgarzik@mandrakesoft.com>,
        <tulip-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Tulip Drivers Problem in 2.4.xx Kernel
Date: Mon, 5 Nov 2001 18:56:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ok I was told that you may be able to help me with this issue.  I have a
DEC DC 20141 NIC installed in this machine which uses the tulip drivers.  I
am using the 2.2.xx kernels right now and there are two different set of
tulip drivers in this kernel. This driver in the 2.2.xx kernel works fine. I
am compiling the 2.2.19 Kernel

But when I compile the 2.4.xx Kernel it stops working the kernel that I
compling is 2.4.13 I noticed that in the 2.4.13 Kernel there is only 1
driver for the tulip drivers in this kernel.

There are 2 NICs in this machine a 3COM 3C900B-TPO NIC and ad DEC DC20141
NIC.

When I reboot the machine the drivers load fine, here is what I see in my
log.

Nov  5 17:06:15 CS623805-A kernel: tulip0: 21041 Media table, default media
0800
 (Autosense).
Nov  5 17:06:15 CS623805-A kernel: tulip0:  21041 media #0, 10baseT.
Nov  5 17:06:15 CS623805-A kernel: tulip0:  21041 media #4, 10baseT-FDX.
Nov  5 17:06:15 CS623805-A kernel: eth0: Digital DC21041 Tulip rev 17 at
0x6100,
 21041 mode, 00:00:C0:90:F0:E3, IRQ 3.
Nov  5 17:06:15 CS623805-A kernel: cdrom: open failed.
Nov  5 17:06:24 CS623805-A sendmail[112]: starting daemon (8.11.4):
SMTP+queuein
g@00:15:00
Nov  5 17:06:26 CS623805-A kernel: 00:0b.0: 3Com PCI 3c900 Cyclone 10Mbps
TPO at
 0x6200. Vers LK1.1.16


All the drivers load up fine but I get no communication between the NIC and
my cable modem I get no PC light on the front of the cable modem there is no
connection between the DEC DC 21041 NIC and the cable modem. There are no
errors in /var/log/messages when the machine is booting up. But there is no
communication to this NIC. I noticed as well that in the 2.2.xx Kernel in
the tulip.c  you use Donald Becker's Tulip Drivers.


/* tulip.c: A DEC 21040-family ethernet driver for Linux. */
/*
        Written/copyright 1994-1999 by Donald Becker.

        This software may be used and distributed according to the terms
        of the GNU Public License, incorporated herein by reference.

        This driver is for the Digital "Tulip" Ethernet adapter interface.
        It should work with most DEC 21*4*-based chips/ethercards, as well
as
        with work-alike chips from Lite-On (PNIC) and Macronix (MXIC) and
ASIX.

        The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
        Center of Excellence in Space Data and Information Sciences
           Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771

        Support and updates available at
        http://cesdis.gsfc.nasa.gov/linux/drivers/tulip.html

       This driver also contains updates by Wolfgang Walter and others.
        For this specific driver variant please use linux-kernel for
        bug reports.

        Updated 12/17/2000 by Jim McQuillan <jam@McQuil.com> to
        include support for the Linksys LNE100TX card based on the
        Admtek 985 Centaur-P chipset.
*/

Here are the drivers from the 2.4.xx Kernel as well.


2001-07-17  Erik A. Hendriks  <hendriks@lanl.gov>

        * 21142.c: Merge fix from tulip.c 0.92w which prevents the
        overwriting of csr6 bits we want to preserve.

2001-07-10  Jeff Golds  <jgolds@resilience.com>

        * tulip_core.c: Fix two comments

2001-07-06  Stephen Degler  <sdegler@degler.net>

        * media.c:
        The media selection process at the end of NWAY is busted
        because for the case of MII/SYM it needs to be:

        csr13 <- 0
        csr14 <- 0
        csr6 <-  the value calculated is okay.

As per the Maintaners file included with the 2.4.13 source  I am CCing the
people who
are mainting these tulip drivers in this kernel as well.


TULIP NETWORK DRIVER
P:      Jeff Garzik
M:      jgarzik@mandrakesoft.com
L:      tulip-users@lists.sourceforge.net
W:      http://sourceforge.net/projects/tulip/
S:      Maintained


Also as per the 2.2.19 Kernel in the REPORTING-BUGS file

     Send the output the maintainer of the kernel area that seems to
be involved with the problem. Don't worry too much about getting the
wrong person. If you are unsure send it to the person responsible for the
code relevant to what you were doing. If it occurs repeatably try and
describe how to recreate it. That is worth even more than the oops itself.
The list of maintainers is in the MAINTAINERS file in this directory.

      If you are totally stumped as to whom to send the report, send it to
linux-kernel@vger.kernel.org. (For more information on the linux-kernel
mailing list see http://www.tux.org/lkml/).




What I would like to see happen is that you go back to the tulip.c drivers
from the 2.2.xx Kernel into the 2.4.xx Kernel. because the drivers for the
tulip.c in the 2.4.xx kernel are broken for the DEC DC21041 NIC.

This issue needs to be immediately fixed in the 2.4.xx kernel the drivers
are not currently functioning correctly.

The machine that this is running is a Pentium 200 MMX 64 MB or Ram. 4 Gig
hard drive. This machine is optomized as a router/gateway only.  As I said
everything runs fine with the 2.2.xx kernel but when I go to compile the
2.4.xx kernel it does not communicate with this NIC correctly all the
drivers load properly but I can't connect out using the 2.4.xx drivers.

Here is the information from /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 4
cpu MHz         : 200.457
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 399.76


Here is the information from /proc/version as well

Linux version 2.2.19 (root@CS623805-A) (gcc version 2.95.3 20010315
(release)) #
5 Mon Nov 5 17:07:53 EST 2001


That is the current version I am running right now since the 2.4.xx kernel
is not working correctly with the DEC DC21041 NIC I have as one of the cards
in this machine.

Please look into this issue for me please with the 2.4.xx Kernel series.
If you need to reach me please email me back at darkshad@home.com

Thanks,

Jamie

