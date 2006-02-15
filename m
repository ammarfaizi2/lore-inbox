Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWBOStv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWBOStv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWBOStv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:49:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23701 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751234AbWBOStt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:49:49 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
 process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
	<m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru>
	<m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Feb 2006 11:40:48 -0700
In-Reply-To: <43F31972.3030902@sw.ru> (Kirill Korotaev's message of "Wed, 15
 Feb 2006 15:07:14 +0300")
Message-ID: <m1mzgssbwv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Hello Eric,
>
>>>memory barrier doesn't help. you really need to think about.
>> Except for instances where you need an atomic read/modify/write the
>> only primitives you have are reads, writes and barriers.
>> I have all of the correct reads and writes therefore the only thing
>> that could help are barriers if the logic is otherwise sane.
> the problem is that you do read/write for synchronization of other operations
> (fork/pspace leader die).
> i.e. you try to make a serialization, you see? It doesn't work this way.

I'm missing something, and unfortunately that usually seems to be the case
when discussing problems of this kind.  When we pick up discussing bugs
again, please small simple steps.  We have different backgrounds and 
different base line assumptions, and different points of view, so what
is obvious to you is not obvious to me and vice versa.

> ....
>
>> This exchange seems to have a hostile and not a cooperative tone so
>> I will finish the investigation and bug fixing elsewhere.
> Eric, I think it turned this way because you started pointing to our bugs in
> VPIDs, while having lots of own and not working code.
> I can point you another _really_ disastrous bugs in your IPC and networking
> virtualization. But discussing bugs is not want I want, you see? I want us to
> make some solution suatable for all the parties.

But with an incomplete implementation we can discussion each others approaches.

Basically what is of interest right now are the userspace interface, 
the semantics we are trying to implement, and the maintenance issues
for the users of the code.

> And while you have not working solution it is hard to discuss whether it is good
> or not, whether it is beatutiful or not. It is incomplete and doesn't work. So
> many statements that one solution is better than another are not valid.

:)

I would draw a distinction between a mostly but buggy implementation and
an in incomplete implementation.  When you can run the code and see it doing
things some of the subtle issues are interesting.

> And we are too cycled on PIDs. Why? I think this is the most minor feature which
> can easily live out of mainstream if needed, while virtualization is the main
> goal.

> I also don't understand why you are eager to introduce new sys calls like
> pkill(path_to_process), but is trying to use waitpid() for pspace die
> notifications?

I am not eager to introduce new syscalls.  But I am willing to consider it
when we reach far enough past a certain point.

>  Maybe it is simply better to introduce container specific
> syscalls which should be clean and tidy, instead of messing things up with
> clone()/waitpid() and so on? The more simple code we have, the better it is for
> all of us.

Could be propose it and we can discuss it.  I suspect you already have something
in mid.

> If possible keep posting your patches. I would even ask you to add me to CC
> always. You are doing a really good job and discussion solutions is the only
> possible way to push something to mainstream I suppose.
> I would also be happy to arrange a meeting with the interested parties, since
> talking eye to eye can be much more productive.

Thanks.  As for a meeting given that there are at least 4 different groups
in at least USA and Europe arranging it could be hard.  Currently I am aiming
at the Ottowa Linux Symposium in June.  Hopefully we won't have major 
unresolved issues by then, but it if we do we really need to get together
face to face.


Eric
