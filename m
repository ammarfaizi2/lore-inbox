Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWBFVHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWBFVHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBFVHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:07:15 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:61583 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964826AbWBFVHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:07:12 -0500
Message-ID: <43E7BA78.6030501@watson.ibm.com>
Date: Mon, 06 Feb 2006 16:07:04 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
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
Subject: Re: [RFC][PATCH 0/20] Multiple instances of the process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>	<43E7B452.2080706@watson.ibm.com> <m1ek2gi52a.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ek2gi52a.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> 
>
>>find_task_by_pid( pid ) { return find_task_pidspace_by_pid ( current->pspace,
>>pid ); }
>>
>>and then only deal with the exceptional cases using find_task_pidspace_by_pid
>>when the pidspace is different..
> 
> 
> That is a possibility.  However I want to break some eggs so that the
> users are updated appropriately.  It is only by a strenuous act of
> will that I don't change the type of pid,tgid,pgrp,session.
> 
> The size of the changes is much less important than being clear.
> So for I want find_task_by_pid to be an absolute interface.
> 

Fair enough, valid answers .. I checked the patch and it would only take
19/33 instances out .. so not the end of the world.

> 
> 
>>>  Does the use of clone to create a new namespace instance look
>>>  like the sane approach?
>>>
>>
>>At he surface it looks OK .. how does this work in a multi-threaded
>>process which does cloen ( CLONE_NPSPACE ) ?
>>We discussed at some point that exec is the right place to do it,
>>but what I get is that because this is the container_init task
>>we are OK !
>>A bit clarification would help here ...
> 
> 
> Well the parent doesn't much matter.  But the child must have a fresh
> start on all the groups of processes.  As all other groupings known by
> a pid are per pspace, so they can't cross that line.
> 

Now, on which kernel does this compile/work ?
Do you have a "helper" program you can share that starts/exec's an
app under a new container (uhmm, namespace). No point for us to
actually write that..

-- Hubertus


