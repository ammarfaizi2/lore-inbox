Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVD0Srt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVD0Srt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVD0Spf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:45:35 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:51109 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261946AbVD0SnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:43:23 -0400
To: mj@ucw.cz
CC: lmb@suse.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20050427182528.GD4241@ucw.cz> (message from Martin Mares on Wed,
	27 Apr 2005 20:25:28 +0200)
Subject: Re: [PATCH] private mounts
References: <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz> <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu> <20050427175425.GA4241@ucw.cz> <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu> <20050427182528.GD4241@ucw.cz>
Message-Id: <E1DQrUr-0003MI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 20:42:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So yes the check fsuid is not the perfect solution.  However let me
> > remind you that neither is the one with private namespace.
> 
> What I'm arguing about is that the fsuid check is obscure (it breaks
> traditional semantics of file permissions [*],

No, the permissions are not visible to any other user.  So there are
no semantics to break.

> it doesn't allow an user to grant access to his user mount to other
> users,

Yes, but that granting must be explicitly acknowledget by the grantee,
to avoid the problems previously discussed.  It's probably something
possible to do with the private namespaces (sending mounts to other
user's namespaces, etc)

> even if the permissions allow that and so on) and it doesn't
> fully solve the problem anyway.

I think I know how to fully solve the problem.  If the user has
permission to ptrace the process in question then he can already do
whatever he likes with that process, so userspace filesystem operation
can unconditionally be allowed.  Otherwise it's no-no by default.

This thread is proving to be ever more useful :)  Thanks everyone!

> For similar reasons, I don't advocate for private namespaces either.
> 
> The cure more likely lies in simple policy rules like the "all user mounts
> belong to /mnt/usr" one, instead of putting dubious policy to the kernel.

I'm keeping policy out of the kernel by making the check optional.
Then the userspace daemon can enforce such policies as /mnt/usr.

I'll prefer the checking one, since, I'm all alone on my machine,
don't want to share anything, but _do_ want to have mounts under my
home directory.  You prefer the /mnt/usr, since you want to share it
with others.  A combination is also possible: the user choses for each
mount which is preferable.

Agreed?

Miklos
