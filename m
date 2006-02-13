Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWBMJUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWBMJUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWBMJUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:20:54 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:9785 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751186AbWBMJUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:20:53 -0500
Message-ID: <43F04FD6.5090603@sw.ru>
Date: Mon, 13 Feb 2006 12:22:30 +0300
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
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psluw1jj.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>1.
>>flags are neither atomic nor protected with any lock.
> 
> 
> flags are atomic as they are a machine word.  So they do not
> require a read/modify write so they will either be written
> or not written.  Plus this allows write-sharing of the appropriate
> cache line which is very polite (assuming the line is not shared with
> something else)
Eric I'm familiar with SMP, thanks :)
Why do you write all this if you agreed below that have problems with it?

>>2. due to 1) you code is buggy. in this respect do_exit() is not serialized with
>>copy_process().
> Yes. I may need a memory barrier in there.  I need to think
> about that a little more.
memory barrier doesn't help. you really need to think about.

>>3. due to the same 1) reason
>> > +		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
>>can miss a task being forked. Bang!!!
>
> Well the only bad thing that can happen is that I get a process that
> can run and observe pid == 1 has exited.  So Bang!! is not too
> painful.
And what about references to pspace->child_reaper which was freed already?

[skipped the flood]

Kirill

