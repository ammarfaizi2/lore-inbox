Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSEWS2w>; Thu, 23 May 2002 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316979AbSEWS2w>; Thu, 23 May 2002 14:28:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316978AbSEWS2s>; Thu, 23 May 2002 14:28:48 -0400
Date: Thu, 23 May 2002 14:28:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Some kind of race with loop in 2.4.18
Message-ID: <Pine.LNX.3.95.1020523141527.1243A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I create a 650 Mb file, make an ext2 file-system on it, then
mount it through the loop device on /mnt. It seems that I have
a virtual file-system that I could used to make an image, eventually
to burn a CR-ROM. This is how I've been doing it, but.... with
2.4.18, there is a problem.

Once the file-syetem gets about 50% full, using tar to copy
some directories from my hard disk, the hard-disk light remains
on continuously, but the file-system doesn't get any fuller.

10 second intervals, nothing happening plus SCSI Disk drive
continuously active....

Script started on Thu May 23 14:11:21 2002
# while df ; do sleep 10 ; done
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708780  10051188  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sdb1             16603376   5708812  10051156  36% /
/dev/sdc1              6356624   1198700   4835020  20% /alt
/dev/sdc3              2253284   1383916    754908  65% /home/users
/dev/sda1              1048272    282208    766064  27% /dos/drive_C
/dev/sda5              1046224    181280    864944  17% /dos/drive_D
/root/cdrom.root/cdrom.img
                        554284    262318    263806  50% /mnt

# exit
exit

Script done on Thu May 23 14:14:08 2002

None of the disks are full, and there is plenty of free RAM, etc.
I let this go one for about an hour, then I tried to ^C out of
`tar`.  Well no, it's in the 'D' state forever....

If I create the VFS (loop-mounted file) on a disk that I am not tarring
from, tar completes okay.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

