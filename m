Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbWBGMNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbWBGMNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWBGMNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:13:08 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:64154 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965049AbWBGMNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:13:07 -0500
Message-ID: <43E88F27.7050602@sw.ru>
Date: Tue, 07 Feb 2006 15:14:31 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       riel@redhat.com, kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org> <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The important properties of the proposed container implementation:
>>- each container has unique ID in the system
> What namespace does this ID live in?
global namespace. can be virtualized later.
can be optional.
But the idea is simple. Eventually you will need some management tools 
anyway. And they should be able to refer to containers.

>>- each process in the kernel can belong to one container only
> Reasonable.
> 
> 
>>- effective container pointer (econtainer()) is used on the task to avoid
>>insertion of additional argument "container" to all functions where it is
>>required.
> Why is that desirable?
It was discussed with Linus and the reason is provided in this text 
actually.
There are 2 ways:
- to add additional argument "container" to all the functions where it 
is required.
Drawbacks: a) lot's of changes, b) compilation without virtualization is 
not the same. c) increased stakc usage
- to add effective container pointer on the task. i.e. context which 
kernel should be in when works with virtualized resources.
Drawbacks: a) there are some places where you need to change effective 
container context explicitly such as TCP/IP.

>>- kernel compilation with disabled virtualization should result in old good
>>linux kernel
> 
> A reasonable goal.
> 
> Why do we need a container structure to hold pointers to other pointers?
can't catch what you mean :) is it prohibited somehow? :))))

> May I please be added to the CC list.
> We are never going to form a consensus if all of the people doing implementations don't
> talk.
To make a consensus people need to make mutual concessions... Otherwise 
these talks are useless.

Kirill

