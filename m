Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTG1K7z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 06:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTG1K7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 06:59:55 -0400
Received: from mx.laposte.net ([213.30.181.11]:62937 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261874AbTG1K7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 06:59:53 -0400
Message-ID: <005501c354f9$88a1c980$0a00a8c0@toumi>
From: "Ghozlane Toumi" <gtoumi@laposte.net>
To: <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
References: <UTC200307271402.h6RE29E24642.aeb@smtp.cwi.nl>
Subject: Re: 2.6.0-test1 on alpha : disk label numbering trouble
Date: Mon, 28 Jul 2003 13:15:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm trying to run 2.6.0-test1 on an alpha box, 
> > and  apparently, the osf partition numbering is wrong:
>
> Can you give some information? Output of fdisk -l and
> dmesg | grep sda for 2.4 and 2.6?
>

Sure . here you go :

---- 

Script started on Mon 28 Jul 2003 12:10:55 PM CEST
[root@den /root]# uname -a
Linux den 2.4.19-pre10-usb #15 Thu Sep 5 16:27:31 CEST 2002 alpha unknown
[root@den /root]#
[root@den /root]# dmesg | grep sda
Command line: root=/dev/sda5 console=ttyS0,9600n8 console=tty0 4
Kernel command line: root=/dev/sda5 console=ttyS0,9600n8 console=tty0 4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 8380080 512-byte hdwr sectors (4291 MB)
 sda: sda3 sda4 sda5
[root@den /root]# fdisk -l /dev/sda

Disk /dev/sda: 4290 MB, 4290600960 bytes
255 heads, 63 sectors/track, 521 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes


5 partitions:
#       start       end      size     fstype   [fsize bsize   cpg]
  c:        1       521       521     unused        0     0
  d:        2        18        17       swap
  e:       19       521       503       ext2
[root@den fdisk]# exit
Script done on Mon 28 Jul 2003 12:11:36 PM CEST

----

Script started on Mon Jul 28 12:21:23 2003
[root@den /root]# uname -a
Linux den 2.6.0-test1-feral #5 Sat Jul 26 14:45:33 CEST 2003 alpha unknown
[root@den /root]#
[root@den /root]# dmesg | grep sda
Command line: ro root=/dev/sda3 console=ttyS0,9600n8 8
Kernel command line: ro root=/dev/sda3 console=ttyS0,9600n8 8
SCSI device sda: 8380080 512-byte hdwr sectors (4291 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
[root@den /root]#
[root@den /root]# fdisk/fdisk -l /dev/sda

Disk /dev/sda: 4290 MB, 4290600960 bytes
255 heads, 63 sectors/track, 521 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes


5 partitions:
#       start       end      size     fstype   [fsize bsize   cpg]
  c:        1       521       521     unused        0     0
  d:        2        18        17       swap
  e:       19       521       503       ext2
[root@den /root]#
Script done on Mon Jul 28 12:22:24 2003

----

Apparently, 2.6 don't try to mach partition number with slides ...

ghoz

