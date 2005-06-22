Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVFVK2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVFVK2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVFVK1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:27:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261872AbVFVKTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:19:46 -0400
Date: Wed, 22 Jun 2005 03:19:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-Id: <20050622031920.456be89d.akpm@osdl.org>
In-Reply-To: <E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu>
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	<20050621233914.69a5c85e.akpm@osdl.org>
	<E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	<20050622004902.796fa977.akpm@osdl.org>
	<E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	<20050622021251.5137179f.akpm@osdl.org>
	<E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
	<20050622024423.66d773f3.akpm@osdl.org>
	<E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > > >  We could.  But that would again be overly restrictive.  The goal is to
>  > > > >  make the use of FUSE filesystems for users as simple as possible.  If
>  > > > >  the user has to manage multiple namespaces, each with it's own
>  > > > >  restrictions, it's becoming a very un-user-friendly environment.
>  > > > 
>  > > > I'd have thought that it would be possible to offer the same user interface
>  > > > as you currently have with private namespaces.  Hide any complexity in the
>  > > > userspace tools?  Where's the problem?
>  > > 
>  > > Sorry, I don't get it.
>  > 
>  > I'm asking you to expand on what the problems would be if we were to
>  > enhance the namespace code as suggested.
> 
>  OK, what I was thinking, is that the user could create a new
>  namespace, that has all the filesystems remounted 'nosuid'.  This
>  wouldn't need any new kernel infrastructure, just a suid-root program
>  (e.g. newns_nosuid), that would do a clone(CLONE_NEWNS), then
>  recursively remount everything 'nosuid' in the new namespace.  Then
>  restore the user's privileges, and exec a shell.
> 
>  In this namespace the user could mount things to his heart's content.
>  He could mount over system directories or even the root directory,
>  without being able to do any harm.
> 
>  This is very nice, but a bit inpractical, since now all the other
>  programs of the user, his desktop environment, login shells etc. Won't
>  be able to see the userspace filesystems mounted in the private
>  namespace.

Yup, that's useless.  That makes the whole CLONE_NEWNS idea unworkable,
yes?

Have we exhausted the alternatives?

(If, as you say, v9fs and samba (did you mean smbfs/cifs?) want
unprivileged mounts, shouldn't the code which you have there be moved out
of fs/fuse/ and into fs/?)
