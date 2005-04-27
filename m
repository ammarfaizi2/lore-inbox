Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVD0Tk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVD0Tk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 15:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVD0Tk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 15:40:28 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30412 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261978AbVD0TkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 15:40:14 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu>
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
	 <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114630811.4180.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 27 Apr 2005 12:40:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 11:09, Miklos Szeredi wrote:
> > eg:
> >  
> > user 1 does a invisible mount on /mnt/mnt1
> > root does a visible mount on /mnt/mnt1
> > 
> > user 1 will no longer be able to access his /mnt/mnt1
> > 
> > in fact even if root mounts something on /mnt, the problem still exists.
> 
> This is not something specific to FUSE.  Root can overmount any of
> your directories after which you won't be able to access it (unless
> some of your processes have a CWD there).

sorry, I think I have not raised by concern clearly.

I am mostly talking about the semantics of 'invisible/private mount' not
FUSE in particular, since the kernel patch brings in new feature
to VFS.

My understanding of private mount is:
1. The contents of the private mount is visible only to the 
    mount owner.
2. The vfsmount of the private mount is only accessible to
   the mount owner, and only the mount owner can mount anything
   on top of it.

But I dont see (2) is being checked for.

I can overmount something on top of a private mount owned by someother
user. I verified that with your patch.

1. do a invisible mount as user 'x' on /mnt
2. do a visible mount as root on /mnt  and it *succeeds* and also masks
    the earlier mount to the user 'x'.

I am not concerned about the masking effect so much. But I am concerned
that the private vfsmount at /mnt is accessible to someother user 
to mount something else on top of it. **The dentry on top of which  the
new vfsmount is done belongs to the private vfsmount**.


Am I making sense? If I do make sense, than all we need is a patch on
top of your patch which disallows non-owner to mount something on top of
a private/invisible vfsmount owned by some owner.

If I am not making sense, I keep quite :)
RP



> 
> Miklos

