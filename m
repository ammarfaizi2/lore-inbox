Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWCAUZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWCAUZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWCAUZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:25:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750713AbWCAUZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:25:39 -0500
Date: Wed, 1 Mar 2006 12:19:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: efault@gmx.de, nickpiggin@yahoo.com.au, laurent.riffard@free.fr,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060301121912.7d1a7376.akpm@osdl.org>
In-Reply-To: <20060301121218.68fb3f76.akpm@osdl.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
	<1141221511.7775.10.camel@homer>
	<4405B4AA.7090207@free.fr>
	<1141227199.10460.2.camel@homer>
	<20060301121218.68fb3f76.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Nick, isn't it simply a matter of..

err...

--- devel/fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix	2006-03-01 12:16:22.000000000 -0800
+++ devel-akpm/fs/dcache.c	2006-03-01 12:18:34.000000000 -0800
@@ -100,6 +100,7 @@ static void dentry_iput(struct dentry * 
 	if (inode) {
 		dentry->d_inode = NULL;
 		list_del_init(&dentry->d_alias);
+		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
 		if (!inode->i_nlink)
_

