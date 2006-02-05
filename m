Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWBEPHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWBEPHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWBEPHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:07:20 -0500
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:60609 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S1750830AbWBEPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:07:19 -0500
Message-ID: <43E61448.7010704@sw.ru>
Date: Sun, 05 Feb 2006 18:05:44 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>	 <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>	 <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain>
In-Reply-To: <1138991641.6189.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just did a global s/vps/container/ and it looks pretty reasonable, at
> least from my point of view.
> 
> Couple of minor naming nitpick questions, though.  Is vps/container_info
> really what we want to call it?  It seems to me to be the basis for a
> real "container", without the _info part.
Can be ommited.

> "tsk->owner_container"  That makes it sound like a pointer to the "task
> owner's container".  How about "owning_container"?  The "container
> owning this task".  Or, maybe just "container"?
This is why I don't like "container" name.

Please, also note, in OpenVZ we have 2 pointers on task_struct:
One is owner of a task (owner_env), 2nd is a current context (exec_env). 
exec_env pointer is used to avoid adding of additional argument to all 
the functions where current context is required.

Linus, does such approach makes sense to you or you prefer us to add 
additional args to functions where container pointer is needed? This 
looks undersiable for embedded guys and increases stack usage/code size 
when virtualization is off, which doesn't look good for me.

> Any particular reason for the "u32 id" in the vps_info struct as opposed
> to one of the more generic types?  Do we want to abstract this one in
> the same way we do pid_t?
VPS ID is passed to/from user space APIs and when you have a cluster 
with different archs and VPSs it is better to have something in common 
for managing this.

> The "host" in "host_container_info" doesn't mean much to me.  Though, I
> guess it has some context in the UML space.  Would "init_container_info"
> or "root_container_info" be more descriptive?
init_container?
(Again, this is why container doesn't sound for me :) )

> Lastly, is this a place for krefs?  I don't see a real need for a
> destructor yet, but the idea is fresh in my mind.
I don't see much need for krefs, do you?
In OpenVZ we have 2-level refcounting (mentioned recently by Linus as in 
mm). Process counter is used to decide when container should 
collapse/cleanuped and real refcounter is used to free the structures 
which can be referenced from somewhere else.

Also there is some probability that use of krefs will result in sysfs :)))

> How does the attached patch look?
I will resend all 5 patches tomorrow. And maybe more.

Kirill
