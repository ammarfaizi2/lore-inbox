Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbUCJUNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUCJUNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:13:07 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:22789 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262801AbUCJUM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:12:58 -0500
Message-ID: <404F77F3.9070106@kolumbus.fi>
Date: Wed, 10 Mar 2004 22:17:55 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: /dev/root: which approach ? [PATCH]
References: <20040310162003.GA25688@cistron.nl>
In-Reply-To: <20040310162003.GA25688@cistron.nl>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 10.03.2004 22:15:19,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 10.03.2004 22:14:23,
	Serialize complete at 10.03.2004 22:14:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>My question to the FS hackers: which one is the preferred approach?
>
>
>dev_root_alias.patch
>
>--- linux-2.6.4-rc2-mm1.orig/fs/block_dev.c	2004-03-09 17:14:32.000000000 +0100
>+++ linux-2.6.4-rc2-mm1/fs/block_dev.c	2004-03-10 16:39:30.000000000 +0100
>@@ -338,6 +338,16 @@ struct block_device *bdget(dev_t dev)
> {
> 	struct block_device *bdev;
> 	struct inode *inode;
>+	struct vfsmount *mnt;
>+
>+	/* See if device is the /dev/root alias. */
>+	if (dev == MKDEV(4, 1)) {
>+		read_lock(&current->fs->lock);
>+		mnt = mntget(current->fs->rootmnt);
>+		dev = mnt->mnt_sb->s_dev;
>+		mntput(mnt);
>+		read_unlock(&current->fs->lock);
>+	}
> 
> 	inode = iget5_locked(bd_mnt->mnt_sb, hash(dev),
> 			bdev_test, bdev_set, &dev);
>  
>
what is this 4,1, a tty???

--Mika


