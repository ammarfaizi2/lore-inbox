Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRK0Nua>; Tue, 27 Nov 2001 08:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279407AbRK0NuV>; Tue, 27 Nov 2001 08:50:21 -0500
Received: from [195.66.192.167] ([195.66.192.167]:11537 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279556AbRK0NuK>; Tue, 27 Nov 2001 08:50:10 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.16pre1: minix initrd does not work, ext2 does
Date: Tue, 27 Nov 2001 15:49:19 -0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01112715491900.00872@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have 2 slackware initrds, one with minix fs on it, other with ext2.

I compiled 2.4.13 and it panics (can't mount root fs) (don't remember with 
both initrds or only with minix one...).

I copied .config to 2.4.10, did make oldconfig and all that other reqd makes, 
and it boots both initrds.

Finally I tried it with 2.4.16pre1 (came .config again) 
and it cannot mount minix initrd.
("FAT: bogus sector size 0","VFS: unable to mount root fs")
I further tested and that initrd CAN be mounted by 2.4.16pre1 
over loopback device with

# mount -o loop /tmp/initrd.minix /mnt/mnt

and

# mount -t fat,minix -o loop /tmp/initrd.minix /mnt/mnt

(so we can't blame FAT for first saying "Yes it's fat, don't probe for 
others" and then "it is corrupted, can't use")

Seems there is some problem with fs detection order during root fs mount.
(minix isn't tried at all?) However, I failed to grok what affect order of fs
type guessing at boot... can somebody point me where to look?
--
vda
