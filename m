Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRG0V3g>; Fri, 27 Jul 2001 17:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRG0V30>; Fri, 27 Jul 2001 17:29:26 -0400
Received: from pD9571279.dip.t-dialin.net ([217.87.18.121]:5088 "EHLO
	s2.cmm.ki.si") by vger.kernel.org with ESMTP id <S262288AbRG0V3G>;
	Fri, 27 Jul 2001 17:29:06 -0400
Date: Fri, 27 Jul 2001 23:28:54 +0200
Message-Id: <200107272128.f6RLSsLJ014246@s2.cmm.ki.si>
From: root <milan@cmm.ki.si>
To: linux-kernel@vger.kernel.org
Subject: ieee1394 does not compile
Reply-to: milan@cmm.ki.si
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



I have the following in my .config

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=y

#
# Device Drivers
#
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=y
CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_RAWIO=y
# CONFIG_IEEE1394_VERBOSEDEBUG is not set

And I get the following message when make bzImage

ld -m elf_i386  -r -o ieee1394drv.o ieee1394.o ohci1394.o video1394.o raw1394.o sbp2.o
raw1394.o(.data+0x8): multiple definition of `host_info_lock'
ieee1394.o(.data+0x8c): first defined here
make[3]: *** [ieee1394drv.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/ieee1394'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/ieee1394'
make[1]: *** [_subdir_ieee1394] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

After changing in raw1394.c:

spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;

into:

extern spinlock_t host_info_lock;

everything compiles fine!

-----
Milan
