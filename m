Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWBTMrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWBTMrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWBTMrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:47:48 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:29667 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1030187AbWBTMrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:47:47 -0500
Date: Mon, 20 Feb 2006 13:47:46 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
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
Message-ID: <20060220124745.GC17478@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Hansen <haveblue@us.ibm.com>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <43F98DD5.40107@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F98DD5.40107@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 12:37:25PM +0300, Kirill Korotaev wrote:
> >>- Should the pids in a pid space be visible from the outside?
> >
> >Again, the openvz guys say yes.
> >
> >I think it should be acceptable if a pidspace is visible in all it's
> >ancestor pidspaces.  I.e. if I create pspace2 and pspace3 from pid 234
> >in pspace1, then pspace2 doesn't need to be able to address pspace3
> >and vice versa.
> >
> >Kirill, is that acceptable?
> yes, acceptable.
> once, again, believe me, this is very required feature for
> troubleshouting and management (as Eric likes to take about
> maintanance :) )

IMHO there are certain things which _are_ required
and others which are nice to have but not strictly
required, just think "ptrace across pid spaces"

> >>- Should the parent of pid 1 be able to wait for it for it's 
> >> children?
> >Yes.
> why? any reason?
> 
> >>- Should a process not in the default pid space be able to create 
> >> another pid space?
> >
> >Yes.
> >
> >This is to support using pidspaces for vservers, and creating
> >migrateable sub-pidspaces in each vserver.
> this doesn't help to create migratable sub-pidspaces.
> for example, will you share IPCs in your pid parent and child pspaces?
> if yes, then it won't be migratable;

well, not the child pspace, but the parent, no?

> if no, then you need to create fully isolated spaces to the end and
> again you end up with a question, why nested pspaces are required at
> all?

because we are not trying to implement a VPS only
solution for mainline, we are trying to provide
building blocks for many different uses, including
the VPS approach ...

> >>- Should we be able to monitor a pid space from the outside?
> >To some extent, yes.
> SURE! :)
> 
> >>- Should we be able to have processes enter a pid space?
> >IMO that is crucial.
> required.
> 
> >>- Do we need to be able to be able to ptrace/kill individual processes
> >> in a pid space, from the outside, and why?
> >I think this is completely unnecessary so long as a process can enter a
> >pidspace.
> No. This is required.

ptrace across pid spaces is not required, it is
nice to have and probably adds a bunch of security
issues ...

> Because, container can be limited with some resource limitations. You 
> may be unable to enter inside. For example, if container forked() many 
> threads up to its limit, you won't be able to enter it.
> 
> >>- After migration what identifiers should the tasks have?
> >So this is irrelevant, as the openvz approach can just virtualize the
> >old pid, while (pspace, pid) will be able to create a new container and
> >use the old pid values, which are then guaranteed to not be in use.
> agreed. irrelevant.
> 
> >>If we can answer these kinds of questions we can likely focus in
> >>on what the implementation should look like.  So far I have not
> >>seen a question that could not be implemented with a (pspace, pid)/pid
> >>or a vpid/pid implementation.
> >But you have, haven't you?  Namely, how can openvz provide it's
> >customers with a global view of all processes without putting 5 years of
> >work into a new sysadmin interface?
> it is not only about OpenVz. This is about manageability.

management tools should have a way to get the
required information, they do not necessarily need
to utilize existing interfaces ...

> This is the feature our users like _very_ much, when administrator can 
> fix the problems. Have you ever tried to fix broken VM in VMWare/Xen?
> On the other hand, VPID approach can fully isolate containers if needed 
> for security reasons.

best,
Herbert

> Kirill
