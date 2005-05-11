Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVEKVKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVEKVKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVEKVKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:10:12 -0400
Received: from mail.shareable.org ([81.29.64.88]:45776 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262053AbVEKVJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:09:55 -0400
Date: Wed, 11 May 2005 22:09:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: 7eggert@gmx.de, ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050511210935.GA5093@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > > > How about a new clone option "CLONE_NOSUID"?
> > > 
> > > IMO, the clone call ist the wrong place to create namespaces. It should be
> > > deprecated by a mkdir/chdir-like interface.
> > 
> > And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".
> 
> That's the chdir part.
> 
> The mkdir part is clone() or unshare().
> 
> How else do you propose to create new namespaces?

This is not a proposal - I'm not saying it's pretty - but a suggestion
that you can use today.

Use clone(), and then have the child task open "/" and pass that file
descriptor back to the parent process using a unix socket.  The child
can exit and the parent can use the new namespace how it likes.  Short
and sweet, and you can create as many namespaces as you like :)

That's mkdir done.

You can't do a lot with the new namespace, because of the security
restrictions on mount() on a foreign namespace.  That's what I meant
about the "small fixes" - get rid of the current->namespace checks and
it'll be usable.

I don't see the purpose of current->namespace and the associated mount
restrictions at all.  I asked Al Viro what it's for, but haven't seen
a reply :(  IMHO current->namespace should simply be removed, because the
"current namespace" is represented just fine by
current->fs->rootmnt->mnt_namespace.

-- Jamie
