Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUBMDNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUBMDNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:13:20 -0500
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:3972 "EHLO
	mail.jg555.com") by vger.kernel.org with ESMTP id S266692AbUBMDNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:13:18 -0500
Message-ID: <015501c3f1df$42cd7cf0$d300a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Initrd Question
Date: Thu, 12 Feb 2004 19:12:48 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote the initrd hint for the Linux from Scratch. I have followed the
initrd.txt exactly to the letter. The problem I have noticed is with one of
the commands, and I checked other mkinitrd scripts and they have the
workaround in it.

According to initrd.txt the  echo 0x301 >/proc/sys/kernel/real-root-dev is
for the old change root mechanism, but I have tried to elminate that from my
script and it fails everytime saying it can't find the root, the infamous
Kernel panic: VFS: Unable to mount root fs on xx:xx. Here is my linuxrc
script that is built from my mkinitrd script which can be viewed at
http://cvs.jg555.com/viewcvs.cgi/scripts/system/mkinitrd.

I use busybox for my script so I can keep the size down. My current size is
only 387k.

#!/bin/sh

echo "Initial RAMDISK Loading Starting..."
insmod /lib/megaraid.ko
insmod /lib/aic7xxx.ko
insmod /lib/uhci-hcd.ko
echo "Mounting proc..."
mount -n -t proc none /proc
echo 0x0100 > /proc/sys/kernel/real-root-dev
echo "Mounting real root dev..."
mount -n -o ro /dev/sda2 /new_root
echo "Running pivot_root..."
pivot_root /new_root /new_root/initrd
if [ -c initrd/dev/.devfsd ]
  then
          echo "Mounting devfs..."
          mount -n -t devfs none dev
fi
if [ $$ = 1 ]
  then
          echo "Running init..."
          exec chroot . sbin/init dev/console 2>&1
  else
          echo "Using bug circumvention for busybox..."
          exec chroot . sbin/linuxrc dev/console 2>&1
fi
echo "Initial RAMDISK Loading Completed..."



----
Jim Gifford
maillist@jg555.com

