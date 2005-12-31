Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVLaWEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVLaWEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLaWEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:04:55 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:19132 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932333AbVLaWEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:04:54 -0500
Message-ID: <43B70084.2060009@bigpond.net.au>
Date: Sun, 01 Jan 2006 09:04:52 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ornati <ornati@fastwebnet.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
References: <20051227190918.65c2abac@localhost>	<20051227224846.6edcff88@localhost>	<200512281027.00252.kernel@kolivas.org>	<20051230145221.301faa40@localhost>	<43B5E78C.9000509@bigpond.net.au>	<20051231113446.3ad19dbc@localhost>	<20051231115213.4a2e01ba@localhost>	<43B68B2A.7080208@bigpond.net.au> <20051231173135.67cee547@localhost>
In-Reply-To: <20051231173135.67cee547@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 31 Dec 2005 22:04:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Sun, 01 Jan 2006 00:44:10 +1100
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>OK.  This probably means that the parameters that control the mechanism 
>>need tweaking.
>>
>>There should be a file /sys/cpusched/attrs/unacceptable_ia_latency which 
>>contains the latency (in nanoseconds) that the scheduler considers 
>>unacceptable for interactive programs.  Try changing that value and see 
>>if things improve?  Making it smaller should help but if you make it too 
>>small all the interactive tasks will end up with the same priority and 
>>this could cause them to get in each other's way.
> 
> 
> I've tried different values and sometimes I've got a good feeling BUT
> the behaviour is too strange to say something.
> 
> Sometimes I get what I want (dd priority ~17 and CPU eaters prio
> 25), sometimes I get a total disaster (dd priority 17 and CPU eaters
> prio 15/16) and sometimes I get something like DD prio 22 and CPU
> eaters 23/24.
> 
> All this is not well related to "unacceptable_ia_latency" values.

OK. Thanks for trying it.

The feedback will be helpful in trying to improve the mechanisms.

> 
> What I think is that the priority calculation in ingosched and other
> schedulers is in general too weak, while in other schedulers is rock
> solid (read: nicksched).
> 
> Maybe is just that the smarter a scheduler want to be, the more fragile
> it will be.
> 

Probably but this one is fairly simple.

I think the remaining problems with interactive responsiveness is that 
bonuses increase too slowly when a latency problem is detected.  I.e. a 
task just gets one extra bonus point when an unacceptable latency is 
detected regardless of how big the latency is.  This means that it may 
take several cycles for the bonus to be big enough to solve the problem. 
  I'm going to try making the bonus increment proportional to the size 
of the latency w.r.t. the limit.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
