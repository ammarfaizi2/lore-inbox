Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbVICOVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbVICOVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 10:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVICOVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 10:21:14 -0400
Received: from rev.193.226.233.176.euroweb.hu ([193.226.233.176]:61964 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751463AbVICOVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 10:21:13 -0400
To: ericvh@gmail.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       fuse-devel@lists.sourceforge.net, torvalds@osdl.org,
       v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
In-reply-to: <a4e6962a050903062941d46389@mail.gmail.com> (message from Eric
	Van Hensbergen on Sat, 3 Sep 2005 08:29:51 -0500)
Subject: Re: FUSE merging?
References: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
	 <20050902153440.309d41a5.akpm@osdl.org>
	 <E1EBQco-0006qr-00@dorka.pomaz.szeredi.hu> <a4e6962a050903062941d46389@mail.gmail.com>
Message-Id: <E1EBYsp-0007Sc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 03 Sep 2005 16:20:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While FUSE doesn't handle it directly, doesn't it have to punt it to
> its network file systems, how to the sshfs and what not handle this
> sort of mapping?

Sshfs handles it by not handling it.  In this case it is neither
possible, nor needed to be able to correctly map the id space.

Yes, it may confuse the user.  It may even confuse the kernel for
sticky directories(*).  But basically it just works, and is very
simple.

> Not really a criticism, just curious.  This doesn't so much relate
> to FUSE, but I've been wrestling with what to do about this chunk of
> (mapping) code -- it seems like it might be a good idea to have some
> common code shared amongst the networked file systems to handle this
> sort of thing.  The NFS idmapd service seems overcomplicated, but
> something like that in the common code could provide the same level
> of service.  What do folks think? Should someone (me?) take a whack
> at a common id mapping service for the kernel (or just extract
> idmapd from NFS) -- or is this something better implemented
> filesystem-to-filesystem?

If more than one filesystem would use it, it would make sense to
abstract it out.  FUSE doesn't need it since it can happily do the
mapping in userspace.

Miklos

(*) I think the correct behavior would be if checking sticky
permissions could also be delegated to the filesystem, like checking
normal permissions can be.
