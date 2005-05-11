Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVEKWmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVEKWmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVEKWmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:42:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39859 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261290AbVEKWmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:42:46 -0400
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
From: Ram <linuxram@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-Reply-To: <20050511212810.GD5093@mail.shareable.org>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it>
	 <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it>
	 <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
	 <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1115851333.6248.225.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 May 2005 15:42:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 14:28, Jamie Lokier wrote:
> Ram wrote:
> > What if proc filesystem is removed from the kernel?
> > 
> > Ability to access some other namespace through the proc filesystem does
> > not look clean. I think it should be cleanly supported through VFS.
> 
> You don't have to use /proc/NNN/root - that's just one convenient way
> to do it.
> 
> Other ways are
> 
>     run_in_namespace mount -t bind / /var/namespaces/$NAME
> 
> and
> 
>     clone + open("/") + pass to parent using unix socket
> 
> which I think both work already.
> 
> > Also cd'ing into a new namespace just allows you to browse through
> > the other namespace. But it does not effectively change the process's
> > namespace.  Things like mount in the other namespace will be failed
> > by check_mount() anyway.
> 
> That's correct.
> 
> > I think, we need sys calls like sys_cdnamespace() which switches to a
> > new namespace.
> 
> Can you give a reason why sys_chdir() shouldn't have that behaviour?

Do you mean to say you want to change the namespace when a process
changes to a directory which belongs to that namespace?

Well it makes it totally confusing. A user would start seeing different
set of mounts suddenly as he changes directories beloning to different
namespaces. I am not sure, if changing namespace implicitly is a good
idea. Not saying its a bad idea, but seems to change my notion of
namespaces completely. 

I think a process should have access to one
namespace at any given point in time, and should have the ability
to explicitly switch to a different namespace of its choice, provided
it has enough access permission to that namespace.

having the ability to access two namespaces simultaneously can allow
cross contamination. Which essentially makes namespaces as a concept
irrelevent.

RP

> 
> > Effectively the process's current->namespace has to be modified,
> > for the process to be effectively work in the new namespace.
> 
> Or just remove current->namespace.  It's entire purpose seems to be to
> prevent namespaces from being first class objects.  The idea of
> "current namespace" is adequately represented by
> current->fs->mnt_root->mnt_namespace IMHO.
> 
> -- Jamie

