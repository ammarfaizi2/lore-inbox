Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272249AbTGYShZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272250AbTGYShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:37:25 -0400
Received: from dialpool-210-214-166-50.maa.sify.net ([210.214.166.50]:5276
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S272249AbTGYShU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:37:20 -0400
Date: Sat, 26 Jul 2003 00:23:25 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Cc: wodecki@gmx.de
Subject: Re: 2.6.0-test1 devfs question
Message-ID: <20030725185325.GA3944@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,

>I'm currently running at 2.6.0-test1-mm2-O8 and I wanted to give devfs a
>shot. I recompiled the kernel with the following settings:
>CONFIG_DEVFS_FS=y
>CONFIG_DEVFS_MOUNT=y
># CONFIG_DEVFS_DEBUG is not set

>As I read through the documentation (btw, devfs=nomount is mentioned in
>configure help but not in Documentation/filesystems/devfs/boot-options)
>I got the understanding that this shouldn't make any difference to the
>system right? After booting with this kernel there were lots of proper
>devfs devices in my dmesg (host0/ide0... scsi0/...) however, the system
>didn't came up (couldn't mount rootfs). It didn't even work when I
>enabled CONFIG_DEVFS_MOUNT.

>I'm not sure whether this is a bug in mount/nomount of devfs or if it's
>somewhere my fault/setup (root on raid1, various lvm2 devices on raid1/0
>devices)

>Any help would be greatly appreciated.


You need to change your /etc/fstab to reflect the new devfs device names,
ex: "/dev/discs/disc0/part1" instead of "/dev/hda1". You can also use devfsd (or some alternative) to make synlinks to the older devices and retain permissions etc... Also, without devfsd you cannot expect module autoloading as modules can't be automatically loaded when theres no device requesting them (in this case the device simply doesn't exist until module is loaded)
