Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWBFUyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWBFUyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWBFUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:54:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51585 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932372AbWBFUyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:54:01 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
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
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id
 namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<43E7B452.2080706@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:51:41 -0700
In-Reply-To: <43E7B452.2080706@watson.ibm.com> (Hubertus Franke's message of
 "Mon, 06 Feb 2006 15:40:50 -0500")
Message-ID: <m1ek2gi52a.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

>> From the kernel community at large I am asking:
>>   Does the code look generally sane?
>
> Yes, but I have one question for you...
> Large parts of the patch are adding the pspace argument
> to find_task_by_pid() and in many cases that argument is
> current->pspace.
> It might bring down the size of the patch if you
> have
>
> find_task_by_pid( pid ) { return find_task_pidspace_by_pid ( current->pspace,
> pid ); }
>
> and then only deal with the exceptional cases using find_task_pidspace_by_pid
> when the pidspace is different..

That is a possibility.  However I want to break some eggs so that the
users are updated appropriately.  It is only by a strenuous act of
will that I don't change the type of pid,tgid,pgrp,session.

The size of the changes is much less important than being clear.
So for I want find_task_by_pid to be an absolute interface.


>>   Does the use of clone to create a new namespace instance look
>>   like the sane approach?
>>
>
> At he surface it looks OK .. how does this work in a multi-threaded
> process which does cloen ( CLONE_NPSPACE ) ?
> We discussed at some point that exec is the right place to do it,
> but what I get is that because this is the container_init task
> we are OK !
> A bit clarification would help here ...

Well the parent doesn't much matter.  But the child must have a fresh
start on all the groups of processes.  As all other groupings known by
a pid are per pspace, so they can't cross that line.

Eric
