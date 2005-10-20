Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVJTP43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVJTP43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVJTP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:56:29 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:38373 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932194AbVJTP42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:56:28 -0400
Message-ID: <4357BE1C.9080004@cosmosbay.com>
Date: Thu, 20 Oct 2005 17:56:12 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dimitri Sivanich <sivanich@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc4 latency issue with rcu_process_callbacks()/file_free_rcu()
References: <20051020140733.GA21149@sgi.com>
In-Reply-To: <20051020140733.GA21149@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 20 Oct 2005 17:56:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich a écrit :
> Just bringing up a latency issue I've noticed recently.
> 
> In or around 2.6.14-rc4 some changes were made to have the call to
> kmem_cache_free() from file_free() in the Linux kernel be deferred, running
> as a tasklet via file_free_rcu(), rather than running kmem_cache_free()
> right from file_free() directly.
> 
> I've noticed that rcu_process_callbacks() can take quite a while to run
> now that it routinely calls file_free_rcu() to run kmem_cache_free().
> This can make the cpu unavailable for 100's of usec on 1GHz machines, with
> or without preemption configured on (much of this path is non-preemptible).
> 
> This can result in some unpredictable periods of fairly long cpu latency,
> such as when a thread is waiting to be woken by an interrupt handler on a
> 'now quiet' cpu.  Changing file_free() to call kmem_cache_free() directly
> completely eliminates this unexpected latency.

Well, you cannot change file_free() to call kmem_cache_free() directly, or 
risk corruption/crash.

See Documentation/RCU/UP.txt

Dont you notice latency issue with other RCU protected data, like dentries ?

BTW a change in 2.6.14-rc5 might give different latency results.

Eric
