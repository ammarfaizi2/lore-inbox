Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVI0UWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVI0UWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVI0UWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:22:24 -0400
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:5101 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S932384AbVI0UWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:22:23 -0400
Date: Tue, 27 Sep 2005 22:21:36 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Michal Wronski <michal.wronski@gmail.com>
Subject: Re: [PATCH] umask in POSIX message queues
In-Reply-To: <Pine.LNX.4.58.0509270754290.3308@g5.osdl.org>
Message-ID: <Pine.GSO.4.58.0509272216370.29468@Juliusz>
References: <Pine.GSO.4.58.0509261218080.5216@Juliusz>
 <Pine.LNX.4.58.0509261827150.3308@g5.osdl.org> <Pine.GSO.4.58.0509271246570.2336@Juliusz>
 <Pine.LNX.4.58.0509270754290.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005, Linus Torvalds wrote:

> On Tue, 27 Sep 2005, Krzysztof Benedyczak wrote:
> >
> > After rereading it I think that the better place for the line setting
> > umask is do_create() function as it will be on the same level as
> > open_namei(). I hope this change will clarify things.
> >
> > If this make sense I'll send a patch.
>
> Yes, that makes more sense.
>
> Please do send a tested patch,

Setting umask moved to do_create and tested once again.
Krzysiek

Signed-off-by: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>

--- linux-2.6.14-rc2/ipc/mqueue.c.orig  2005-09-25 18:52:29.000000000 +0200
+++ linux-2.6.14-rc2/ipc/mqueue.c       2005-09-27 22:12:41.692903624 +0200
@@ -611,6 +611,7 @@ static struct file *do_create(struct den
                dentry->d_fsdata = &attr;
        }

+       mode &= ~current->fs->umask;
        ret = vfs_create(dir->d_inode, dentry, mode, NULL);
        dentry->d_fsdata = NULL;
        if (ret)

