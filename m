Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313983AbSDKEIs>; Thu, 11 Apr 2002 00:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313984AbSDKEIr>; Thu, 11 Apr 2002 00:08:47 -0400
Received: from dark.x.dtu.dk ([130.225.92.246]:57495 "HELO dark.x.dtu.dk")
	by vger.kernel.org with SMTP id <S313983AbSDKEIq>;
	Thu, 11 Apr 2002 00:08:46 -0400
Date: Thu, 11 Apr 2002 06:08:45 +0200
From: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
To: linux-kernel@vger.kernel.org
Subject: More than 10 IDE interfaces
Message-ID: <20020411040845.GE14801@dark.x.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a machine with the following configuration:

2 on board IDE interfaces (AMD chipset)
2 Promise Technology UltraDMA100 controllers with each 2 IDE interfaces.
4 Promise Technology UltraDMA133 controllers with each 2 IDE interfaces.

This adds up to 14 IDE interfaces. And I just discovered that the kernel
only supports 10 IDE interfaces :-(

So I tried to hack the kernel, and I was partially successfull. I changed
MAX_HWIF from 10 to 14. I made up some major numbers for the extra
interfaces (115, 116, 117 and 118).

drivers/ide/ide.c and fs/partitions/check.c were modified to know about
IDE10_MAJOR to IDE13_MAJOR.

With there changes the kernel detects the extra interfaces and the disks on
them. They get some strange names like IDE< and the last disk is named hd{,
but I guess I can live with that :-)

But when it tries to detect the partitions on the extra interfaces, it locks
up. The last lines it writes is:

Partition check:
 hda: hda1
 hde: hde1
 hdg: hdg1
 hdi: hdi1
 hdk: hdk1
 hdm: hdm1
 hdo: hdo1
 hdq: hdq1
 hds: hds1
 hdu:

I am looking for any clues about how to do this.

Some information about the system:

Linux kernel 2.4.18 with ide.2.4.18-rc1.02152002.patch IDE patches applied.
Dual Athlon MP 1800+ 1.53 GHz. Tyan Tiger MPX motherboard, AMD 760 MPX
chipset. 8 x 80 GB western digital disks in a raid5, 4 x 160 GB maxtor in a
raid5, the two raids are merged with LVM into one filesystem with reiserfs.

Thanks, 
  Baldur
