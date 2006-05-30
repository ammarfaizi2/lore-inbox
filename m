Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWE3CID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWE3CID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 22:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWE3CID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 22:08:03 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:13461 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750915AbWE3CIB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 22:08:01 -0400
Message-ID: <447BA8ED.3080904@vilain.net>
Date: Tue, 30 May 2006 14:07:41 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Herbert Poetzl <herbert@13thfloor.at>, Kirill Korotaev <dev@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC 0/5] sched: Add CPU rate caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <1148630661.7589.65.camel@homer> <20060526161148.GA23680@atjola.homenet> <447A2853.2080901@vilain.net> <447A3292.5070606@bigpond.net.au> <447A65EA.9020705@vilain.net> <447A6D7B.9090302@bigpond.net.au> <447B64BF.4050806@vilain.net> <447B7FD6.6020405@bigpond.net.au>
In-Reply-To: <447B7FD6.6020405@bigpond.net.au>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

>>I'd certainly be interested in having a look through the split out patch
>>to see how namespaces and this advanced scheduling system might
>>interoperate.
>>    
>>
>
>OK.  I've tried very hard to make the scheduling code orthogonal to 
>everything else and it essentially separates out the scheduling within a 
>CPU from other issues e.g. load balancing.  This separation is 
>sufficiently good for me to have merged PlugSched with an earlier 
>version of CKRM's CPU management module in a way that made each of 
>PlugSched's schedulers available within CKRM's infrastructure.  (CKRM 
>have radically rewritten their CPU code since then and I haven't 
>bothered to keep up.)
>
>The key point that I'm trying to make is that I would expect PlugSched 
>and namespaces to coexist without any problems.  How it integrates with 
>the "advanced" scheduling system would depend on how that system alters 
>things such as load balancing and/or whether it goes for scheduling 
>outcomes at a higher level than the task.
>  
>

Coexisting is the base line and I don't think they'll 'interfere' with
each other, per se, but we specifically want to make it easy for
userland to set up and configure scheduling policies to apply to groups
of processes.

For instance, the vserver scheduling extension I wrote changes
scheduling policy so that the interactivity bonus is reduced to -5 ..
-5, and -5 .. +15 is given as a bonus or penalty for an entire vserver
that is currently below or above its allocated CPU quotient.  In this
case the scheduling algorithm hasn't changed, just more feedback is
given into the effective priorities of the processes being scheduled. 
ie, there are now two "inputs" (task and vserver) to the existing scheduler.

I guess the big question is - is there a corresponding concept in
PlugSched?  for instance, is there a reference in the task_struct to the
current scheduling domain, or is it more CKRM-style with classification
modules?

If there is a reference in the task_struct to some set of scheduling
counters, maybe we could squint and say that looks like a namespace, and
throw it into the nsproxy.

>I'm assuming that you're happy to wait for the next release?  That will 
>improve the likelihood of descriptions in the patches :-).
>  
>

Let's keep it the technical dialogue going for now, then.

Now, forgive me if I'm preaching to the vicar here, but have you tried
using Stacked Git for the patch development?  I find the way that you
build patch descriptions as you go along, can easily wind the commit
stack to work on individual patches and import other people's work to be
very simple and powerful.

  http://www.procode.org/stgit/

I just mention this because you're not the first person I've talked to
using Quilt to express some difficulty in producing incremental patchset
snapshots.  Not having used Quilt myself I'm unsure whether this is a
deficiency or just "the way it is" once a patch set gets big.

Sam.
