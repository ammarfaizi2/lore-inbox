Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSHXKJL>; Sat, 24 Aug 2002 06:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSHXKJK>; Sat, 24 Aug 2002 06:09:10 -0400
Received: from mail.mplayerhq.hu ([192.190.173.45]:11658 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP
	id <S315762AbSHXKJK>; Sat, 24 Aug 2002 06:09:10 -0400
Date: Sat, 24 Aug 2002 12:32:24 +0200
Message-Id: <200208241032.g7OAWOoS006611@mail.mplayerhq.hu>
From: Arpi <arpi@thot.banki.hu>
To: linux-kernel@vger.kernel.org
Subject: drivers/block/paride/pd.c vs. generic IDE code
X-Mailer: GyikSoft Mailer for UNIX v3.7beta by Arpi/ESP-team (http://esp-team.scene.hu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently bought an parallel-to-ide interface, and after some kernel
hacking to get it work i found several problems with the currect (2.4.19)
paride interface. Actually the files drivers/block/paride/p?.c and pcd.c
are stripped down ide interface code (duplicate of the generic ide code at
drivers/ide/*)

As you're on changing/redesigning the IDE code of the 2.5 tree, I would
consider taking a look at the paride interface and include it into the new
generic IDE code.

Current problems/limitations of paride code:
- no support for LBA (>32GB) or big (>128GB) disks
  (i've hacked LBA support into pd.c to get my 40G hdd work - i'll prepare a
   patch when i'm statisfied with testing results)
- no ioctls for hdparm and other hdd utils to control the devices

I think the problem is that paride was developed many years ago  and is not
maintained/updated to the changes of the IDE interface (i've sent
mail a week ago to the author - no answer yet)
It seems this part of the code have been somehow forgotten :(

Either it should be extended to avoid teh above mentioned limitations (i'm
working on that) or the better would be merging it with the generic ide code
(i don't know the kernel's generic ide code yet enough to do it myself).
The former means lots of code duplication what i want to avoid if possible.
The later has a big problem though, actually the paride drivers have custom
_functions_ to read/write IDE/ATA registers and data blocks instead of using
just inb/outb or DMA. I don't know if the current/planned new IDE code can
deal with it.


A'rpi / Astral & ESP-team

--
Developer of MPlayer, the Movie Player for Linux - http://www.MPlayerHQ.hu
