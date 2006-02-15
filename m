Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945904AbWBOMG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945904AbWBOMG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWBOMG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:06:59 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:55933 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1945904AbWBOMG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:06:59 -0500
Message-ID: <43F31972.3030902@sw.ru>
Date: Wed, 15 Feb 2006 15:07:14 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>	<m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1wtfytri1.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

>>memory barrier doesn't help. you really need to think about.
> Except for instances where you need an atomic read/modify/write the
> only primitives you have are reads, writes and barriers.
> 
> I have all of the correct reads and writes therefore the only thing
> that could help are barriers if the logic is otherwise sane.
the problem is that you do read/write for synchronization of other 
operations (fork/pspace leader die).
i.e. you try to make a serialization, you see? It doesn't work this way.

....

> This exchange seems to have a hostile and not a cooperative tone so
> I will finish the investigation and bug fixing elsewhere.
Eric, I think it turned this way because you started pointing to our 
bugs in VPIDs, while having lots of own and not working code.
I can point you another _really_ disastrous bugs in your IPC and 
networking virtualization. But discussing bugs is not want I want, you 
see? I want us to make some solution suatable for all the parties.

And while you have not working solution it is hard to discuss whether it 
is good or not, whether it is beatutiful or not. It is incomplete and 
doesn't work. So many statements that one solution is better than 
another are not valid.

And we are too cycled on PIDs. Why? I think this is the most minor 
feature which can easily live out of mainstream if needed, while 
virtualization is the main goal.
I also don't understand why you are eager to introduce new sys calls 
like pkill(path_to_process), but is trying to use waitpid() for pspace 
die notifications? Maybe it is simply better to introduce container 
specific syscalls which should be clean and tidy, instead of messing 
things up with clone()/waitpid() and so on? The more simple code we 
have, the better it is for all of us.

If possible keep posting your patches. I would even ask you to add me to 
CC always. You are doing a really good job and discussion solutions is 
the only possible way to push something to mainstream I suppose.
I would also be happy to arrange a meeting with the interested parties, 
since talking eye to eye can be much more productive.

> I expect that there might be a few more issues like this.  My only
> expectation was that the code was complete enough to discuss semantics
> and kernel mechanisms for creating a namespaces, and the code has
> successfully served that purpose.
To some extent yes.

Kirill

