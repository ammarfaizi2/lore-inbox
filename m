Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUCCXq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUCCXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:46:59 -0500
Received: from alt.aurema.com ([203.217.18.57]:11174 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261295AbUCCXqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:46:47 -0500
Message-ID: <40466E56.5070801@aurema.com>
Date: Thu, 04 Mar 2004 10:46:30 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, johnl@aurema.com
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.fi4j08o.17nchps@ifi.uio.no.suse.lists.linux.kernel> <fa.ctat17m.8mqa3c@ifi.uio.no.suse.lists.linux.kernel> <yydjishqw10p.fsf@galizur.uio.no.suse.lists.linux.kernel> <40426E1C.8010806@aurema.com.suse.lists.linux.kernel> <p73k7224pdn.fsf@brahms.suse.de> <404554D8.5040800@aurema.com> <20040303101336.GC8008@wotan.suse.de>
In-Reply-To: <20040303101336.GC8008@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, Mar 03, 2004 at 02:45:28PM +1100, Peter Williams wrote:
> 
>>Andi Kleen wrote:
>>
>>>Peter Williams <peterw@aurema.com> writes:
>>>
>>>One comment on the patches: could you remove the zillions of numerical 
>>>Kconfig
>>>options and just make them sysctls? I don't think it makes any sense 
>>>to require a reboot to change any of that. And the user is unlikely
>>>to have much idea yet on what he wants on them while configuring.
>>
>>The default initial values should be fine and the default configuration 
>>allows the scheduling tuning parameters (i.e. half life and time slice 
>>      ) to be changed on a running system via the /proc file system. 
>>These are mainly there so that different settings can be used with 
>>various benchmarks to determine what are the best settings for various 
>>types of loads.  If good default values that work well for a wide 
>>variety of load types can be found as a result of these experiments then 
>>these parameters may be made constants in the code.  If not they 
>>probably should be made settable via system calls rather than via /proc 
>>as you suggest.
> 
> 
> No doubt that there are different settings that make sense 
> for different workloads. But there is no reason one has to recompile
> to set them - it's much nicer to just run a script at boot time to set
> them, instead of recompiling/rebooting. This will also make benchmarking
> much easier, because you can just write a script that sets the
> various parameters, runs workloads, sets other parameters, runs
> workload again etc. Requiring a recompile and reboot makes this
> much harder.

As I said (with the full patch) these values can be set via /proc on a 
running system so there's no need for a recompile and reboot.

> 
> Also I suspect most people who are not heavily into scheduling
> theory will go with the defaults at compile time, so it's important
> that they already work well.
> 
> And consider it from the side of a standard distribution: users 
> don't normally recompile their kernels there, so everything that
> makes sense to be tunable should be settable without recompiling.
> 
> IMHO CONFIG_* should not be used for anything except for kernel binary
> size tuning and possible compiler tuning.

Yes, once this patch has stabilised we will probably remove some (or 
all) of the configuration variables.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

