Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUCCDps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUCCDps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:45:48 -0500
Received: from alt.aurema.com ([203.217.18.57]:17040 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261678AbUCCDpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:45:44 -0500
Message-ID: <404554D8.5040800@aurema.com>
Date: Wed, 03 Mar 2004 14:45:28 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, johnl@aurema.com
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <fa.fi4j08o.17nchps@ifi.uio.no.suse.lists.linux.kernel>	<fa.ctat17m.8mqa3c@ifi.uio.no.suse.lists.linux.kernel>	<yydjishqw10p.fsf@galizur.uio.no.suse.lists.linux.kernel>	<40426E1C.8010806@aurema.com.suse.lists.linux.kernel> <p73k7224pdn.fsf@brahms.suse.de>
In-Reply-To: <p73k7224pdn.fsf@brahms.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Peter Williams <peterw@aurema.com> writes:
> 
> One comment on the patches: could you remove the zillions of numerical Kconfig
> options and just make them sysctls? I don't think it makes any sense 
> to require a reboot to change any of that. And the user is unlikely
> to have much idea yet on what he wants on them while configuring.

The default initial values should be fine and the default configuration 
allows the scheduling tuning parameters (i.e. half life and time slice 
       ) to be changed on a running system via the /proc file system. 
These are mainly there so that different settings can be used with 
various benchmarks to determine what are the best settings for various 
types of loads.  If good default values that work well for a wide 
variety of load types can be found as a result of these experiments then 
these parameters may be made constants in the code.  If not they 
probably should be made settable via system calls rather than via /proc 
as you suggest.

In reality, batch type jobs tend to get better throughput with a longer 
half life but a shorter half life gives better interactive response.  So 
servers and work stations should probably have different settings.

> 
> I really like the reduced scheduler complexity part of your patch BTW.
> IMHO the 2.6 scheduler's complexity has gotten out of hand and it's great
> that someone is going into the other direction with a simple basic design.

Thanks, we felt much the same.  With a heuristic approach there always 
seems to be one more case that needs to be handled specially popping up.

> 
> For more wide spread testing it would be useful if you could do 
> a more minimal less intrusive patch with less configuration 
> (e.g. only allow tuning via nice, not via other means). This would
> be mainly to test your patch on more workloads without any hand tuning,
> which is the most important use case.

The "base" patch does this except that it also allows the setting of 
soft caps via /proc. But, as I said above, the main reason for the 
tuning parameters being exposed (in the full patch) at this time is to 
encourage testing with different values (of half life and time slice) 
and making them settable via /proc makes this possible without having to 
reboot the system.

Except for (possibly) renicing the X server there should be no need to 
fiddle with settings for individual tasks.

Peter
PS We are looking at some simple modifications to further improve 
interactive response (hopefully) without adding to complexity.
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

