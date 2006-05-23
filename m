Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWEWVYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWEWVYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWEWVYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:24:12 -0400
Received: from mail.unixshell.com ([207.210.106.37]:37532 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S932288AbWEWVYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:24:10 -0400
Message-ID: <44737D53.9050006@tektonic.net>
Date: Tue, 23 May 2006 17:23:31 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: Patrick McHardy <kaber@trash.net>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       James Morris <jmorris@namei.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net>	<4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei>	<446D0E6D.2080600@tektonic.net> <446D151D.6030307@tektonic.net>	<4470A6CD.5010501@trash.net> <4471CB54.401@tektonic.net>	<4471CE19.5070802@trash.net> <bf76eefc5234d32440c822acd2879a8a@cl.cam.ac.uk>
In-Reply-To: <bf76eefc5234d32440c822acd2879a8a@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keir Fraser wrote:
> 
> On 22 May 2006, at 15:43, Patrick McHardy wrote:
> 
>> Maybe this helps: there is not too much the Xen code could be doing
>> wrong here. If I read your crash correctly it happend in the FORWARD
>> chain, which could mean that the outgoing device (probably the Xen
>> virtual network driver) has some bugs, but iptables really only cares
>> about the names at this point, which practically can't be bogus.
>> The only other thing I can imagine is that something is wrong with
>> the per-CPU copy of the ruleset, i.e. either smp_processor_id is
>> returning garbage or for_each_possible_cpu misses a CPU during
>> initialization. I have no idea if Xen really does touch this code,
>> but other than that I don't really see what it could break.
> 
> Having looked at disassembly, the fault happens when accessing 
> e->ip.invflags in ip_packet_match() inlined inside ipt_do_table().
> 
>  e = private->entries[smp_processor_id()] + 
> private->hook_entry[NF_IP_FORWARD]
> 
> smp_processor_id() should be 0 (since the oops appears to occur on cpu0) 
> and presumably all the ipt_entry structures are static once set up. 
> Since this crash happens on a common path in ipt_do_table(), and since 
> it happens only after the system has been up a while (I believe?), it 
> rather looks as though something has either corrupted a pointer or 
> unmapped memory from under iptables' feet.
> 

As the concerned user, what does this mean to me?  It will only affect 
SMP systems?  It is a bug in Xen or netfilter?

I'd just like to understand what is going on.

Thanks,
Matt
