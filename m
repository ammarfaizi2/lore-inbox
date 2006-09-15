Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWIOVVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWIOVVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWIOVVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:21:24 -0400
Received: from [62.205.161.221] ([62.205.161.221]:56279 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S932275AbWIOVVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:21:23 -0400
Message-ID: <450B1958.3020309@openvz.org>
Date: Sat, 16 Sep 2006 01:21:28 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060905)
MIME-Version: 1.0
To: rohitseth@google.com, devel@openvz.org
CC: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       vatsa@in.ibm.com, sekharan@us.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Devel] Re: [ckrm-tech] [PATCH] BC:	resource	beancounters	(v4)
 (added	user memory)
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>	<44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>	<1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>	<1157743424.19884.65.camel@linuxchandra>	<1157751834.1214.112.camel@galaxy.corp.google.com>	<1157999107.6029.7.camel@linuxchandra>	<1158001831.12947.16.camel@galaxy.corp.google.com>	<20060912104410.GA28444@in.ibm.com>	<1158081752.20211.12.camel@galaxy.corp.google.com>	<1158105732.4800.26.camel@linuxchandra>	<1158108203.20211.52.camel@galaxy.corp.google.com>	<1158109991.4800.43.camel@linuxchandra>	<1158111218.20211.69.camel@galaxy.corp.google.com>	<1158186247.18927.11.camel@linuxchandra>  <450A71B1.8020009@sw.ru> <1158339160.12311.35.camel@galaxy.corp.google.com>
In-Reply-To: <1158339160.12311.35.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (kir.sacred.ru [62.205.161.221]); Sat, 16 Sep 2006 01:19:31 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Fri, 2006-09-15 at 13:26 +0400, Kirill Korotaev wrote:
>   
> <...skipped...>
>   
>> for VMware which can reserve required amount of RAM for VM.
>>     
>
> It is much easier to provide guarantees in complete virtual
> environments.  But then you pay the cost in terms of performance.
>   
"Complete virtual environments" vs. "contaners" is not [only] about
performance! In the end, given a proper set of dirty and no-so-dirty
hacks in software and hardware, their performance will be close to native.

Containers vs. other virtualization types is more about utilization,
density, scalability, portability.

Speaking of guarantees, yes, guarantees is easy, you just reserve such
amount of RAM for your VM and that is all. But the fact is usually some
part of that RAM will not be utilized by this particular VM. But since
it is reserved, it can not be utilized by other VMs -- and we end up
just wasting some resources. Containers, given a proper resource
management and configuration, can have some guarantees and still be able
to utilize all the RAM available in the system. This difference can be
metaphorically expressed as a house divided into rooms. Dividing walls
can either be hard or flexible. With flexible walls, room (container)
owner have a guarantee of minimal space in your room, but if a few
guests come for a moment, the walls can move to make more space (up to
the limit). So the flexibility is measured as the delta between a
guarantee and a limit.

This flexibility leads to higher utilization, and this flexibility is
one of the reasons for better density (a few times higher than that of a
paravirtualization solution).

I will not touch scalability and portability topics here to make things
simpler.
> I think we should punt on hard guarantees and fractions for the first
> draft.  Keep the implementation simple.
>   
Do I understand it right that with hard guarantees we loose the
flexibility I have just described? If this is the case, I do not like it.
