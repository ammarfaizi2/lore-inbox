Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWBGSfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWBGSfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWBGSfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:35:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37519 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964835AbWBGSfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:35:08 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 01/20] pid: Intoduce the concept of a wid (wait id)
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<20060207173902.GA6237@ccure.user-mode-linux.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 11:32:06 -0700
In-Reply-To: <20060207173902.GA6237@ccure.user-mode-linux.org> (Jeff Dike's
 message of "Tue, 7 Feb 2006 12:39:02 -0500")
Message-ID: <m1slqvdnq1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:

> First of all, for an RFC, this is very thorough.

Thank you.

> Second, I've been thinking along these lines for UML.  The motivation
> is to get UML out of the system call tracing business as much as
> possible, and to do so by having the host set up such that it can run
> system calls itself and they do the same thing as the UML system call
> would.
>
> For example, for a UML process chrooted into a UML filesystem, the
> file operations on normal files will do the same thing as they would
> in UML, so they could be left to run on the host.
>
> Similarly, something like virtualized processes could be made to do
> the same thing with the process operations.  Trivially, getpid() will
> return the right value if left to run on the host, so UML wouldn't
> need to intercept it.  If there is a process tree inside a container
> that mirrors the UML process tree, then lots of other system calls
> also work, and don't need to be intercepted.
>
> Ideally, I'd like namespaces on the host for all the resources under
> UML control, and for a container to group those namespaces.  However,
> something which stops short of that is still usable - UML just gets
> less benefit from it.

Having all of the namespaces is certainly on my TODO list.

I'm not at all certain if there is a need for a kernel container
concept.

> As far as processes go, ideally I'd like a containerized process to be
> an empty shell which can be completely filled from userspace.  The
> motivation for this is that when you have a UP UML with 100 processes,
> it's wasteful to have 100 virtualized processes on the host.  What I
> would want is one virtualized process which can be completely refilled
> with new attributes on a context switch.
>
> What I want to do is related to process migration, where you want to
> move a process but have it not be able to tell.  I'm describing
> migrating a process from the UML to the host such that the host
> performs as many system calls itself, but those which can't get
> intercepted and executed within the UML.  For migration between
> physical machines, this would be the same as redirecting a system call
> from the new host back to its original home.  You want to do that as
> infrequently as possible, so you want the container to provide as much
> context from the home host as possible.

Currently redirecting a system call from the new host back to it's
original home is not something I had planned on.  Most of the reasons
I want to migrate relate to avoiding the hardware I am migrating from.
Either to reduce it's load or to leave before the hardware dies.

That said the idea of a user space monitor that can handle
the strange virtualization things that don't fit well into the
kernel is appealing.

Note all of the migration I am looking is not process migration but
container migration.  So I want a container per application.

Eric
