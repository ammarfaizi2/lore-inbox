Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945936AbWBONbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945936AbWBONbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbWBONbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:31:35 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:1683 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1945937AbWBONbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:31:34 -0500
Date: Wed, 15 Feb 2006 14:31:32 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, "Serge E. Hallyn" <serue@us.ibm.com>,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process id namespace
Message-ID: <20060215133131.GD28677@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	"Serge E. Hallyn" <serue@us.ibm.com>,
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
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com> <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F31972.3030902@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:07:14PM +0300, Kirill Korotaev wrote:
> Hello Eric,
> 
> >>memory barrier doesn't help. you really need to think about.
> >Except for instances where you need an atomic read/modify/write the
> >only primitives you have are reads, writes and barriers.
> >
> >I have all of the correct reads and writes therefore the only thing
> >that could help are barriers if the logic is otherwise sane.
> the problem is that you do read/write for synchronization of other 
> operations (fork/pspace leader die).
> i.e. you try to make a serialization, you see? It doesn't work this way.
> 
> ....
> 
> >This exchange seems to have a hostile and not a cooperative tone so
> >I will finish the investigation and bug fixing elsewhere.
> Eric, I think it turned this way because you started pointing to our 
> bugs in VPIDs, while having lots of own and not working code.
> I can point you another _really_ disastrous bugs in your IPC and 
> networking virtualization. But discussing bugs is not want I want, you 
> see? I want us to make some solution suatable for all the parties.

that's good!

> And while you have not working solution it is hard to discuss whether
> it is good or not, whether it is beatutiful or not. It is incomplete
> and doesn't work. So many statements that one solution is better than
> another are not valid.

well, it's kind of moot to demand a final solution just
to discuss the implementation ...
usually software design happens before the implementation
and the implementation details can be fed back into the
cycle later ...

> And we are too cycled on PIDs. Why? I think this is the most minor 
> feature which can easily live out of mainstream if needed, while 
> virtualization is the main goal.

although I could be totally ignorant regarding the PID
stuff, it seems to me that it pretty well reflects the
requirements for virtualization in general, while being
simple enough to check/test several solutions ...

why? simple: it reflects the way 'containers' work in
general, it has all the issues with administration and
setup, similar to 'guests' (it requires some management
and access from outside, while providing security and
isolation inside), containers could be easily built on
top of that or as an addition to the pid space structures
at the same time it's easy to test, and issues will show
up quite early, so that they can be discussed and, if
necessary, solved without rewriting an entire framework.

> I also don't understand why you are eager to introduce new sys calls 
> like pkill(path_to_process), but is trying to use waitpid() for pspace 
> die notifications? Maybe it is simply better to introduce container 
> specific syscalls which should be clean and tidy, instead of messing 
> things up with clone()/waitpid() and so on? The more simple code we 
> have, the better it is for all of us.

now that you mention it, maybe we should have a few
rounds how those 'generic' container syscalls would 
look like?

best,
Herbert

> If possible keep posting your patches. I would even ask you to add me to 
> CC always. You are doing a really good job and discussion solutions is 
> the only possible way to push something to mainstream I suppose.
> I would also be happy to arrange a meeting with the interested parties, 
> since talking eye to eye can be much more productive.
> 
> >I expect that there might be a few more issues like this.  My only
> >expectation was that the code was complete enough to discuss semantics
> >and kernel mechanisms for creating a namespaces, and the code has
> >successfully served that purpose.
> To some extent yes.
> 
> Kirill
