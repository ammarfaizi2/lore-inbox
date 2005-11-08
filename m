Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVKHOMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVKHOMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbVKHOME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:12:04 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:59666 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S965067AbVKHOMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:12:03 -0500
To: viro@ftp.linux.org.uk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
In-reply-to: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> (message from Al Viro on
	Tue, 08 Nov 2005 02:01:31 +0000)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
Message-Id: <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 08 Nov 2005 15:11:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
>  {
> -	mnt->mnt_parent = mntget(nd->mnt);
> -	mnt->mnt_mountpoint = dget(nd->dentry);
> -	list_add(&mnt->mnt_hash, mount_hashtable + hash(nd->mnt, nd->dentry));
> +	mnt_set_mountpoint(nd->mnt, nd->dentry, mnt);
> +	list_add_tail(&mnt->mnt_hash, mount_hashtable +
> +			hash(nd->mnt, nd->dentry));

Ram,

IIRC the list_add -> list_add_tail change has been voted down.  Or do
you have new reasons why it's needed?

Miklos
