Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269484AbUJFV6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269484AbUJFV6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269475AbUJFV6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:58:08 -0400
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:64184 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S269492AbUJFVzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:55:37 -0400
Message-ID: <416469D5.9050202@bigpond.net.au>
Date: Thu, 07 Oct 2004 07:55:33 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Derr <Simon.Derr@bull.net>
CC: Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com, mbligh@aracnet.com,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com> <20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]> <1097014749.4065.48.camel@arrakis> <20041005194702.0644070b.pj@sgi.com> <Pine.LNX.4.61.0410061114470.19964@openx3.frec.bull.fr>
In-Reply-To: <Pine.LNX.4.61.0410061114470.19964@openx3.frec.bull.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Derr wrote:
> On Tue, 5 Oct 2004, Paul Jackson wrote:
> 
> 
>>Matthew wrote:
>>
>>>By adding locking and reference counting, and simplifying the way in which
>>>sched_domains are created, linked, unlinked and eventually destroyed we
>>>can use sched_domains as the implementation of cpusets.
>>
>>I'd be inclined to turn this sideways from what you say.
>>
>>Rather, add another couple of properties to cpusets:
>>
>> 1) An isolated flag, that guarantees whatever isolation properties
>>    we agree that schedulers, allocators and resource allocators
>>    require between domains, and
>>
>> 2) For those cpusets which are so isolated, the option to add
>>    links of some form, between that cpuset, and distinct scheduler,
>>    allocator and/or resource domains.
>>
> 
> 
> Just to make sure we speak the same language:
> 
> That would lead to three kinds of cpusets:
> 
> 1-'isolated' cpusets, with maybe a distinct scheduler, allocator and/or 
> resource domains.
> 
> 2-'exclusive' cpusets (maybe with a better name?), that just don't overlap 
> with other cpusets who have the same parent.
> 
> 3-'non-exclusive, non isolated' cpusets, with no restriction of any kind.
> 
> I suppose it would still be possible to create cpusets of type 2 or 3 
> inside a type-1 cpuset. They would be managed by the scheduler of the 
> parent 'isolated' cpuset.
> 
> I was thinking that the top cpuset is a particular case of type-1, but 
> actually no.
> 
> 'isolated' cpusets should probably be at the same level as the top cpuset 
> (who should lose this name, then).
> 
> How should 'isolated' cpusets be created ? Should the top_cpuset be shrunk 
> to free some CPUs so we have room to create a new 'isolated' cpuset ?
> 
> Or should 'isolated' cpusets stay inside the top cpuset, that whould have 
> to schedule its processes outside the 'isolated' cpusets ? Should it then 
> be forbidden to cover the whole system with 'isolated' cpusets ?
> 
> That's a lot of question marks...
> 

I think that this is becoming overly complicated.  I think that you need 
(at most) two types of cpuset: 1. the top level non overlapping type and 
2. possibly overlapping sets within the top level ones. I think that the 
term cpuset should be reserved for the top level ones and some other 
term be coined for the others.  The type 2 ones are really just the 
equivalent of the current affinity mask but with the added constraint 
that it be a (non empty) proper subset of the containing cpuset.

The three types that you've described are then just examples of 
configurations that could be achieved using this model.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
