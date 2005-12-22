Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVLVWAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVLVWAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbVLVWAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:00:20 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:35180 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030340AbVLVWAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:00:19 -0500
Message-ID: <43AB21F1.8090600@cosmosbay.com>
Date: Thu, 22 Dec 2005 23:00:17 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
References: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu> <43A90225.4060007@cosmosbay.com> <20051221074346.GA2398@elte.hu> <43A90C07.4000003@cosmosbay.com> <20051222211132.GA21742@elte.hu> <43AB1E55.6040703@mvista.com>
In-Reply-To: <43AB1E55.6040703@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger a écrit :
> 
> 
>> that's just the profiling interrupt hitting them. You should not 
>> analyze irq-safe code with a non-NMI profiling interrupt.
>>
>> CLI/STI is extremely fast. (In fact in the -rt tree i'm using them 
>> within mutexes instead of preempt_enable()/preempt_disable(), because 
>> they are faster and generate less register side-effect.)
>>
> Hm... I rather thought that the cli would cause a rather large hit on 
> the pipeline and certainly on OOE.  Is your observation based on any 
> particular instruction stream?  Sti, on the otherhand should be fast...

Just to be exact, the 'cli' is coded as 3 instruction :

pushfq
popq (%rsp)
cli

and the 'sti' is coded as 2 instructions :
pushq (%rsp)
popfq

And 'popfq' seems to be expensive, at least on Opteron machines and if 
oprofile is not completely wrong...

Eric
