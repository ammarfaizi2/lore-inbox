Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270370AbUJTOMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbUJTOMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269974AbUJTOJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:09:38 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:44805 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S270009AbUJTOD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:03:58 -0400
Message-ID: <002101c4b6ad$9fe6d880$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: Strange! Cannot use JFFS2 as root
Date: Wed, 20 Oct 2004 22:03:45 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/10/20 =?Bog5?B?pFWkyCAxMDowNTowMA==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/10/20
 =?Bog5?B?pFWkyCAxMDowNTowMQ==?=,
	Serialize complete at 2004/10/20 =?Bog5?B?pFWkyCAxMDowNTowMQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all,
I had booted up Linux with nfs root, and write a JFFS2 image to /dev/mtd1.
Here is my cmdline for Kernel:
     go 0x80305018 root=/dev/nfs rw nfsroot=172.19.26.145:/nfs/rootfs
ip=172.19.27.193::172.19.27.254:255.255.254.0:::
mtdparts=maltaflash:1536k(ldr),2048k(root)

After writing the JFFS2 image to /dev/mtd1, I can mount /dev/mtdblcok1 to
some directory.
    mount -t jffs2 /dev/mtdblock1 /mnt

Next, I hope to boot up Linux with JFFS2 root, and try to give this cmdline
to Kernel:
    go 0x80305018 rootfstype=jffs2
mtdparts=maltaflash:1536k(ldr),2048k(root) root=/dev/mtdblock1

and the Kernel would complain me about no root:
    VFS: Unable to mount root fs via NFS, trying floppy.
    Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)

I traced the code and found that when passing "/dev/mtdblock1" to
name_to_dev_t() in do_mounts.c, it would return 0 at every try_name(), which
will fail at open() with the path "/sys/block/%s/dev".

What's the problem? Could anyone tell me?

Thanks and regards,
Colin




