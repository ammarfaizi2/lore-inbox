Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTGFRK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTGFRK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:10:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57475 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263023AbTGFRKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:10:55 -0400
Date: Sun, 6 Jul 2003 10:24:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sancho Dauskardt <sda@bdit.de>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FAT statfs loop abort on read-error
Message-Id: <20030706102410.2becd137.rddunlap@osdl.org>
In-Reply-To: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
References: <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Jul 2003 13:57:19 +0200 Sancho Dauskardt <sda@bdit.de> wrote:

| Hi all,
| 
|   i've written to the current FAT maintainer (Gordon Chaffee) about this, 
| but he's no longer active, so:
| 
| While working in the usb-sotrage area (mostly with removeable media, eg. 
| CompactFlash in USB-Readers), i've come across a litte odd behaviour:
| 
|   when calling statfs on a volume that has been removed (without umount) 
| fat_statfs() will attempt to read all sectors of the fat table quite a few 
| times (depending on the fat type, eg. FAT16 --> 256 times).
| 
| eg:
| 1. mount /dev/sda1 /mnt/cf
| 2. remove card
| 3. df
| 
| on my system, for a 16 MB CompactFlash formated with FAT-16 this takes 47 
| seconds.
| 
| Possible solution:
| 1. let default_fat_access return something like -2 on 'can't read' error.
| 2. Abort stafs loop on error.
| 3. return -EIO
| 
| This would break mode fat_access calls. I could make a patch, but I don't 
| know what's going on with those cvf extensions (which seem to replace 
| fat_access). Is dmsdos dead / can we ignore it ?
| Somewhere in the list archives, I found comments about the cvf stuff being 
| completely removed ?

Try asking OGAWA Hirofumi (cc-ed).  He's the de facto FAT maintainter.
(I asked him to add a patch to MAINTAINTERS...)

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
