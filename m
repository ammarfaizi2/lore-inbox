Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVD0Vij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVD0Vij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVD0Vii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:38:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:23436 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262035AbVD0ViR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:38:17 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1DQskk-0004dI-00@dorka.pomaz.szeredi.hu>
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
	 <1114630811.4180.20.camel@localhost>
	 <E1DQskk-0004dI-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114637883.4180.55.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 27 Apr 2005 14:38:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 13:03, Miklos Szeredi wrote:
> > sorry, I think I have not raised by concern clearly.
> > 
> > I am mostly talking about the semantics of 'invisible/private mount' not
> > FUSE in particular, since the kernel patch brings in new feature
> > to VFS.
> > 
> > My understanding of private mount is:
> > 1. The contents of the private mount is visible only to the 
> >     mount owner.
> > 2. The vfsmount of the private mount is only accessible to
> >    the mount owner, and only the mount owner can mount anything
> >    on top of it.
> > 
> > But I dont see (2) is being checked for.
> 
> It's automatically enforced, since the mount syscall itself will use
> the same path lookup mechanism as any other filesystem operation.
> 
> > I can overmount something on top of a private mount owned by someother
> > user. I verified that with your patch.
> > 
> > 1. do a invisible mount as user 'x' on /mnt
> > 2. do a visible mount as root on /mnt  and it *succeeds* and also masks
> >     the earlier mount to the user 'x'.
> 
> Yes, because a later mount on a _same_ dentry will mask an earlier
> mount.  But that does not mean, that the mount happened on the private
> mount's root.
> 
> You can check where the mount ended up, by having a shell of 'x' cd to
> the private mount.  Then do the overmount.  If the shell can still see
> the private mount, then the overmount did not in fact mount over the
> private root.

ok. Generally overmounts are done on the root dentry of the topmost
vfsmount.  But in this case, your patch mounts it on the same dentry
as that of the private mount.

Essentially I was always under the assertion that 'a dentry can hold
only one vfsmount'.  But invisible mount seem to invalidate that
assertion.  Don't see any bad effects of that.  Probably some VFS
experts may. (or probably my assertion is wrong to begin with)

RP


