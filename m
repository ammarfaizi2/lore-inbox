Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTBKHiy>; Tue, 11 Feb 2003 02:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTBKHiy>; Tue, 11 Feb 2003 02:38:54 -0500
Received: from viefep16-int.chello.at ([213.46.255.17]:42312 "EHLO
	viefep16-int.chello.at") by vger.kernel.org with ESMTP
	id <S267189AbTBKHix>; Tue, 11 Feb 2003 02:38:53 -0500
Message-ID: <3E48AAD1.6060200@freemail.hu>
Date: Tue, 11 Feb 2003 08:48:33 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] module-init-tools vs. mkinitrd
Content-Type: multipart/mixed;
 boundary="------------010901000502070300080903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010901000502070300080903
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rusty, Alan,

I am using RedHat 8.0 and experimenting sometimes with 2.5.x.
Some time ago I installed modutils-2.4.21-12 from Rusty's directory
from kernel.org and yesterday I upgraded to the latest RH errata kernel.
What surprised me was that the upgraded kernel did not boot up.
The problem is that mkinitrd does not copy /sbin/insmod.static.old
to the initrd image. Using the attached patch or downgrading to the RH8
modutils before upgrading the kernel fixes it.

Best regards,
Zoltán Böszörményi


--------------010901000502070300080903
Content-Type: text/plain;
 name="mkinitrd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mkinitrd.diff"

--- /sbin/mkinitrd.old	2002-09-05 07:07:04.000000000 +0200
+++ /sbin/mkinitrd	2003-02-10 20:40:04.000000000 +0100
@@ -501,6 +501,10 @@
 
 inst /sbin/nash "$MNTIMAGE/bin/nash"
 inst /sbin/insmod.static "$MNTIMAGE/bin/insmod"
+if [ -x /sbin/insmod.static.old ]
+then
+  inst /sbin/insmod.static.old "$MNTIMAGE/bin/insmod.old"
+fi
 ln -s /sbin/nash $MNTIMAGE/sbin/modprobe
 
 for MODULE in $MODULES; do

--------------010901000502070300080903--

