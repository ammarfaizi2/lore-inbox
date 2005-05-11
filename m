Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVEKV0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVEKV0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVEKV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:26:18 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:24848 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262063AbVEKV0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:26:00 -0400
To: jamie@shareable.org
CC: miklos@szeredi.hu, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <20050511210935.GA5093@mail.shareable.org> (message from Jamie
	Lokier on Wed, 11 May 2005 22:09:35 +0100)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <20050511210935.GA5093@mail.shareable.org>
Message-Id: <E1DVydB-0002RF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 23:20:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is not a proposal - I'm not saying it's pretty - but a suggestion
> that you can use today.
> 
> Use clone(), and then have the child task open "/" and pass that file
> descriptor back to the parent process using a unix socket.  The child
> can exit and the parent can use the new namespace how it likes.  Short
> and sweet, and you can create as many namespaces as you like :)
> 
> That's mkdir done.

Right.

> You can't do a lot with the new namespace, because of the security
> restrictions on mount() on a foreign namespace.  That's what I meant
> about the "small fixes" - get rid of the current->namespace checks and
> it'll be usable.
> 
> I don't see the purpose of current->namespace and the associated mount
> restrictions at all.  I asked Al Viro what it's for, but haven't seen
> a reply :(  IMHO current->namespace should simply be removed, because the
> "current namespace" is represented just fine by
> current->fs->rootmnt->mnt_namespace.

I'll look at what it would take to remove current->namespace.

Miklos
