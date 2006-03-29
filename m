Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWC2BjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWC2BjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 20:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWC2BjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 20:39:14 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:15269 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1750749AbWC2BjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 20:39:14 -0500
Message-ID: <4429E534.8030206@sw.ru>
Date: Wed, 29 Mar 2006 05:39:00 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <4428FB90.5000601@sw.ru> <4428FEA5.9020808@yahoo.com.au>
In-Reply-To: <4428FEA5.9020808@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

>> First of all, what it does which low level virtualization can't:
>> - it allows to run 100 containers on 1GB RAM
>>   (it is called containers, VE - Virtual Environments,
>>    VPS - Virtual Private Servers).
>> - it has no much overhead (<1-2%), which is unavoidable with hardware
>>   virtualization. For example, Xen has >20% overhead on disk I/O.
> 
> Are any future hardware solutions likely to improve these problems?
Probably you are aware of VT-i/VT-x technologies and planned virtualized 
MMU and I/O MMU from Intel and AMD.
These features should improve the performance somehow, but there is 
still a limit for decreasing the overhead, since at least disk, network, 
video and such devices should be emulated.

>> OS kernel virtualization
>> ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Is this considered secure enough that multiple untrusted VEs are run
> on production systems?
it is secure enough. What makes it secure? In general:
- virtualization, which makes resources private
- resource control, which makes VE to be limited with its usages
In more technical details virtualization projects make user access (and 
capabilities) checks stricter. Moreover, OpenVZ is using "denied by 
default" approach to make sure it is secure and VE users are not allowed 
something else.

Also, about 2-3 month ago we had a security review of OpenVZ project 
made by Solar Designer. So, in general such virtualization approach 
should be not less secure than VM-like one. VM core code is bigger and 
there is enough chances for bugs there.

> What kind of users want this, who can't use alternatives like real
> VMs?
Many companies, just can't share their names. But in general no 
enterprise and hosting companies need to run different OSes on the same 
machine. For them it is quite natural to use N machines for Linux and M 
for Windows. And since VEs are much more lightweight and easier to work 
with, they like it very much.

Just for example, OpenVZ core is running more than 300,000 VEs worldwide.

Thanks,
Kirill
