Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266452AbSKGGWN>; Thu, 7 Nov 2002 01:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266458AbSKGGWN>; Thu, 7 Nov 2002 01:22:13 -0500
Received: from [212.3.242.3] ([212.3.242.3]:35325 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S266452AbSKGGWM>;
	Thu, 7 Nov 2002 01:22:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.46] Problems with vfat mount umask on directories
Date: Thu, 7 Nov 2002 07:28:47 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211070728.47941.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'llo list.

This morning I discovered I no longer could write on my vfat data partition as 
a normal user. The following line is present in /etc/fstab (and has worked 
before with atleast 2.5.40 and each and every 2.4 kernel I used)

/dev/hda7   /mnt/data      vfat      defaults,gid=103,umask=007       0 0

which gives the partition a mask of 770 to all users in gid 103 (which is 
conveniently named fat32). I myself as user devilkin am in this group...

Yet, the directory is still:

07:22:56 root@laptop:/mnt# ls -ld data
drwxr-xr-x    9 root     fat32       16384 Jan  1  1970 data

(and where the hell did that date come from??)

The permissioning on the files inside this directory seems correct, but for 
the directories it is wrong:

-rwxrwx---    1 root     fat32         313 May 27 12:32 afile.ini*
drwxr-xr-x    3 root     fat32       16384 Aug 22 13:01 adir/

which denies me the write rights I need.


Did something change on the fat/vfat/... layer that can cause this to no 
longer function?

If you need some more info, just yell... I hope this issue can be resolved.

DK
-- 
Blore's Razor:
	Given a choice between two theories, take the one which is
funnier.

