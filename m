Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWAEOdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWAEOdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAEOde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:33:34 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:23209 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751333AbWAEOdb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:33:31 -0500
Message-ID: <43BD2E37.203@cosmosbay.com>
Date: Thu, 05 Jan 2006 15:33:27 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sizeof(percpu_data) and removes dependance against
 NR_CPUS
References: <1135251766.3557.13.camel@pmac.infradead.org>	<20060105021929.498f45ef.akpm@osdl.org>	<43BD2406.2040007@cosmosbay.com> <20060105060050.37ec91d3.akpm@osdl.org>
In-Reply-To: <20060105060050.37ec91d3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 05 Jan 2006 15:33:27 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>> Current sizeof(percpu_data) is NR_CPUS*sizeof(void *)
>>
>>  This trivial patch makes percpu_data real size depends on 
>>  highest_possible_processor_id() instead of NR_CPUS
>>
>>  percpu_data allocations are not performance critical, we can spend few CPU 
>>  cycles and save some ram.
> 
> hm, highest_possible_processor_id() isn't very efficient.  And it's quite
> dopey that it's a macro.  We should turn it into a real function which
> caches its return result and goes BUG if it's called before
> cpu_possible_map is initialised.

I agree, I will see if I can do that without poking in every arch :(

More over, my patch has an error on pdsize computation, it should be :

size_t pdsize = (highest_possible_processor_id() + 1) * sizeof(void *);

Eric
