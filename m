Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWBJIfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWBJIfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 03:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWBJIfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 03:35:13 -0500
Received: from smtpout.mac.com ([17.250.248.44]:5342 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751200AbWBJIfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 03:35:11 -0500
In-Reply-To: <43EC170C.6090807@vilain.net>
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru> <m1hd7condi.fsf@ebiederm.dsl.xmission.com> <1139243874.6189.71.camel@localhost.localdomain> <m13biwnxkc.fsf@ebiederm.dsl.xmission.com> <20060208215412.GD2353@ucw.cz> <m1mzh02y3m.fsf@ebiederm.dsl.xmission.com> <7CCC1159-BF55-4961-BC24-A759F893D43F@mac.com> <43EC170C.6090807@vilain.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EDE8AB0C-98A7-40A7-83BD-C8D48F6C53D3@mac.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>,
       Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: swsusp done by migration (was Re: [RFC][PATCH 1/5] Virtualization/containers: startup)
Date: Fri, 10 Feb 2006 03:29:57 -0500
To: Sam Vilain <sam@vilain.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09, 2006, at 23:31, Sam Vilain wrote:
> Kyle Moffett wrote:
>> <wishful thinking>
>> I can see another extension to this functionality.  With  
>> appropriate  changes it might also be possible to have a container  
>> exist across  multiple computers using some cluster code for  
>> synchronization and  fencing.  The outermost container would be  
>> the system boot container,  and multiple inner containers would  
>> use some sort of network- container-aware cluster filesystem to  
>> spread multiple vservers across  multiple servers, distributing  
>> CPU and network load appropriately.
>> </wishful thinking>
>
> Yeah.  If you fudged/virtualised /dev/random, the system clock, etc  
> you could even have Tandem-style transparent High Availability.
> </more wishful thinking>
>
> Actually there is relatively little difference between a NUMA  
> system and a cluster...

Yeah, a cluster is just a multi-tiered multi-address-space RNUMA  
(*Really* Non-Uniform Memory Architecture) :-D.  With some kind of  
RDMA infiniband card and the right kernel and userspace tools, that  
kind of cluster could be practical.

I _suspect_ (never really considered the issue before) that a  
properly virtualized container could even achieve extremely high  
fault tolerance by allowing systems to "vote" on correct output.  If  
you synchronize /dev/random and network IO across the system  
correctly such that each instance of each userspace process on each  
system sees _exactly_ the same virtual inputs and virtual clock in  
the exact same order, then you could binary-compare the output of 3  
different servers.  If one didn't agree, it could be discarded and  
marked as failing.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


