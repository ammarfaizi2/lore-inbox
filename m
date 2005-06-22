Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVFVQap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVFVQap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFVQ37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:29:59 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:27154 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261561AbVFVQ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:28:43 -0400
To: ericvh@gmail.com
CC: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <a4e6962a0506220523791a31da@mail.gmail.com> (message from Eric
	Van Hensbergen on Wed, 22 Jun 2005 07:23:06 -0500)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	 <20050621233914.69a5c85e.akpm@osdl.org>
	 <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	 <20050622004902.796fa977.akpm@osdl.org>
	 <E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	 <20050622021251.5137179f.akpm@osdl.org>
	 <E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
	 <20050622024423.66d773f3.akpm@osdl.org>
	 <E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu> <a4e6962a0506220523791a31da@mail.gmail.com>
Message-Id: <E1Dl85I-0007nR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 18:28:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I'm asking you to expand on what the problems would be if we were to
> > > enhance the namespace code as suggested.
> > 
> > OK, what I was thinking, is that the user could create a new
> > namespace, that has all the filesystems remounted 'nosuid'.  This
> > wouldn't need any new kernel infrastructure, just a suid-root program
> > (e.g. newns_nosuid), that would do a clone(CLONE_NEWNS), then
> > recursively remount everything 'nosuid' in the new namespace.  Then
> > restore the user's privileges, and exec a shell.
> >
> 
> I'm confused why everything has to be remounted nosuid.  I understand
> enforcing synthetics to be mounted nosuid, but not the rest of the
> file systems.

It's related to the problem of a suid program accessing synthetic
filesystem, and filesystem doing something bad to suid program (make
it hang, supply bogus data ...).  This can be solved by "squashing"
suid for the whole namespace (basically the Plan 9 solution).
Unfortunately this is not really practical in Linux/Unix.

> I thought all the problems revolving around the private namespace
> solution where the FUSE team's desire to have per-user namespace
> and/or per-session namespace versus per-process namespace.

That's a different aspect of this thing.  Private namespaces cannot do
anything about the above problem.

Miklos
