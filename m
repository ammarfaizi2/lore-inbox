Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVATA2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVATA2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVATA1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:27:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16120 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262002AbVATAYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:24:47 -0500
Message-ID: <41EEFA4A.4070605@mvista.com>
Date: Wed, 19 Jan 2005 16:24:42 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random> <41EEE648.2010309@mvista.com> <20050119231702.GJ14545@atomide.com>
In-Reply-To: <20050119231702.GJ14545@atomide.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren wrote:
> * George Anzinger <george@mvista.com> [050119 15:00]:
> 
>>I don't think you will ever get good time if you EVER reprogramm the PIT.  
>>That is why the VST patch on sourceforge does NOT touch the PIT, it only 
>>turns off the interrupt by interrupting the interrupt path (not changing 
>>the PIT).  This allows the PIT to be the "gold standard" in time that it is 
>>designed to be.  The wake up interrupt, then needs to come from an 
>>independent timer.  My patch requires a local APIC for this.  Patch is 
>>available at http://sourceforge.net/projects/high-res-timers/
> 
> 
> Well on my test systems I have pretty good accurate time. But I agree,
> PIT is not the best option for interrupt. It should be possible to use
> other interrupt sources as well.
> 
> It should not matter where the timer interrupt comes from, as long as 
> it comes when programmed. Updating time should be separate from timer
> interrupts. Currently we have a problem where time is tied to the
> timer interrupt.

In the HRT code time is most correctly stated as wall_time + 
get_arch_cycles_since(wall_jiffies) (plus conversion or two:)).  This is some 
what removed from the tick interrupt, but is resynced to that interrupt more or 
less each interrupt.

A second issue is trying to get the jiffies update as close to the run of the 
timer list as possible.  Without this we have no hope of high res timers.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

