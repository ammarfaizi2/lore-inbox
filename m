Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWBTJs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWBTJs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBTJs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:48:29 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:23564 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932435AbWBTJs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:48:28 -0500
Message-ID: <43F990CA.5080102@sw.ru>
Date: Mon, 20 Feb 2006 12:50:02 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Hansen <haveblue@us.ibm.com>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216143030.GA27585@MAIL.13thfloor.at>
In-Reply-To: <20060216143030.GA27585@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>>- Should any children of pid 1 be allowed to live 
>>  when pid == 1 is killed?

> agan that's a feature which would be nice, especially
> for the lightweight contexts, which do not have an init
> process running inside the guest
whom should child_reaper refer to?

>>- Should a process have some sort of global (on the machine identifier)?
> this is mandatory, as it is required to kill any process
> from the host (admin) context, without entering the pid
> space (which would lead to all kind of security issues)
fine, agreed on this finally, same for OpenVZ.

>>- Should the pids in a pid space be visible from the outside?
> yes, while not strictly required, folks really like to
> view the overall system state. this can be done with the
> help of special tools, but again it should be done
> without entering each guest pid space ...
also fine.

>>- Should the parent of pid 1 be able to wait for it for it's 
>>  children?
> definitely, we (Linux-VServer) added this some time ago
> and it helps to maintain/restart a guest.
but why sys_waitpid? we can make it in many other ways,
can't we? moreover, sys_waitpid() is the most unnatural from my point of 
view, since container is not fully dead when the last process dies, it 
makes some cleanup postponed.
And we had issues in OpenVZ, that very fast VPS stop/start can fail due 
to not freed resources yet.

>>- Is a completely disjoin pid space acceptable to anyone?
> yes, as long as the beforementioned access, management
> and control mechanisms are in place ...
then it is not disjoin? :)

>>- What should the parent of pid == 1 see?
> doesn't really matter, but I see three options there:
>  
>  - the parent space
>  - the child space
>  - both
but should parent see pspace init? only one task from pspace?

>>- Should we be able to monitor a pid space from the outside?
> yes, definitely, but it could happen via some special
> interfaces, i.e. no need to make it compatible
disagree. why we need to introduce copy of existing syscalls?
do you want to fix all the existing apps? ps, top, kill etc.? How about 
third party apps?

>>- Should we be able to have processes enter a pid space?
> definitely, without that, the entire VPS concept will
> not work, folks use the 'admin' backdoors 90% of the
> time ...
agreed. Though I don't like a backdoor name :) It is just a way to get 
access to VPS.

Kirill

