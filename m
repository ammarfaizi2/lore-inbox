Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVEMRe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVEMRe7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVEMRe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:34:59 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:64517 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262456AbVEMReu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:34:50 -0400
To: viro@parcelfarce.linux.theplanet.co.uk
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050513172514.GJ1150@parcelfarce.linux.theplanet.co.uk>
	(message from Al Viro on Fri, 13 May 2005 18:25:14 +0100)
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu> <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk> <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu> <20050513172514.GJ1150@parcelfarce.linux.theplanet.co.uk>
Message-Id: <E1DWe3K-0004RN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 19:34:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
> {
>         struct nameidata old_nd;
>         struct vfsmount *mnt = NULL;
> 	/* no changes of mnt */
> 	err = -EINVAL;
> 	if (check_mnt(nd->mnt) && ... ) {
> 		/* assigns to mnt */
> 	}
> 	if (mnt) {
> 		/* assigns to err */
> 	}
>         up_write(&current->namespace->sem);
>         path_release(&old_nd);
>         return err;
> }
> 
> Care to explain how that would not give -EINVAL?

Yeah, but that check_mnt() checks the _destination_ of the bind not
the source.  The source is only checked for recursive mounts,
presumably because the source namespace is not locked, and so can
change.

Miklos
