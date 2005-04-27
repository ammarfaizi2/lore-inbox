Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVD0UEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVD0UEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVD0UEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:04:08 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:8870 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261988AbVD0UD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:03:58 -0400
To: linuxram@us.ibm.com
CC: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1114630811.4180.20.camel@localhost> (message from Ram on Wed, 27
	Apr 2005 12:40:12 -0700)
Subject: Re: [PATCH] private mounts
References: <20050426094727.GA30379@infradead.org>
	 <20050426131943.GC2226@openzaurus.ucw.cz>
	 <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
	 <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
	 <20050427143126.GB1957@mail.shareable.org>
	 <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
	 <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
	 <20050427155022.GR4431@marowsky-bree.de>
	 <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu>
	 <1114623598.4480.181.camel@localhost>
	 <E1DQqdW-0002SN-00@dorka.pomaz.szeredi.hu>
	 <1114624541.4480.187.camel@localhost>
	 <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu> <1114630811.4180.20.camel@localhost>
Message-Id: <E1DQskk-0004dI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 22:03:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sorry, I think I have not raised by concern clearly.
> 
> I am mostly talking about the semantics of 'invisible/private mount' not
> FUSE in particular, since the kernel patch brings in new feature
> to VFS.
> 
> My understanding of private mount is:
> 1. The contents of the private mount is visible only to the 
>     mount owner.
> 2. The vfsmount of the private mount is only accessible to
>    the mount owner, and only the mount owner can mount anything
>    on top of it.
> 
> But I dont see (2) is being checked for.

It's automatically enforced, since the mount syscall itself will use
the same path lookup mechanism as any other filesystem operation.

> I can overmount something on top of a private mount owned by someother
> user. I verified that with your patch.
> 
> 1. do a invisible mount as user 'x' on /mnt
> 2. do a visible mount as root on /mnt  and it *succeeds* and also masks
>     the earlier mount to the user 'x'.

Yes, because a later mount on a _same_ dentry will mask an earlier
mount.  But that does not mean, that the mount happened on the private
mount's root.

You can check where the mount ended up, by having a shell of 'x' cd to
the private mount.  Then do the overmount.  If the shell can still see
the private mount, then the overmount did not in fact mount over the
private root.

> Am I making sense? If I do make sense, than all we need is a patch on
> top of your patch which disallows non-owner to mount something on top of
> a private/invisible vfsmount owned by some owner.

Yes it makes sense, but I think what you want is already the case.

Thanks,
Miklos
