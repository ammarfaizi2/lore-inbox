Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277950AbRJOTDO>; Mon, 15 Oct 2001 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277955AbRJOTDE>; Mon, 15 Oct 2001 15:03:04 -0400
Received: from apexmail.kih.net ([209.209.190.216]:34486 "EHLO
	apexmail.kih.net") by vger.kernel.org with ESMTP id <S277950AbRJOTCt>;
	Mon, 15 Oct 2001 15:02:49 -0400
Date: Mon, 15 Oct 2001 14:01:55 -0500 (CDT)
From: grouch <grouch@apex.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA chipset
In-Reply-To: <Pine.LNX.4.10.10110151147340.23528-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0110151333290.13168-100000@paq.edgers.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Mark Hahn wrote:

->> RAM: 256MB pc133
->
->that's a lot of ram for an old system like this.  have you scrutinized
->the bios settings/jumpers?  reasonably up-to-date bios installed?

RAM is cheap :). BIOS is the latest available from Tyan for this board.

->> HD: tested with WDC AC26400R, 6149MB w/512kB Cache
->>     and with IBM-DTLA-305040, 41174 MB w/380KiB Cache
->>     (tested with each separately and together)
->>     IBM drive tested both before and after setting it to report as
->>     a PIO mode 0 drive, using IBM's "Drive Feature Tool".
->
->pio is almost never a sane setting; certainly not for a dtla.

I moved the IBM drive to another system and experienced a lockup. A
search showed that some BIOS/chipsets locked when these drives reported
as UDMA 100 and a solution is to use the IBM "dft 2.30" to cause the
drive to report itself at some lower capability. This worked in the
other system so I tried the drive in the VIA chipset system again. It
still locks.

->mixing vendors on the same cable is asking for trouble;

Tested with both and with each.

->do you see problems with just one disk per channel?

Yes.

->> Other IDE: ATAPI 4x CDROM
->
->on its own channel, I presume?

Tested as slave, master on secondary, not connected.

->also, is the ide config valid?  (ie, cables <= 18", both ends plugged in,
->preferably with 80-conductor cables?)

That's an interesting point. This thing does not like 80 conductor
cables at all. I first suspected a damaged motherboard instead of a
buggy chipset/BIOS. I went through all tests at
http://www-106.ibm.com/developerworks/linux/library/l-hw1/ and
http://www-106.ibm.com/developerworks/linux/library/l-hw2/ to check the
hardware. Continuous kernel compiles overnight caused no locks using
default Debian (stable) kernel. memtest86 ran its full test (over 10
hours) with no problems.

->> CONFIG_APM is not set
->> CONFIG_ACPI is not set
->
->but how about the corresponding bios settings?

APM is disabled in BIOS.

->> Is there a way to grab kernel messages or registers or something just before
->> a lockup occurs?
->
->sure, magic sys-rq, a kernel compile option.
->

D'oh! Thanks, I will try that.

Update: system locked overnight using 2.2.19 with ext3 while doing
apt-get dist-upgrade. Some directories were mounted via NFS, but it
locks under 2.4.x whether NFS is involved or not. Will go back to 2.2.19
with ext2 and see how long it can do disk work.


