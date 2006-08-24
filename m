Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWHXVU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWHXVU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWHXVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:20:27 -0400
Received: from mga06.intel.com ([134.134.136.21]:168 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030473AbWHXVU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:20:27 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,165,1154934000"; 
   d="scan'208"; a="114450696:sNHT39224108"
Message-ID: <44EE1801.3060805@linux.intel.com>
Date: Thu, 24 Aug 2006 23:20:01 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [RFC] maximum latency tracking infrastructure
References: <1156441295.3014.75.camel@laptopd505.fenrus.org> <200608241408.03853.jbarnes@virtuousgeek.org>
In-Reply-To: <200608241408.03853.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Thursday, August 24, 2006 10:41 am, Arjan van de Ven wrote:
>> The reason for adding this infrastructure is that power management in
>> the idle loop needs to make a tradeoff between latency and power
>> savings (deeper power save modes have a longer latency to running code
>> again).
> 
> What if a processor was already in a sleep state when a call to 
> set_acceptable_latency() latency occurs? 

there's nothing sane that can be done in that case; any wake up already will cause the unwanted latency!
A premature wakeup is only making it happen *now*, but now is as inconvenient a time as any...
(in fact it may be a worst case time scenario, say, an audio interrupt...)

> Should there be a callback so 
> they can be woken up?  A callback would also allow ACPI to tell the 
> user "disabling C3 because of device <foo>" or somesuch, which might be 
> nice.

printk'ing would be evil, changes like this will be "semi frequent", like every time you start
or stop playing audio. What ACPI could easily do is indicate in /proc/acpi/processor/*/power
that a state will not be reachable because it violates the latency constraints. That would
be entirely reasonable.

> Also, should subsystems have the ability to set a lower bound on  
> latency?  That would mean set_acceptable_latency() could fail, 
> indicating that the user should buy a better device or a system with 
> better realtime guarantees, which is also valuable info.

While it's valuable info.. there is nothing you can DO about it...
While the kernel can even do a latency of 1us by just not going into C1 even... so the kernel
CAN honor it, even if it thinks it might not be a good idea. Can you give a more concrete example
of a situation where you think your idea would be useful?

Greetings,
    Arjan van de Ven
