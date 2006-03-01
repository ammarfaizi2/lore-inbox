Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWCAKtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWCAKtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWCAKtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:49:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11751 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964911AbWCAKtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:49:16 -0500
Date: Wed, 1 Mar 2006 02:47:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060301024759.33da3727.akpm@osdl.org>
In-Reply-To: <440578F6.5060107@free.fr>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<440578F6.5060107@free.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> Well, I should have check my logs... There is a bunch of BUGs  
>  when I launch Gnome:
> 
>  BUG: warning at fs/inotify.c:533/inotify_d_instantiate()

yup, that's a known-about warning for something which is harmless.  We're
still working out what to do about that.  The short-term solution is to
remove it.

--- devel/fs/inotify.c~a	2006-03-01 02:47:01.000000000 -0800
+++ devel-akpm/fs/inotify.c	2006-03-01 02:47:06.000000000 -0800
@@ -530,7 +530,6 @@ void inotify_d_instantiate(struct dentry
 	if (!inode)
 		return;
 
-	WARN_ON(entry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
 	spin_lock(&entry->d_lock);
 	parent = entry->d_parent;
 	if (inotify_inode_watched(parent->d_inode))
_

