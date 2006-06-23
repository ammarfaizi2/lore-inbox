Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWFWORe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWFWORe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWFWORe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:17:34 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:55610 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750736AbWFWORd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:17:33 -0400
Date: Fri, 23 Jun 2006 08:17:24 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCHSET] Announce: High-res timers,
 tickless/dyntick and dynamic HZ -V4
In-reply-to: <20060623082609.GB1040@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@timesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Message-id: <449BF7F4.9080408@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.lKfxxA+pCJb5tSZbL1XnnrPzaeQ@ifi.uio.no>
 <449B60A9.2000809@shaw.ca> <1151051238.25491.223.camel@localhost.localdomain>
 <20060623082609.GB1040@elte.hu>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Thomas Gleixner <tglx@timesys.com> wrote:
> 
>>> Disabling NO_HZ and high resolution timers due to timer broadcasting
>>>
>>> Not sure exactly what this is indicating or what's triggered this, but 
>>> I'm assuming the patch isn't doing much on this machine?
>> The system is configured for SMP, but this is an UP machine and the 
>> APIC is disabled in the BIOS. Linux uses then the PIT and an IPI 
>> mechanism to broadcast timer events. We need to do the event 
>> reprogramming per CPU, so we switch off in that situation.
> 
> hm, we should update the message to be less cryptic. Something like:
> 
>   'Disabling NO_HZ and high resolution timers due to no APIC'
> 
> and in this particular case we should also finetune the condition a bit 
> and make it conditional on the number of CPUs. I.e. if someone boots an 
> SMP kernel on a UP box we should still allow the PIT. (there wont be any 
> broadcasting done) [the only exception would be if CONFIG_HOTPLUG_CPU is 
> specified - in that case we cannot be sure whether a new CPU will be 
> plugged in or not]

Yes, I would say that this case should be handled better, considering 
this configuration is the default one for Fedora kernels, for one..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

