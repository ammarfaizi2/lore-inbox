Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268513AbRGXXQC>; Tue, 24 Jul 2001 19:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbRGXXP4>; Tue, 24 Jul 2001 19:15:56 -0400
Received: from jalon.able.es ([212.97.163.2]:25776 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S268513AbRGXXPk>;
	Tue, 24 Jul 2001 19:15:40 -0400
Date: Wed, 25 Jul 2001 00:59:40 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.7 tmpfs strange behaviour
Message-ID: <20010725005940.A5607@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi.

I have notice some strange behaviour for tmpfs/shmfs. It seems to define the
device somehow related to the cwd where the mount command is issued.
I will explain. This is the relevant part of my /etc/fstab:

tmpfs /dev/shm tmpfs defaults,size=128M 0 0

And now I try to mount it:

werewolf:~# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               248895     79908    156137  34% /
/dev/sda2              3099292   2080088    861768  71% /usr
/dev/sda3              4095488   1591936   2295512  41% /home
/dev/sda5              1027768         4    975556   1% /toast
/dev/sdb1              4232960     32840   4200120   1% /mnt/disk
werewolf:~# mount -a -t tmpfs
werewolf:~# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               248895     79908    156137  34% /
/dev/sda2              3099292   2080088    861768  71% /usr
/dev/sda3              4095488   1591936   2295512  41% /home
/dev/sda5              1027768         4    975556   1% /toast
/dev/sdb1              4232960     32840   4200120   1% /mnt/disk
/root/tmpfs             131072         0    131072   0% /dev/shm
werewolf:~# cd /tmp
werewolf:/tmp# mount -a -t tmpfs
werewolf:/tmp# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1               248895     79908    156137  34% /
/dev/sda2              3099292   2080088    861768  71% /usr
/dev/sda3              4095488   1591936   2295512  41% /home
/dev/sda5              1027768         4    975556   1% /toast
/dev/sdb1              4232960     32840   4200120   1% /mnt/disk
/root/tmpfs             131072         0    131072   0% /dev/shm
/tmp/tmpfs              131072         0    131072   0% /dev/shm

???? Strange devices.... both mounted under /dev/shm.

BTW, look at /etc/mtab:
werewolf:/tmp# cat /etc/mtab
/dev/sda1 / ext2 rw 0 0
/procfs /proc proc rw 0 0
^
devpts /dev/pts devpts rw,mode=0620 0 0
/dev/sda2 /usr ext2 rw 0 0
/dev/sda3 /home ext2 rw 0 0
/dev/sda5 /toast ext2 rw 0 0
/dev/sdb1 /mnt/disk reiserfs rw 0 0
/root/tmpfs /dev/shm tmpfs rw,size=128M 0 0
^^^^^^^^^^^
/tmp/tmpfs /dev/shm tmpfs rw,size=128M 0 0
^^^^^^^^^^

Why devpts is just plain 'devpts', and procfs is '/procfs' ??? Some bug
that generates device name with cwd for all special filesystems but devpts ?

Kernel or mount bug ?

TIA

--
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7 #1 SMP Mon Jul 23 01:55:36 CEST 2001 i686
