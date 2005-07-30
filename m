Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbVG3ANg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVG3ANg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVG3ALc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:11:32 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:42075 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262825AbVG3AIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:08:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Dhz8aMxPNQgBFrMyPxLqMKVaAkpFRvmB8DQaf1ANrFRy0wC/JkAjSW3rssDfVLj7lD064FY+KkX/2wCMQH+LkNMTYPyQb9J20R12CsZtxMDZMeplJqqclVg03b1Gsz8aiFANYBZEW8608XXfzwkk+5dC22bnB1QCnlmK/6pWY3M=  ;
Message-ID: <42EAC504.3000300@yahoo.com.au>
Date: Sat, 30 Jul 2005 10:08:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [sched, patch] better wake-balancing, #3
References: <42E98DEA.9090606@yahoo.com.au> <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <20050729114822.GA25249@elte.hu> <20050729141311.GA4154@elte.hu> <20050729150207.GA6332@elte.hu> <20050729162108.GA10243@elte.hu>
In-Reply-To: <20050729162108.GA10243@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>there's an even simpler way: only do wakeup-balancing if this_cpu is 
>>idle. (tbench results are still OK, and other workloads improved.)
> 
> 
> here's an updated patch. It handles one more detail: on SCHED_SMT we 
> should check the idleness of siblings too. Benchmark numbers still look 
> good.
> 

Maybe. Ken hasn't measured the effect of wake balancing in
2.6.13, which is quite a lot different to that found in 2.6.12.

I don't really like having a hard cutoff like that -wake
balancing can be important for IO workloads, though I haven't
measured for a long time. In IPC workloads, the cache affinity
of local wakeups becomes less apparent when the runqueue gets
lots of tasks on it, however benefits of IO affinity will
generally remain. Especially on NUMA systems.

fork/clone/exec/etc balancing really doesn't do anything to
capture this kind of relationship between tasks and between
tasks and IRQ sources. Without wake balancing we basically have
a completely random scattering of tasks.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
