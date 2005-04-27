Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVD0Ium@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVD0Ium (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 04:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVD0Iul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 04:50:41 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:36515 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261190AbVD0Iub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 04:50:31 -0400
To: pavel@ucw.cz
CC: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050426201411.GA20109@elf.ucw.cz> (message from Pavel Machek on
	Tue, 26 Apr 2005 22:14:11 +0200)
Subject: Re: [PATCH] private mounts
References: <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz>
Message-Id: <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 10:49:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Could we get root-only fuse in, please?
> > 
> > chmod u-s /usr/bin/fusermount
> 
> :-)))). I meant merging patches that are not controversial into
> mainline. AFAICT only controversial pieces are "make it safe for
> non-root users"...

This is the controversial part in all it's glory:

	if (!(fc->flags & FUSE_ALLOW_OTHER) && current->fsuid != fc->user_id)
		return -EACCES;

Leaving it out would gain us what exactly?

I'm not trying to say that this is somehow better than the
pam+shared-subtrees solution discuseed.  That certainly has advantages
over this (e.g. suid programs get permission to fuse mounted
filesystems).

But leaving it out makes no sense.  Zero, zilch, none.

Maybe I'm totally dumb, but I just don't get Christoph's argument.

Thanks,
Miklos
