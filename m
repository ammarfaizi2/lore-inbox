Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRIUPGR>; Fri, 21 Sep 2001 11:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273578AbRIUPGH>; Fri, 21 Sep 2001 11:06:07 -0400
Received: from emc.emcraft.ru ([213.24.253.239]:20750 "EHLO emc.emcraft.ru")
	by vger.kernel.org with ESMTP id <S273577AbRIUPFx>;
	Fri, 21 Sep 2001 11:05:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nikolai Bulkin <nick@emcraft.ru>
To: linux-kernel@vger.kernel.org
Subject: Busy inodes after unmount
Date: Fri, 21 Sep 2001 19:06:33 +0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01092119063300.01004@iron.auriga.ru>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm getting the "Busy inodes after unmount. Self-destruct in 5 seconds. Have 
a nice day..." message when trying to unmount initrd. It gets unmounted 
alright but the message is frightening.

The error message appears only if I've written something to a ramdisk (not 
initrd, to another one). For instance, the following commands in /linuxrc are 
enough to get the message:

#!/bin/ash
dd if=/dev/zero of=/dev/ram6 count=1
exit

The real root file system is on a SCSI disk.

I've tried it with the 2.4.3, 2.4.9, 2.4.10-pre11 kernels - with the same 
results. Also, I added printouts to the fs/inode.c file (from one of the 
patches sent via this list some while ago) showing what inodes appear busy. 
It's a single unnamed inode, number 54, i_count equals to 1 and zero i_state.

Does anyone have any idea as to why this may happen and how to fix this?

Thanks,
Nick
