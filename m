Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVFUKXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVFUKXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 06:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVFUKXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 06:23:20 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:63757 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261726AbVFUKXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 06:23:07 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20050620235458.5b437274.akpm@osdl.org> (message from Andrew
	Morton on Mon, 20 Jun 2005 23:54:58 -0700)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
Message-Id: <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Jun 2005 12:22:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fuse
> 
>     This is useful, but there are, AFAIK, two issues:
> 
>     - We're still deadlocked over some permission-checking hacks in there

Oh, god.  Let me try to explain this again:

  - This is a security issue with unprivileged mounts

  - Since no other filesystem currently offers secure unpivileged
    mounts in Linux, this is something "new"

  - Since it's something new, there's a big resistance to acceptance.
    I understand this, I only ask people, to please read
    Documentation/filesystems/fuse.txt, before arguing against it

  - IMO it's not a hack, and it's not something that can be solved
    otherwise (no, private namespaces are NOT a solution, they are
    mosty orthogonal to this).

So I welcome constructive discussion.  However bear in mind, that I
definitely don't want to disable unprivileged mounts.  For me that is
_the_ most important feature of FUSE.

>     - It has an NFS server implementation which only works if the
>       to-be-served file happens to be in dcache.

More preciesly it relies on icache.

>       It has been said that a userspace NFS server can be used to
>       get full NFS server functionality with FUSE.  I think the
>       half-assed kernel implementation should be done away with.

I won't shed many tears if you drop fuse-nfs-export.patch.  It would
at least give the userspace solution some boost.

However the patch is pretty small, and despite it's flaws, I know it's
used by a number of people.

Thanks,
Miklos
