Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVHDGEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVHDGEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVHDGEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:04:15 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:51913 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261855AbVHDGEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:04:04 -0400
Date: Thu, 4 Aug 2005 08:03:21 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Mark Bellon <mbellon@mvista.com>, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] IDE disks show invalid geometries in /proc/ide/hd*/geometry
In-Reply-To: <58cb370e05080311517e6c02a8@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508040800130.22272@yvahk01.tjqt.qr>
References: <42EFE547.3010206@mvista.com>  <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
  <58cb370e05080310195c244f72@mail.gmail.com>  <42F100C8.8040700@mvista.com>
  <58cb370e05080311056a9276c0@mail.gmail.com>  <42F10DB8.4020601@mvista.com>
 <58cb370e05080311517e6c02a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Simple: do not use BIOS values.
>[ Yes, there should be some warning from kernel. ]

On that matter, I get a warning from LILO wrt cyls and stuff:

07:47 spectre:~ # cat /proc/ide/hda/geometry 
physical     16383/16/63
logical      65535/16/63
07:58 spectre:~ # lilo
Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
    Kernel: 65535 cylinders, 16 heads, 63 sectors
      BIOS: 1023 cylinders, 255 heads, 63 sectors
Added linux *
07:59 spectre:~ # fdisk -l

Disk /dev/hda: 40.9 GB, 40982151168 bytes
255 heads, 63 sectors/track, 4982 cylinders


All of these numbers are virtual, since CHS is not really used anymore, as 
we know. But, which of these fake CHS values (16383/16/63 | 65535/16/63 | 
1023/255/63) is the right one? 255/63/4982 is another matter, since it 
[almost] matches the actual size of the disk while the other three are just 
"for the bios".



Jan Engelhardt
-- 
