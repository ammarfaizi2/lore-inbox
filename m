Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUGUUfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUGUUfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUGUUfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 16:35:18 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:930 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266717AbUGUUfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 16:35:03 -0400
Message-ID: <40FED38D.7050401@colorfullife.com>
Date: Wed, 21 Jul 2004 22:35:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Manfred Spraul <manfred@dbl.q-ag.de>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [RFC, PATCH] 5/5 rcu lock update: Hierarchical rcu_cpu_mask
 bitmap
References: <200405250535.i4P5ZO7I017623@dbl.q-ag.de> <20040716233803.GA1293@us.ibm.com>
In-Reply-To: <20040716233803.GA1293@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:

>I don't understand how the following helps, given that the CPU being
>offlined is supposed to be completely dead by the time we get here.
>Can't see anything that it really hurts other than a bit of delay in
>an extremely infrequent operation, but...
>
>  
>
>>+	spin_unlock_wait(&rcu_state.mutex);
>> 	cpu_quiet(cpu, 1);
>>    
>>

I was concerned about a race of cpu_quiet for the dead cpu (last cpu in 
a group) with a concurrent cpu_quiet for another cpu in another cpu 
group. A stale bit in either rcu_state.outstanding or 
rcu_groups[].outstanding would lock up the rcu subsystem. I've thought 
about it again and I agree with you - there is no race.

I agree with most of your other points - the patch is a proof of 
concept, it definitively needs a big cleanup before is should be 
considered for merging [+ a system that needs it]

--
    Manfred
