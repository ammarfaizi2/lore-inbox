Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUBOSiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 13:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUBOSiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 13:38:46 -0500
Received: from libra.i-cable.com ([203.83.111.73]:58580 "HELO
	libra.i-cable.com") by vger.kernel.org with SMTP id S265141AbUBOSin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 13:38:43 -0500
Message-ID: <01f201c3f3f3$762bf2a0$353ffea9@kyle>
From: "Kyle" <kyle@southa.com>
To: <linux-kernel@vger.kernel.org>
Subject: raidhotadd freeze server (kernel 2.6.1)
Date: Mon, 16 Feb 2004 02:42:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I found that one of my harddisk (/dev/hda) failed, /dev/hda and
/dev/hdc are md-raid1 mirrored.

Feb 13 23:06:08 s1 kernel: hda: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Feb 13 23:06:08 s1 kernel: hda: dma_intr: error=0x40 { UncorrectableError },
LBAsect=159025049, high=9, low=8030105,sector=159025044
Feb 13 23:06:08 s1 kernel: end_request: I/O error, dev hda, sector 159025044
Feb 13 23:06:08 s1 kernel: raid1: Disk failure on hda3, disabling device.
Feb 13 23:06:08 s1 kernel: ^IOperation continuing on 1 devices
Feb 13 23:06:08 s1 kernel: raid1: hda3: rescheduling sector 154719624
Feb 13 23:06:08 s1 kernel: raid1: hdc3: redirecting sector 154719624 to
another mirror
Feb 13 23:06:09 s1 kernel: RAID1 conf printout:
Feb 13 23:06:09 s1 kernel:  --- wd:1 rd:2
Feb 13 23:06:09 s1 kernel:  disk 0, wo:0, o:1, dev:hdc3
Feb 13 23:06:09 s1 kernel:  disk 1, wo:1, o:0, dev:hda3
Feb 13 23:06:09 s1 kernel: RAID1 conf printout:
Feb 13 23:06:09 s1 kernel:  --- wd:1 rd:2
Feb 13 23:06:09 s1 kernel:  disk 0, wo:0, o:1, dev:hdc3

Then I tried:
raidhotremove /dev/md1 /dev/hda3
and then wondering if I raidhotadd back /dev/hda3, the harddisk would be
okay ......:
raidhotadd /dev/md1 /dev/hda3

and my server freeze immediately!
/dev/md0 -> /boot
/dev/md1 -> /
/dev/md2 -> swap

I have to press the reset button to reboot the machine.

at /var/log/message, I found:
Feb 15 23:45:23 s1 kernel: process `nslookup' is using obsolete setsockopt
SO_BSDCOMPAT
Feb 15 23:52:01 s1 kernel: md: trying to hot-add hda3 to md1 ...
Feb 15 23:52:01 s1 kernel: md: could not lock hda3.
Feb 15 23:52:01 s1 kernel: md: error, md_import_device() returned -16
Feb 15 23:53:07 s1 kernel: md: trying to hot-add hda3 to md1 ...
Feb 15 23:53:07 s1 kernel: md: could not lock hda3.
Feb 15 23:53:07 s1 kernel: md: error, md_import_device() returned -16
Feb 15 23:55:54 s1 kernel: md: trying to hot-add hda3 to md1 ...
Feb 15 23:55:54 s1 kernel: md: could not lock hda3.
Feb 15 23:55:54 s1 kernel: md: error, md_import_device() returned -16
Feb 15 23:57:47 s1 kernel: md: trying to hot-add hda3 to md1 ...
Feb 15 23:57:47 s1 kernel: md: could not lock hda3.
Feb 15 23:57:47 s1 kernel: md: error, md_import_device() returned -16
Feb 15 23:59:02 s1 kernel: md: trying to hot-add hda3 to md1 ...
Feb 15 23:59:02 s1 kernel: md: could not lock hda3.
Feb 15 23:59:02 s1 kernel: md: error, md_import_device() returned -16
Feb 15 23:59:14 s1 kernel: md: trying to hot-add md1 to md1 ...
Feb 15 23:59:19 s1 kernel: md: could not lock md1.
Feb 15 23:59:19 s1 kernel: md: error, md_import_device() returned -4
Feb 15 23:59:49 s1 kernel: md: trying to hot-add hdc3 to md1 ...
Feb 15 23:59:49 s1 kernel: md: could not lock hdc3.
Feb 15 23:59:49 s1 kernel: md: error, md_import_device() returned -16
Feb 16 00:00:30 s1 kernel: md: trying to remove hda3 from md1 ...
Feb 16 00:00:30 s1 kernel: md: unbind<hda3>
Feb 16 00:00:30 s1 kernel: md: export_rdev(hda3)
Feb 16 01:13:24 s1 syslogd 1.4.1: restart.    <- hard rebooted
Feb 16 01:13:24 s1 syslog: syslogd startup succeeded
Feb 16 01:13:24 s1 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Feb 16 01:13:24 s1 kernel: Linux version 2.6.1 (root@s1.pbasehk.com) (gcc
versi$
Feb 16 01:13:24 s1 kernel: BIOS-provided physical RAM map:
........

Is it kernel problem, or md problem or my problem?

Please CC my email since I read the list from web, thanks!

Kyle



