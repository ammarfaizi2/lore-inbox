Return-Path: <linux-kernel-owner+w=401wt.eu-S932292AbXALREj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbXALREj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbXALREj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:04:39 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:58647 "EHLO
	mis011-1.exch011.intermedia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932292AbXALREj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:04:39 -0500
Message-ID: <45A7BF9F.5090508@qumranet.com>
Date: Fri, 12 Jan 2007 19:04:31 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kvm & dyntick
References: <45A66106.5030608@qumranet.com> <20070112062006.GA32714@elte.hu> <20070112101931.GA11635@elte.hu>
In-Reply-To: <20070112101931.GA11635@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jan 2007 17:04:37.0767 (UTC) FILETIME=[BDD60970:01C7366B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>   
>>> dyntick-enabled guest:
>>> - reduce the load on the host when the guest is idling
>>>   (currently an idle guest consumes a few percent cpu)
>>>       
>> yeah. KVM under -rt already works with dynticks enabled on both the 
>> host and the guest. (but it's more optimal to use a dedicated 
>> hypercall to set the next guest-interrupt)
>>     
>
> using the dynticks code from the -rt kernel makes the overhead of an 
> idle guest go down by a factor of 10-15:
>
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  2556 mingo     15   0  598m 159m 157m R  1.5  8.0   0:26.20 qemu
>
>   

As usual, great news.

> ( for this to work on my system i have added a 'hyper' clocksource 
>   hypercall API for KVM guests to use - this is needed instead of the 
>   running-to-slowly TSC. )
>   

What's the problem with the TSC?  The only issue I'm aware of is that 
the tsc might go backwards if the vcpu is migrated to another host cpu 
(easily fixed).

A pv clocksource makes sense in any case.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

