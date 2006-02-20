Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWBTJgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWBTJgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWBTJgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:36:23 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:17033 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964812AbWBTJgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:36:23 -0500
Message-ID: <43F98DD5.40107@sw.ru>
Date: Mon, 20 Feb 2006 12:37:25 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com>
In-Reply-To: <20060216142928.GA22358@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>- Should the pids in a pid space be visible from the outside?
> 
> Again, the openvz guys say yes.
> 
> I think it should be acceptable if a pidspace is visible in all it's
> ancestor pidspaces.  I.e. if I create pspace2 and pspace3 from pid 234
> in pspace1, then pspace2 doesn't need to be able to address pspace3
> and vice versa.
> 
> Kirill, is that acceptable?
yes, acceptable.
once, again, believe me, this is very required feature for 
troubleshouting and management (as Eric likes to take about maintanance :) )

>>- Should the parent of pid 1 be able to wait for it for it's 
>>  children?
> Yes.
why? any reason?

>>- Should a process not in the default pid space be able to create 
>>  another pid space?
> 
> 
> Yes.
> 
> This is to support using pidspaces for vservers, and creating
> migrateable sub-pidspaces in each vserver.
this doesn't help to create migratable sub-pidspaces.
for example, will you share IPCs in your pid parent and child pspaces?
if yes, then it won't be migratable;
if no, then you need to create fully isolated spaces to the end and 
again you end up with a question, why nested pspaces are required at all?

>>- Should we be able to monitor a pid space from the outside?
> To some extent, yes.
SURE! :)

>>- Should we be able to have processes enter a pid space?
> IMO that is crucial.
required.

>>- Do we need to be able to be able to ptrace/kill individual processes
>>  in a pid space, from the outside, and why?
> I think this is completely unnecessary so long as a process can enter a
> pidspace.
No. This is required.
Because, container can be limited with some resource limitations. You 
may be unable to enter inside. For example, if container forked() many 
threads up to its limit, you won't be able to enter it.

>>- After migration what identifiers should the tasks have?
> So this is irrelevant, as the openvz approach can just virtualize the
> old pid, while (pspace, pid) will be able to create a new container and
> use the old pid values, which are then guaranteed to not be in use.
agreed. irrelevant.

>>If we can answer these kinds of questions we can likely focus in
>>on what the implementation should look like.  So far I have not
>>seen a question that could not be implemented with a (pspace, pid)/pid
>>or a vpid/pid implementation.
> But you have, haven't you?  Namely, how can openvz provide it's
> customers with a global view of all processes without putting 5 years of
> work into a new sysadmin interface?
it is not only about OpenVz. This is about manageability.
This is the feature our users like _very_ much, when administrator can 
fix the problems. Have you ever tried to fix broken VM in VMWare/Xen?
On the other hand, VPID approach can fully isolate containers if needed 
for security reasons.

Kirill

