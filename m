Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSKNVQy>; Thu, 14 Nov 2002 16:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSKNVQx>; Thu, 14 Nov 2002 16:16:53 -0500
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:17427 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S265238AbSKNVQw>; Thu, 14 Nov 2002 16:16:52 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200211142115.gAELFNm0002811@wildsau.idv.uni.linz.at>
Subject: bug: cant write to solaris partitioned disk
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2002 22:15:20 +0100 (MET)
Cc: herp@wildsau.idv.uni.linz.at (Herbert Rosmanith),
       kernel@wildsau.idv.uni.linz.at (H.Rosmanith (Kernel Mailing List)),
       ferdl@wildsau.idv.uni.linz.at (Ferdinand Goldmann)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

after not being active on a solaris machine, I forgot the root-password.
since the machine is a blade100, I just plugged the harddisk to my
linux-workstation, mounted the filesystem with ufs, but no matter what,
I was not able to reset the root-password by modifying /mnt/etc/shadow,
allthough I had CONFIG_EXPERIMENTAL=y and CONFIG_UFS_FS_WRITE=y and
specifed -o ufstype=sun on the mount-command-line.

therefore, I tried a different approach: search the partition for
the string "root:cryptpw:1234:::::" and clear the root-pw with
"dd". so I specified "dd if=newrootpw of=/dev/hdc1 bs=4096 seek=10794 count=1"
(the 10794 are the result of the previous search-operation). since I
couldnt get "dd" to work, I wrote a small helperprog, which does an
"lseek(fd,4096*10794,SEEK_SET)" and then write the new shadow-entry with
the cleared root-pw. but that one failed too!! the error-code I got
was -EBADF. quite strange.

so I tried another approach, which worked: copy the *whole* solaris-partition
to my linux-disk, make a copy of that, modify the root-pw on the copy and
copy the whole partition back. that worked, and I am now logged in as
root with no password on the blade100 again (phew!).

so, what the bug seems to me: it is not possible to write() to a solaris
partition when previously, an lseek() operation has been performed, in
contrast, write()ing without lseek()ing *is* possible.

bug or feature?

please comment/fix, thank you,
herbert rosmanith





