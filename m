Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbTGDLih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbTGDLih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:38:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:34043 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265992AbTGDLig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:38:36 -0400
Message-Id: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Fri, 04 Jul 2003 13:57:19 +0200
To: linux-kernel@vger.kernel.org
From: Sancho Dauskardt <sda@bdit.de>
Subject: FAT statfs loop abort on read-error
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  i've written to the current FAT maintainer (Gordon Chaffee) about this, 
but he's no longer active, so:

While working in the usb-sotrage area (mostly with removeable media, eg. 
CompactFlash in USB-Readers), i've come across a litte odd behaviour:

  when calling statfs on a volume that has been removed (without umount) 
fat_statfs() will attempt to read all sectors of the fat table quite a few 
times (depending on the fat type, eg. FAT16 --> 256 times).

eg:
1. mount /dev/sda1 /mnt/cf
2. remove card
3. df

on my system, for a 16 MB CompactFlash formated with FAT-16 this takes 47 
seconds.

Possible solution:
1. let default_fat_access return something like -2 on 'can't read' error.
2. Abort stafs loop on error.
3. return -EIO

This would break mode fat_access calls. I could make a patch, but I don't 
know what's going on with those cvf extensions (which seem to replace 
fat_access). Is dmsdos dead / can we ignore it ?
Somewhere in the list archives, I found comments about the cvf stuff being 
completely removed ?


Thanks,
- sda

