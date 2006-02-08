Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbWBHONf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbWBHONf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbWBHONf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:13:35 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:3263 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965163AbWBHONe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:13:34 -0500
Message-ID: <43E9FC85.1000500@watson.ibm.com>
Date: Wed, 08 Feb 2006 09:13:25 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Sam Vilain <sam@vilain.net>, Rik van Riel <riel@redhat.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>	<43E92602.8040403@vilain.net> <43E92AC9.3090308@watson.ibm.com> <m1oe1ia1c9.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1oe1ia1c9.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Hubertus Franke <frankeh@watson.ibm.com> writes:
> 
>>Agreed.. here are some issued we learned from other projects that had
>>similar interception points.
>>
>>Having a central umbrella object (let's stick to the name container)
>>is useful, but being the only object through which every access has to
>>pass may have drawbacks..
>>
>>task->container->pspace->pidmap[offset].page   implies potential
>>cachemisses etc.
>>
>>If overhead becomes too large, then we can stick (cache) the pointer
>>additionally in the task struct. But ofcourse that should be carefully
>>examined on a per subsystem base...
> 
> 
> Ok. After talking with the vserver guys on IRC.  I think grasp the
> importance.  The key feature is to have a place to put limits and the
> like for your entire container.  Look at all of the non-signal stuff
> in struct signal for an example.  The nested namespaces seem to
> be just an implementation detail.
> 
> For OpenVZ having the other namespaces nested may have some
> importance.  I haven't gotten their yet.
> 
> The task->container->pspace->.... thing feels very awkward to me,
> and feels like it increases our chance getting a cache miss.
> 
> So I support the concept of a place to put all of the odd little
> things like rlimits for containers.  But I would like to flatten
> it in the task_struct if we can.
>

My point was to mainly identify the performance culprits and provide
an direct access to those "namespaces" for performance reasons.
So we all agreed on that we need to do that..

Question now (see other's note as well), should we provide
a pointer to each and every namespace in struct task.
Seem rather wasteful to me as certain path/namespaces are not
exercise heavily.

Having one object "struct container" that still embodies all
namespace still seems a reasonable idea.
Otherwise identifying the respective namespace of subsystems will
have to go through container->init->subsys_namespace or similar.
Not necessarily bad either..

-- Hubertus

