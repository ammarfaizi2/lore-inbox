Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWBQLoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWBQLoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 06:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBQLoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 06:44:44 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:8345 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751393AbWBQLon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 06:44:43 -0500
Date: Fri, 17 Feb 2006 12:44:41 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: (pspace,pid) vs true pid virtualization
Message-ID: <20060217114441.GA17940@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Suleiman Souhlal <ssouhlal@FreeBSD.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Cedric Le Goater <clg@fr.ibm.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg <gkurz@fr.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
	Andi Kleen <ak@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jes Sorensen <jes@sgi.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com> <20060216175326.GA11974@sergelap.austin.ibm.com> <m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com> <20060216184407.GC11974@sergelap.austin.ibm.com> <1140115979.21383.11.camel@localhost.localdomain> <m1bqx6p815.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1bqx6p815.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 03:57:26AM -0700, Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > On Thu, 2006-02-16 at 12:44 -0600, Serge E. Hallyn wrote:
> >> Now Dave and I were just talking about actually using the
> >> init process in a pspace to do administration from outside.
> >> For instance, the userspace code, in /sbin/pspaceinit, which
> >> runs as (pspace 2, pid 1), could open a pipe with it's parent
> >> (pspace1, pid 234).  pid 234 can then ask the init process to
> >> do things like list processes, kill a process, and maybe even
> >> recursively talk to the init process in pspace 3.
> >
> > This would require a much smarter init, and that a child be nice,
> > cooperate and pass on what is requested of it if it's nested children
> > are to be killed.  If a child decided to be mean and ignore its parent's
> > requests, the parent can always just kill the child.
> 
> As for that.  When I mad that suggestion to Herbert Poetzl 
> his only concern was that a smart init might be too heavy weight 
> for lightweight vserver.  Generally I like the idea.

well, may I remind that this solution would require _two_
init processes for each guest, which could easily make up
300-400 unnecessary processes in a lightweight server
setup?

> > (Read the last sentence, and in case you're wondering, no I don't have
> > any children in real life)
> 
> Speaking of that.  One of my coworkers mentioned that it is unfortunate
> that our names don't have the double meaning.  So it was suggested we
> call them 
> 
> Speaking of that problematic naming.  One of my coworkers mentioned that
> it is unfortunate that our set of names does not have a double meaning.
> After that the suggestion came up to call them families, instead of guest
> or pidspaces.  Although I guess calling them guests is about as bad :)

well, at least Guests or VEs are terms already used by
existing projects, where pspace sounds somewhat strange.

at the same time I'd like to point out that *spaces is
a good name for the building blocks, but we definitely
have to name the 'construct' different, i.e. a 'guest'
(or VPS or VE or whatever) is _more_ than just a p-space
it's the sum of all *-spaces required to make it look
like a real linux system.

best,
Herbert

> Eric
