Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318317AbSIBQzc>; Mon, 2 Sep 2002 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSIBQzc>; Mon, 2 Sep 2002 12:55:32 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:35772 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S318317AbSIBQzb>; Mon, 2 Sep 2002 12:55:31 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 2 Sep 2002 18:27:07 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.33: modular ide breaks lilo ...
Message-ID: <20020902162707.GA22182@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

I've tried building the ide driver modular and insmod it using an
initrd.  The kernel boots just fine, but lilo complains:

bogomips root ~# lilo
Device 0x0300: Invalid partition table, 2nd entry
  3D address:     1/0/262 (264096)
  Linear address: 1/10/4175 (4209030)

I've also noticed that the fdisk output looks different depending on
modular vs. static ide, I suspect this is related.  With a modular IDE
driver it looks like this:

bogomips root ~# fdisk -l /dev/hda

Disk /dev/hda: 16 heads, 63 sectors, 79780 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1      4176   2104483+   b  Win95 FAT32
Partition 1 does not end on cylinder boundary:
     phys=(261, 254, 63) should be (261, 15, 63)
/dev/hda2   *      4176     68659  32499495    5  Extended
Partition 2 does not end on cylinder boundary:
     phys=(1023, 254, 63) should be (1023, 15, 63)
/dev/hda4         68659     79768   5598652+  a5  FreeBSD
Partition 4 does not end on cylinder boundary:
     phys=(1023, 254, 63) should be (1023, 15, 63)
/dev/hda5          4176      6264   1052226   82  Linux swap
/dev/hda6          6264     18759   6297448+  83  Linux
/dev/hda7         18759     68659  25149726   83  Linux

With ide built-in statically fdisk prints this:

bogomips root ~# fdisk -l

Disk /dev/hda: 255 heads, 63 sectors, 5005 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1       262   2104483+   b  Win95 FAT32
/dev/hda2   *       263      4308  32499495    5  Extended
/dev/hda4          4309      5005   5598652+  a5  FreeBSD
/dev/hda5           263       393   1052226   82  Linux swap
/dev/hda6           394      1177   6297448+  83  Linux
/dev/hda7          1178      4308  25149726   83  Linux

Any idea?

  Gerd

