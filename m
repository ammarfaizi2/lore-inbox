Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVEKUb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVEKUb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVEKUb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:31:59 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:33805 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262044AbVEKUbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:31:45 -0400
To: linuxram@us.ibm.com
CC: jamie@shareable.org, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <1115840139.6248.181.camel@localhost> (message from Ram on Wed,
	11 May 2005 12:35:39 -0700)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it>
	 <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it>
	 <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
	 <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <1115840139.6248.181.camel@localhost>
Message-Id: <E1DVxrB-0002KF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 22:31:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if proc filesystem is removed from the kernel?
> 
> Ability to access some other namespace through the proc filesystem does
> not look clean. I think it should be cleanly supported through VFS.
> 
> Also cd'ing into a new namespace just allows you to browse through
> the other namespace. But it does not effectively change the process's
> namespace.  Things like mount in the other namespace will be failed
> by check_mount() anyway.
> 
> I think, we need sys calls like sys_cdnamespace() which switches to a
> new namespace. 

Jamie's proposal was to make chroot() swich namespace.

> Effectively the process's current->namespace has to be modified,
> for the process to be effectively work in the new namespace.

current->namespace could be dropped altogether, and
current->current->fs->rootmnt->mnt_namespace could be used instead.

It's a nice logical extension of chroot(), without needing new
syscalls.

Miklos
