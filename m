Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268334AbRGWSOC>; Mon, 23 Jul 2001 14:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268325AbRGWSNx>; Mon, 23 Jul 2001 14:13:53 -0400
Received: from web14506.mail.yahoo.com ([216.136.224.69]:5892 "HELO
	web14506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268326AbRGWSNe>; Mon, 23 Jul 2001 14:13:34 -0400
Message-ID: <20010723181339.87370.qmail@web14506.mail.yahoo.com>
Date: Mon, 23 Jul 2001 11:13:39 -0700 (PDT)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: Conexant LANfinity is working in 2.2 and 2.4!
To: tulip <tulip@scyld.com>
Cc: Donald Becker <becker@scyld.com>, lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

	To those that are not faint hearted and that cannot
wait, I managed to have the Conexant LANfinity
NIC in presario laptops working in both 2.2.19 and
2.4.7 kernels.
	For 2.2 just follow the instructions in the
tulip (2.2) mailing list in July. For 2.4 I've got the
following.
	Have your 2.4.7 kernel tree under /usr/src/linux.
	Get:
		1. kern_compat.h revision 1.9
		2. pci-scan.c:v1.06 5/18/2001  
		3. pci-scan.h:version 1.02 2001/03/18 
		4. tulip.c:v0.92w 7/9/2001

	These can be found somewhere in
http://www.scyld.com/network/tulip.html

	Create the Makefile:

CC = gcc
OPTIONSCOMMON = -D__KERNEL__ -DMODULE -Wall
-Wstrict-prototypes -O2 -I/usr/src/linux/include
-fomit-frame-pointer -fno-strict-aliasing
-Wno-trigraphs -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODVERSIONS
 -include /usr/src/linux/include/linux/modversions.h
OPTIONSTULIP = $(OPTIONSCOMMON) 
OPTIONSPCISN = $(OPTIONSCOMMON)  -DEXPORT_SYMTAB
all:
        $(CC) $(OPTIONSTULIP) -c tulip.c
        $(CC) $(OPTIONSPCISN) -c pci-scan.c
clean:
        rm -f *~ pci-scan.o tulip.o

	Type make and then you should have the modules
pci-scan.o and tulip.o ready to be inserted in your
kernel and voila.

	Notes: This worked for me but I don't know if this
will destroy your machine. You may want to change the
arch flag -march to reflect your CPU. This was done on
a Debian 2.3 (aka woody) system. This is being posted
using this driver. The full-duplex mode is known to be
buggy.

	Great many thanks for Donald Becker for making this
driver work with the LANfinity chip!
	Happy networking presario guys!

	Kent

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
