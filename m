Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVEXSZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVEXSZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEXSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:24:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63184 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261951AbVEXSXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:23:40 -0400
Message-ID: <4293709E.6040702@redhat.com>
Date: Tue, 24 May 2005 14:21:18 -0400
From: Ananth N Mavinakayanahalli <amavin@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Prasanna S Panchamukhi <prasanna@in.ibm.com>, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 1/5] Kprobes: Temporary disarming of reentrant probe
References: <20050524101532.GA27215@in.ibm.com> <20050524181525.GF86233@muc.de>
In-Reply-To: <20050524181525.GF86233@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

Hi Andi,

>>@@ -55,6 +61,9 @@ struct kprobe {
>> 	/* list of kprobes for multi-handler support */
>> 	struct list_head list;
>> 
>>+	/*count the number of times this probe was temporarily disarmed */
>>+	unsigned long nmissed;
> 
> 
> You declare a variable.
> 
> 
>>+
>> 	/* location of the probe point */
>> 	kprobe_opcode_t *addr;
>> 
>>diff -puN kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-generic kernel/kprobes.c
>>--- linux-2.6.12-rc4-mm2/kernel/kprobes.c~kprobes-temporary-disarming-on-reentrancy-generic	2005-05-24 15:28:08.000000000 +0530
>>+++ linux-2.6.12-rc4-mm2-prasanna/kernel/kprobes.c	2005-05-24 15:28:08.000000000 +0530
>>@@ -334,6 +334,7 @@ int register_kprobe(struct kprobe *p)
>> 	}
>> 	spin_lock_irqsave(&kprobe_lock, flags);
>> 	old_p = get_kprobe(p->addr);
>>+	p->nmissed = 0;
> 
> 
> And then you set it to 0.
> 
> And nothing more. Surely this patch does not do anything. Looks like
> some code is missing.

No Andi - nmissed is incremented in the arch/xxx/kernel/kprobes.c
everytime the probe is "reentered". This is part of the subsequent
patches in the series.

Ananth

