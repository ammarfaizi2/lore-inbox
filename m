Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbWF3PWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbWF3PWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWF3PWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 11:22:54 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:35724 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932393AbWF3PWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 11:22:53 -0400
Message-ID: <44A541CB.9080102@fr.ibm.com>
Date: Fri, 30 Jun 2006 17:22:51 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       Sam Vilain <sam@vilain.net>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: strict isolation of net interfaces
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>	<44A1689B.7060809@candelatech.com>	<20060627225213.GB2612@MAIL.13thfloor.at>	<1151449973.24103.51.camel@localhost.localdomain>	<20060627234210.GA1598@ms2.inr.ac.ru>	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>	<20060628133640.GB5088@MAIL.13thfloor.at>	<1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net>	<44A450D1.2030405@fr.ibm.com>	<20060630023947.GA24726@sergelap.austin.ibm.com>	<44A517B4.4010500@fr.ibm.com> <m1veqibu8n.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1veqibu8n.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Daniel Lezcano <dlezcano@fr.ibm.com> writes:
> 
> 
>>Serge E. Hallyn wrote:
>>
>>>Quoting Cedric Le Goater (clg@fr.ibm.com):
>>>
>>>
>>>>we could work on virtualizing the net interfaces in the host, map them to
>>>>eth0 or something in the guest and let the guest handle upper network layers ?
>>>>
>>>>lo0 would just be exposed relying on skbuff tagging to discriminate traffic
>>>>between guests.
>>>
>>>This seems to me the preferable way.  We create a full virtual net
>>>device for each new container, and fully virtualize the device
>>>namespace.
>>
>>I have a few questions about all the network isolation stuff:
> 

It seems these questions are not important.

> 
> So far I have seen two viable possibilities on the table,
> neither of them involve multiple names for a network device.
> 
> layer 3 (filtering the allowed ip addresses at bind time roughly the current vserver).
>   - implementable as a security hook.
>   - Benefit no measurable performance impact.
>   - Downside not many things we can do.

What things ? Can you develop please ? Can you give some examples ?

> 
> layer 2 (What appears to applications a separate instance of the network stack).
>   - Implementable as a namespace.

what about accessing a NFS mounted outside the container ?

>   - Each network namespace would have dedicated network devices.
>   - Benefit extremely flexible.

For what ? For who ? Do you have examples ?

>   - Downside since at least the slow path must examine the packet
>     it has the possibility of slowing down the networking stack.

What is/are the slow path(s) you identified ?

> For me the important characteristics.
> - Allows for application migration, when we take our ip address with us.
>   In particular it allows for importation of addresses assignments
>   mad on other machines.

Ok for the two methods no ?

> - No measurable impact on the existing networking when the code
>   is compiled in.

You contradict ...

> - Clean predictable semantics.

What that means ? Can you explain, please ?

> This whole debate on network devices show up in multiple network namespaces
> is just silly.  

The debate is not on the network device show up. The debate is can we 
have a network isolation ___usable for everybody___ not only for the 
beauty of having namespaces and for a system container like.

I am not against the network device virtualization or against the 
namespaces. I am just asking if the namespace is the solution for all 
the network isolation. Should we nest layer 2 and layer 3 vitualization 
into namespaces or separate them in order to have the flexibility to 
choose isolation/performance.

> The only reason for wanting that appears to be better management.
> We have deeper issues like can we do a reasonable implementation without a
> network device showing up in multiple namespaces.

Again, I am not against having the network device virtualization. It is 
a good idea.

> I think the reason the debate exists at all is that it is a very approachable
> topic, as opposed to the fundamentals here.
> 
> If we can get layer 2 level isolation working without measurable overhead
> with one namespace per device it may be worth revisiting things.  Until
> then it is a side issue at best.

I agree, so where are the answers of the questions I asked in my 
previous email ? You said you did some implementation of network 
isolation with and without namespaces, so you should be able to answer...


   -- Daniel
