Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTLQCl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 21:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbTLQCl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 21:41:56 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:48083 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262760AbTLQCly
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 21:41:54 -0500
Message-ID: <3FDFC26D.2080206@cyberone.com.au>
Date: Wed, 17 Dec 2003 13:41:49 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: habanero@us.ibm.com
CC: rusty@rustcorp.com.au, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <200312161127.13691.habanero@us.ibm.com> <200312161137.55034.habanero@us.ibm.com>
In-Reply-To: <200312161137.55034.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Theurer wrote:

>>In message <3FD7F1B9.5080100@cyberone.com.au> you write:
>>
>>>http://www.kerneltrap.org/~npiggin/w26/
>>>Against 2.6.0-test11
>>>
>>>This includes the SMT description for P4. Initial results shows
>>>comparable performance to Ingo's shared runqueue's patch on a dual P4
>>>Xeon.
>>>
>>I'm still not convinced.  Sharing runqueues is simple, and in fact
>>exactly what you want for HT: you want to balance *runqueues*, not
>>CPUs.  In fact, it can be done without a CONFIG_SCHED_SMT addition.
>>
>>Your patch is more general, more complex, but doesn't actually seem to
>>buy anything.  It puts a general domain structure inside the
>>scheduler, without putting it anywhere else which wants it (eg. slab
>>cache balancing).  My opinion is either (1) produce a general NUMA
>>topology which can then be used by the scheduler, or (2) do the
>>minimal change in the scheduler which makes HT work well.
>>
>
>FWIW, here is a patch I was working on a while back, to have multilevel NUMA 
>heirarchies (based on arch specific NUMA topology) and more importantly, a 
>runqueue centric point of view for all the load balance routines.  This patch 
>is quite rough, and I have not looked at this patch in a while, but maybe it 
>could help someone?
>
>Also, with runqueue centric approach, shared runqueues should just "work", so 
>adding that to this patch should be fairly clean.  
>
>One more thing, we are missing some stuff in the NUMA topology, which Rusty 
>mentions in another email, like core arrangement, arch states, cache 
>locations/types -all that stuff eventually should make it into some sort of 
>topology, be it NUMA topology stuff or a more generic thing like sysfs.  
>Right now we are a bit limited at what the scheduler looks at, just 
>cpu_to_node type stuff...
>

Hi Andrew,
sched domains can do all this. It is currently set up using just the
simple NUMA toplogy, so its much the same, but the potential is there.

It implements a structure to describe topology in detail which is
used to drive scheduling choices. It could quite easily be extended
to include more memory information and become a general description
for topology.


