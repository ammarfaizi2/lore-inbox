Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUGPBsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUGPBsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 21:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUGPBsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 21:48:22 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:32609 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266287AbUGPBsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 21:48:06 -0400
Message-ID: <40F733D2.2000309@yahoo.com.au>
Date: Fri, 16 Jul 2004 11:48:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
References: <200407151829.20069.jbarnes@engr.sgi.com> <46970000.1089936880@flay> <200407152038.32755.jbarnes@engr.sgi.com>
In-Reply-To: <200407152038.32755.jbarnes@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Thursday, July 15, 2004 8:14 pm, Martin J. Bligh wrote:
> 
>>>Nick, we've had this patch floating around for awhile now and I'm
>>>wondering what you think.  It's needed to boot systems with lots (e.g.
>>>256) nodes, but could probably be done another way.  Do you think we
>>>should create a scheduler domain for every 64 nodes or something?
>>
>>I think that'd make a lot of sense ...
> 
> 
> Yeah, though a smaller number of nodes would probably make more sense :)
> 

Thirded :)

> 
>>>Any other NUMA folks have thoughts about these values?
>>
>>Yeah, change them in arch specific code, not in the global stuff ;-)
> 
> 
> What, you mean we're the only ones with 256 nodes?
> 

Yeah, these numbers actually used to be a lot higher, but someone
at Intel (I forget who it was right now) found them to be too high
on even a 32 way SMT system. They could probably be raised a *little*
bit in the generic code.

> 
>>But seeing as they're dependant (for you) on machine size, as well as
>>arch type, you probably need to do something cleverer in
>>arch_init_sched_domain
> 
> 
> Ok, I'll check that out.
> 
> 
>>But the big bugaboo is arch-specific vs general ... we need to break
>>opteron vs i386 vs ia64 out from each other ... they all need different
>>coefficients.
>>
>>If you were going to be really fancy, we could do it in common code off
>>the topology stuff ... but for now, I think it's easier to just set 'em
>>per arch ...
> 
> 
> We may have enough information to do that already... I'll look.
> 

The plan is to allow arch overridable SD_CPU/NODE_INIT macros for
those architectures that just look like a regular SMT+SMP+NUMA, and
have the generic code set them up.
