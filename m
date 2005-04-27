Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVD0Ryt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVD0Ryt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVD0RxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:53:10 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:31141 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261867AbVD0Rwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:52:37 -0400
To: lmb@suse.de
CC: mj@ucw.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20050427174641.GZ4431@marowsky-bree.de> (message from Lars
	Marowsky-Bree on Wed, 27 Apr 2005 19:46:41 +0200)
Subject: Re: [PATCH] private mounts
References: <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu> <20050427174641.GZ4431@marowsky-bree.de>
Message-Id: <E1DQqi1-0002T3-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 19:52:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > the ability to change the layout underneath, you might trigger bugs in
> > > root programs: Are they really capable of seeing the same filename
> > > twice, or can you throw them into a deep recursion by simulating
> > > infinitely deep directories/circular hardlinks...?
> > Circular or otherwise hardlinked directories are not allowed since it
> > would not only confuse applications but the VFS as well.
> 
> Right, that you can catch. But can you prevent a user fs module from
> creating an infinitely deep directory structure out of thin air? Do you
> limit the maximum path length / depth?

No. 

> (Sending this privately and not to LKML, because I first wanted to check
> the facts ;-)

OK, CC restored.  You shouldn't be afraid to send to LKML.  It's the
ultimate spam list ;)

> > > Certainly a useful tool for hardening applications, but I can see the
> > > point of not wanting to let unwary applications run into a namespace
> > > controlled by a user. Of course, this is sort-of similar to "find
> > > -xdev", but I'm not sure whether it is not indeed new behaviour.
> > 
> > A trivial DoS against any process entering the userspace filesystem is
> > just not to answer the filesystem request.
> > 
> > So it's not just information leak, but also a fine way to _control_
> > certain behavior of applications.
> 
> Yes. I first thought the check was superfluous, because hey, why
> shouldn't root be able to access everything... But then it struck me
> that that might actually be a good idea for all those reasons. root's
> tools don't expect that the namespace they are traversing is
> _completely_ controlled by a user.

Exactly.

Thanks,
Miklos
