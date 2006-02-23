Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWBWNiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWBWNiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWBWNiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:38:01 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:51863 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751232AbWBWNiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:38:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uWyzFu7esREVPiIGHejQjZdRLqVjj5g8T92zDqeyjW/e1XN9dliaAHrJTEGYxy4W/R9mT1CnRA1IpYqtwyoJHUdzKa4xmLMnaE/SkiMDwQNQQnE+x1R35IIfpJXXOfHxIebb2g60bh96wvAALVQVlFkGP//WowUbSGy3x1Zeq7A=  ;
Message-ID: <43FDB910.1080402@yahoo.com.au>
Date: Fri, 24 Feb 2006 00:30:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Emmanuel Pacaud <emmanuel.pacaud@univ-poitiers.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: isolcpus weirdness
References: <1140614487.13155.20.camel@localhost.localdomain>	 <43FDA8DD.2000500@yahoo.com.au> <1140700054.8314.44.camel@localhost.localdomain>
In-Reply-To: <1140700054.8314.44.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Pacaud wrote:
> Le jeudi 23 février 2006 à 23:21 +1100, Nick Piggin a écrit :
> 
>>Emmanuel Pacaud wrote:
>>
>>>Hi,
>>>
>>>When specifying isolcpus kernel parameters, isolated cpu is always the
>>>same, not the one I asked for.
> 
> ..
> 
>>>What's wrong ?
>>>
>>
>>If you have 2 CPUs, and "isolate" one of them, the other is isolated
>>from it. Ie. there is no difference between isolating one or the other,
>>the net result is that they are isolated from each other.
>>
> 
> 
>>From kernel-parameters.txt:
> 
> +   isolcpus=   [KNL,SMP] Isolate CPUs from the general scheduler.
> +         Format: <cpu number>, ..., <cpu number>
> +         This option can be used to specify one or more CPUs
> +         to isolate from the general SMP balancing and scheduling
> +         algorithms. The only way to move a process onto or off
> +         an "isolated" CPU is via the CPU affinity syscalls.
> +
> +         This option is the preferred way to isolate CPUs. The
> +         alternative - manually setting the CPU mask of all tasks
> +         in the system can cause problems and suboptimal load
> +         balancer performance.
> 
> There's a difference between isolated cpus and other cpus: by default,
> there's almost no activity on isolated ones. That's what I want to be
> able to do.
> 

Nothing in kernel-parameters.txt says there will be almost no activity
on them. What you see is what you get, AFAIKS. It would seem strange
to me if isolating one CPU in a 2 CPU machine behaved differently from
isolating the other.

Isolating is really in the context of isolating it from scheduler
balancing, rather than suggesting no tasks will run on there. One way
you could make this do what you want is to bind the init process to
your non-isolated-CPU at boot. This is a policy decision that can be
done in userspace though.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
