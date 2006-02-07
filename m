Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWBGMWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWBGMWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWBGMWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:22:46 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:57196 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965057AbWBGMWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:22:45 -0500
Message-ID: <43E89181.3070604@sw.ru>
Date: Tue, 07 Feb 2006 15:24:33 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <1139266858.6189.125.camel@localhost.localdomain>
In-Reply-To: <1139266858.6189.125.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>@@ -1132,6 +1133,7 @@ static task_t *copy_process(unsigned lon
>>        p->ioprio = current->ioprio;
>> 
>>        SET_LINKS(p);
>>+       (void)get_container(p->container);
>>        if (unlikely(p->ptrace & PT_PTRACED))
>>                __ptrace_link(p, current->parent); 
> 
> 
> This entire patch looks nice and very straightforward, except for this
> bit. :)  The "(void)" bit isn't usual kernel coding style.  You can
> probably kill it.
it is to avoid warning message the value has no effect.

> BTW, why does get_container() return the container argument?
> get_task_struct(), for instance is just a do{}while(0) loop, so it
> doesn't have a return value.  Is there some magic later on in your patch
> set that utilizes this?
ok, I will remake it without a return value. not a real problem at all.

> One other really minor thing: I usually try to do is keep the !
> CONFIG_FOO functions static inlines, just like the full versions.  The
> advantage is that you get some compile-time type checking, even when
> your CONFIG option is off.
it is not always appropriate :( I try to follow this as well :)

Kirill

