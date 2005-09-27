Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVI0B3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVI0B3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 21:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVI0B3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 21:29:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964783AbVI0B3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 21:29:33 -0400
Date: Mon, 26 Sep 2005 18:29:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
cc: linux-kernel@vger.kernel.org, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Michal Wronski <michal.wronski@gmail.com>
Subject: Re: [PATCH] umask in POSIX message queues
In-Reply-To: <Pine.GSO.4.58.0509261218080.5216@Juliusz>
Message-ID: <Pine.LNX.4.58.0509261827150.3308@g5.osdl.org>
References: <Pine.GSO.4.58.0509261218080.5216@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Sep 2005, Krzysztof Benedyczak wrote:
> 
> All kernels (form 2.6.6) ignore umask when creating new queues via
> mq_open (when creating with open() on mqueue fs it is ok of course).
> According to specification this a bug. The following trivial patch fixes
> this. It should apply cleanly to any current kernel. Please apply.

As far as I can tell, the VFS layer should have done this for us already, 
with code like

		...
                if (!IS_POSIXACL(dir->d_inode))
                        mode &= ~current->fs->umask;
                error = vfs_create(dir->d_inode, path.dentry, mode, nd);
		...

in fs/namei.c (open_namei()).

Which path did you come through that didn't do this? That would be the
real bug, I suspect..

		Linus
