Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVEKTgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVEKTgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVEKTgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:36:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33454 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262030AbVEKTgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:36:18 -0400
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it>
	 <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it>
	 <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
	 <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1115840139.6248.181.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 May 2005 12:35:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 11:49, Miklos Szeredi wrote:
> > > > How about a new clone option "CLONE_NOSUID"?
> > > 
> > > IMO, the clone call ist the wrong place to create namespaces. It should be
> > > deprecated by a mkdir/chdir-like interface.
> > 
> > And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".
> 
> That's the chdir part.

What if proc filesystem is removed from the kernel?

Ability to access some other namespace through the proc filesystem does
not look clean. I think it should be cleanly supported through VFS.

Also cd'ing into a new namespace just allows you to browse through
the other namespace. But it does not effectively change the process's
namespace.  Things like mount in the other namespace will be failed
by check_mount() anyway.

I think, we need sys calls like sys_cdnamespace() which switches to a
new namespace. 

Effectively the process's current->namespace has to be modified,
for the process to be effectively work in the new namespace.


> 
> The mkdir part is clone() or unshare().

 clone/unshare will give you the ability to share/unshare a know
namespace. But to share some arbitrary namespace to which a process
has access rights to.

> How else do you propose to create new namespaces?
> 

RP


> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

