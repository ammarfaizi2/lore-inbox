Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVCWVrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVCWVrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVCWVrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:47:08 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:42440 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261387AbVCWVqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:46:42 -0500
Message-ID: <4241E3EA.4080501@comcast.net>
Date: Wed, 23 Mar 2005 16:47:22 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ubuntu-devel <ubuntu-devel@lists.ubuntu.com>, linux-kernel@vger.kernel.org
Subject: vfat broken in 2.6.10?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm using Ubuntu Linux Hoary

root@icebox:~# uname -a
Linux icebox 2.6.10-5-686 #1 Tue Mar 15 15:16:01 UTC 2005 i686 GNU/Linux


root@icebox:~# fsck.vfat -r /dev/sda1
dosfsck 2.10, 22 Sep 2003, FAT32, LFN
/\uffffSCK0000.REN
  Duplicate directory entry.
  First    Size 0 bytes, date 19:03:36 Mar 04 1980
  Second   Size 0 bytes, date 19:00:00 Dec 31 1979
1) Drop first
2) Drop second
3) Rename first
4) Rename second
5) Auto-rename first
6) Auto-rename second
? 5
  Renamed to FSCK0000.REN
Perform changes ? (y/n) y
/dev/sda1: 187 files, 167150/246288 clusters
root@icebox:~# fsck.vfat -r /dev/sda1
dosfsck 2.10, 22 Sep 2003, FAT32, LFN
/dev/sda1: 187 files, 167150/246288 clusters

Now the FS is clean.

root@icebox:~# mount /dev/sda1  /media/usbdisk/
root@icebox:~# vim /media/usbdisk/a.txt
root@icebox:~# rm /media/usbdisk/a.txt

Created, deleted a.txt

root@icebox:~# umount /media/usbdisk/
root@icebox:~# fsck.vfat -r /dev/sda1
dosfsck 2.10, 22 Sep 2003, FAT32, LFN
/\uffff.\000a\000.\000t.\000x\000
  Bad file name.
1) Drop file
2) Rename file
3) Auto-rename
4) Keep it

Does that say a.txt?

? 1
/\uffffa\000.\000t\000x.\000t\000
  Bad file name.
1) Drop file
2) Rename file
3) Auto-rename
4) Keep it
? 1
/\uffff.\000a\000.\000t.\000x\000
  Start cluster beyond limit (7798784 > 246289). Truncating file.
/\uffff.\000a\000.\000t.\000x\000
  File size is 4294967295 bytes, cluster chain length is 0 bytes.
  Truncating file to 0 bytes.
/\uffffa\000.\000t\000x.\000t\000
  Start cluster beyond limit (4294901760 > 246289). Truncating file.
/\uffffa\000.\000t\000x.\000t\000
  File size is 4294967295 bytes, cluster chain length is 0 bytes.
  Truncating file to 0 bytes.
/\uffff.TXT
  Contains a free cluster (167160). Assuming EOF.
/\uffff.TXT
  File size is 5 bytes, cluster chain length is 0 bytes.
  Truncating file to 0 bytes.
Perform changes ? (y/n) y


I didn't pull the disk out at all, or anything.  Just umounted and
remounted and made/removed a file.  Also. . .


/dev/sda1: 189 files, 167150/246288 clusters
root@icebox:~# fsck.vfat -r /dev/sda1
dosfsck 2.10, 22 Sep 2003, FAT32, LFN
/\uffff.\000a\000.\000t.\000x\000
  Bad file name.
1) Drop file
2) Rename file
3) Auto-rename
4) Keep it
? 3
  Renamed to FSCK0001.REN
/\uffffa\000.\000t\000x.\000t\000
  Bad file name.
1) Drop file
2) Rename file
3) Auto-rename
4) Keep it
? 3
  Renamed to FSCK0002.REN
Perform changes ? (y/n) y
/dev/sda1: 191 files, 167150/246288 clusters
root@icebox:~# fsck.vfat -r /dev/sda1
dosfsck 2.10, 22 Sep 2003, FAT32, LFN
/dev/sda1: 191 files, 167150/246288 clusters

It appears dosfsck may not be working quite right.  I've taken this into
account, hence the second pass after each fsck.  This is either a
dosfsck issue, a usb-storage issue for the PNY compact flash drive, or
an issue with vfat itself.

So either LKML needs to fix the drivers, or Ubuntu needs to upgrade/fix
dosfsck or some patch they've applied to the kernel.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCQePohDd4aOud5P8RAhxRAJ9ydXWfLZbu0r/B4rY6zhaWScR3rQCfVNMY
lGsqNpIPDIBREqIWGVlQJFo=
=1Nlg
-----END PGP SIGNATURE-----
