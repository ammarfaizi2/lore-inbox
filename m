Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSIKBeC>; Tue, 10 Sep 2002 21:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318272AbSIKBeC>; Tue, 10 Sep 2002 21:34:02 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1920 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S318270AbSIKBeA>;
	Tue, 10 Sep 2002 21:34:00 -0400
Date: Tue, 10 Sep 2002 20:38:47 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5.34-bk floppy weirdness
Message-ID: <Pine.LNX.4.44.0209102034300.944-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following appeared with the latest bk updated kernel.  It was not 
present with the 2.5.33 version, nor with a 2.4 kernel version.

I cannot dd to the floppy until either it has been mounted, or until the 
superuser has dd'd to the floppy.  The following is from a fresh boot:

[tmolina@dad testfloppystable]$ ls
floppy  floppyimage
[tmolina@dad testfloppystable]$ ls -l /dev/fd0
brw-rw----    1 tmolina  floppy     2,   0 Apr 11 09:25 /dev/fd0
[tmolina@dad testfloppystable]$ ls -l
total 1448
drwxr-xr-x    2 tmolina  tmolina      4096 Dec 31  1969 floppy
-rw-rw-r--    1 tmolina  tmolina   1474560 Sep  1 09:49 floppyimage
[tmolina@dad testfloppystable]$ dd if=floppyimage of=/dev/fd0
dd: opening `/dev/fd0': No such device or address
[tmolina@dad testfloppystable]$ su
Password:
[root@dad testfloppystable]# dd if=floppyimage of=/dev/fd0
2880+0 records in
2880+0 records out
[root@dad testfloppystable]# exit
exit
[tmolina@dad testfloppystable]$ dd if=floppyimage of=/dev/fd0
2880+0 records in
2880+0 records out
[tmolina@dad testfloppystable]$ ls -l /dev/fd0
brw-rw----    1 tmolina  floppy     2,   0 Apr 11 09:25 /dev/fd0
[tmolina@dad testfloppystable]$

>From a subsequent fresh boot I get:

[tmolina@dad testfloppystable]$ dd if=floppyimage of=/dev/fd0
dd: opening `/dev/fd0': No such device or address
[tmolina@dad testfloppystable]$ mount /dev/fd0
FAT: Using codepage iso8859-1
FAT: Using IO charset iso8859-1
[tmolina@dad testfloppystable]$ ls -l /mnt/floppy
total 1418
-rwxrwxr-x    1 tmolina  tmolina    124623 Sep  1 09:32 current
-rwxrwxr-x    1 tmolina  tmolina       187 Sep  1 09:29 fetchmailrc
-rwxrwxr-x    1 tmolina  tmolina     95508 Sep  1 09:32 kernelstable
-rwxrwxr-x    1 tmolina  tmolina      1221 Sep  1 09:28 lynx_bookmarks.html
-rwxrwxr-x    1 tmolina  tmolina       390 Jun 15 12:12 mirror.defaults
-r-xr-xr-x    1 tmolina  tmolina      4489 Jun 19 20:56 monster.com resume.txt
-rwxrwxr-x    1 tmolina  tmolina     13735 Aug 29 14:37 msgs.txt
-rwxrwxr-x    1 tmolina  tmolina       787 Sep  1 09:28 procmailrc
-r-xr-xr-x    1 tmolina  tmolina     29184 Jun 19 20:56 resume 2000.06.21.doc
-rwxrwxr-x    1 tmolina  tmolina     15360 May 20 06:49 Resume.doc
-rwxrwxr-x    1 tmolina  tmolina    798026 Sep  1 09:31 saved-messages
-rwxrwxr-x    1 tmolina  tmolina      4287 Sep  1 09:26 test.txt
-rwxrwxr-x    1 tmolina  tmolina     37376 Aug 31 07:43 tomresume.doc
-rwxrwxr-x    1 tmolina  tmolina      4068 Aug 31 07:27 tomresume.txt
-rwxrwxr-x    1 tmolina  tmolina     45330 Sep  1 09:29 upgrade.log
-rwxrwxr-x    1 tmolina  tmolina    274292 Sep  1 09:32 valhalla
[tmolina@dad testfloppystable]$ umount /dev/fd0
[tmolina@dad testfloppystable]$ dd if=floppyimage of=/dev/fd0
2880+0 records in
2880+0 records out
[tmolina@dad testfloppystable]$


