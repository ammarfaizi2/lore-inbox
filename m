Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUILF1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUILF1P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUILF1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:27:14 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:20145 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268457AbUILFYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:24:23 -0400
Message-ID: <4143D16F.30500@yahoo.com.au>
Date: Sun, 12 Sep 2004 14:32:47 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, anton@samba.org, jun.nakajima@intel.com,
       ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040911220003.0e9061ad.akpm@osdl.org> <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sat, 11 Sep 2004, Andrew Morton wrote:

>>Now, maybe Paul has tied himself into sufficiently tangly locking knots
>>that in some circumstances he needs to spin on the lock and cannot schedule
>>away.  But he can still use a semaphore and spin on down_trylock.
>>
>>Confused by all of this.
> 
> 
> Well currently it just enables preempt and spins like a mad man until the 
> lock is free. The idea is to allow preempt to get some scheduling done 
> during the spin.. But! if you accept this patch today, you get the 
> i386 version which will allow your processor to halt until a write to the 
> lock occurs whilst allowing interrupts to also trigger the preempt 
> scheduling, much easier on the caches.
> 

That's the idea though isn't it? If your locks are significantly more
expensive than a context switch and associated cache trashing, use a
semaphore, hypervisor or no.

I presume the hypervisor switch much incur the same sorts of costs as
a context switch?
