Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUA0Fkb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 00:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUA0Fkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 00:40:31 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:39888 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261909AbUA0Fk2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 00:40:28 -0500
Message-ID: <4015F9A8.6000801@cyberone.com.au>
Date: Tue, 27 Jan 2004 16:39:52 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
References: <20040127024049.7B90B2C13D@lists.samba.org> <356230000.1075178284@[10.10.2.4]>
In-Reply-To: <356230000.1075178284@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>No, actually, it wouldn't.  Take it from someone who has actually
>>looked at the code with an eye to doing this.
>>
>>Replacing static structures by dynamic ones for an architecture which
>>doesn't yet exist is NOT a good idea.
>>
>
>Trying to force a dynamic infrastructure into the static bitmap arrays
>that we have is the bad idea, IMHO. Why on earth would you want offline
>CPUs in the scheduler domains? Just to make your coding easier? Sorry,
>but that just doesn't cut it for me.
> 
>
>>Sure, if they were stupid they'd do it this way.
>>
>>If (when) an architecture has hotpluggable CPUs and NUMA
>>characteristics, they probably will have fixed CPU *slots*, and number
>>CPUs based on what slot they are in.  Since the slots don't move, all
>>your fancy dynamic logic will be wasted.
>>
>>When someone really has dynamic hotplug CPU capability with variable
>>attributes, *they* can code up the dynamic hierarchy.  Because *they*
>>can actually test it!
>>
>
>The cpu numbers are now dynamically allocated tags. I don't see why
>we should sacrifice that just to get cpu hotplug. Sure, it makes your
>coding a little harder, but ....
>
>
>>>Yup ... but you don't have to enumerate all possible positions that way.
>>>See Linus' arguement re dynamic device numbers and ISCSI disks, etc.
>>>Same thing applies.
>>>
>>Crap.  When all the fixed per-cpu arrays have been removed from the
>>kernel, come back and talk about instantiation and location of
>>arbitrary CPUS.
>>
>>You're way overdesigning: have you been sharing food with the AIX guys?
>>
>
>A cheap shot. Please, I'd expect better flaming from you.
>
>Sorry if this makes your coding harder, but it seems clear to me that
>it's the right way to go. I guess the final decision is up to Andrew,
>but I really don't want to see this kind of stuff. You don't start 
>kthreads for every possible cpu, do you?
>
>

Well lets not worry too much about this for now. We could use
static arrays and cpu_possible for now until we get a feel
for what specific architectures want.

To be honest I haven't seen the hotplug CPU code and I don't
know about what architectures want to be doing with it, so
this is my preferred direction just out of ignorance.

An easy next step toward a dynamic scheme would be just to
re-init the entire sched domain topology (the generic init uses
the generic NUMA topology info which will have to be handled
by these architectures anyway). Modulo a small locking problem.

There aren't any fundamental design issues (with sched domains)
that I can see preventing a more dynamic system so we can keep
that in mind.

