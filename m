Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277387AbRJOLK5>; Mon, 15 Oct 2001 07:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277390AbRJOLKs>; Mon, 15 Oct 2001 07:10:48 -0400
Received: from promotionalresponse.com ([209.209.190.216]:22014 "EHLO
	apexmail.kih.net") by vger.kernel.org with ESMTP id <S277387AbRJOLKf>;
	Mon, 15 Oct 2001 07:10:35 -0400
Date: Mon, 15 Oct 2001 06:09:51 -0500 (CDT)
From: grouch <grouch@apex.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: VIA chipset
Message-ID: <Pine.LNX.4.30.0110150604580.12534-100000@paq.edgers.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apology beforehand for a long message.

Problem: system locks with 2.4.x kernels
Symptoms: no response to keyboard input, no disk activity, no response to
	NumLock or Caps Lock, no response to ssh, http or ping
Suspect: VIA chipset
Conditions at lock: varies, usually during disk activity. Nothing left
	behind in /var/log/messages

Motherboard: Tyan Trinity 100AT S1590S rev. 1.20 (UDMA 33)
CPU: AMD K6-2 350
RAM: 256MB pc133
HD: tested with WDC AC26400R, 6149MB w/512kB Cache
    and with IBM-DTLA-305040, 41174 MB w/380KiB Cache
    (tested with each separately and together)
    IBM drive tested both before and after setting it to report as
    a PIO mode 0 drive, using IBM's "Drive Feature Tool".
Other IDE: ATAPI 4x CDROM
Video: tested with an ATI and an old Cirrus Logic, no X tried as yet

Using kernel 2.2.19-ext3, output of /sbin/lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:0b.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 47)

Another system uses the same brand and model of motherboard
and has been stable using kernel 2.4.5 since August, but
/sbin/lspci produces:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
00:09.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03)
00:0b.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)

Kernels tested:

  No locks:
	2.2.18pre21, 2.2.18, 2.2.18 w/jfs 1.0.5, 2.2.19, 2.2.19 w/ext3

  Locks:
	2.4.5 (copied from stable system), 2.4.5 (compiled on locking system),
	2.4.9-k6 (kernel package from people.debian.org/~bunk), 2.4.9,
	2.4.10-pre13, 2.4.10-pre13 w/xfs 1.0.1, 2.4.10, 2.4.10-ac7,
	2.4.10 w/xfs 1.0.1, 2.4.10 w/jfs 1.0.6, 2.4.12, 2.4.12-ac2,
	2.4.12-ac2 w/ext3

Each kernel config was tried with i386 and i586. Also, where available,
CONFIG_BLK_DEV_VIA82CXXX=y or CONFIG_BLK_DEV_VIA82C586=y
Tested with UDMA enabled and disabled.

Based on search results of the kernel mailing list archive,
(in this thread --
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.2/1034.html )

CONFIG_APM is not set
CONFIG_ACPI is not set

I'm all out of ideas for what to try next and all out of search leads. Does any
of this make sense to somebody or should I just resign myself to using this
particular system with a 2.2.x kernel and cross my fingers about it never locking
under that?

Judging by the amount of discussion I found about VIA-related problems, I'm
guessing this is not so rare that it might be a waste of programmer time. If
a test subject would help, I'm very willing to pound on the misbehaving
machine in whatever way is needed. I can easily strip it down to the bare
necessities for booting and configure test kernels any way desired for testing.
Is there a way to grab kernel messages or registers or something just before
a lockup occurs?

Thanks for taking time to read this far. Since I'm a program abuser, not a
programmer, and almost all the conversation is over my head, please CC any
reply to grouch@apex.net. I'm not subscribed to the mailing list, I've only
been searching and sifting through it for the month or so I've been chasing
this problem. (If anyone wants me to run tests and my subscribing to the
list would make things more convenient for them, just say so).

Terry Vessels


