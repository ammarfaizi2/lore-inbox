Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSHAVmE>; Thu, 1 Aug 2002 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSHAVmD>; Thu, 1 Aug 2002 17:42:03 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:7955 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317165AbSHAVmD>;
	Thu, 1 Aug 2002 17:42:03 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Thu, 1 Aug 2002 23:45:06 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.5.29 IDE 110
CC: martin@dalecki.de, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.50
Message-ID: <CDEF453FCB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 02 at 23:16, Marcin Dalecki wrote:
> Lets not forgett that the code removed would allow to read behind the
> partion in question and was broken therefore. However the real world
> example from Petr worries me and makes me thinking that the partition
> scanning time solution could turn out to be most adequate -> we have the
> FAT partition ID there at hand and could adjust the partition
> parameters in question properly with ease. Both of them: offset *and* size.
> 
> Petr would you mind dumping the dd=/dev/hdx count=10 of the
> disk in question at me? Or do you preferr to go after this blotch
> yourself?

First sector contains valid partition table, but all partitions are
set to type 0x55, EZDrive. AFAIK EZDrive synchronizes this inivisble
partition with one from sector 2 on each reboot. Second sector contains 
'real' partition table, with types set to Linux, Linux swap, VFAT and
so on. I do not have extended partition on the drive, so I do not know
whether this record will have 0x55 or correct type in the sector 1.

Problem only occurs when you'll run LILO (if you have installed it
in /dev/hdx instead of in /dev/hdx#), or install-mbr - it will overwrite
ezdrive, and you have to find diskette and reinstall EZDrive to make
disk bootable in this obsolete system (btw, it is PentiumII).

So only problem is that we do not have special /dev/hdx-mbr device
for accessing MBR, all code expects that it is in first sector of the 
/dev/hdx, while with 0_to_1 remap it is in second one.
                                            Petr Vandrovec
                                            
