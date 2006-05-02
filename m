Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWEBUA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWEBUA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWEBUA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:00:56 -0400
Received: from smtp-out.google.com ([216.239.45.12]:62776 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751277AbWEBUAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:00:55 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=OJcpTVDCcUKr1ZLqUbMnrOrvIHfWBuFG0oMF3hRvl5jdWnt/rGvfQ3pwbAXskBAvI
	0oIITavd997M2aKb8bWlw==
Message-ID: <4457BA59.8030901@google.com>
Date: Tue, 02 May 2006 13:00:25 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com> <200605012034.26763.ak@suse.de>
In-Reply-To: <200605012034.26763.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's really strange - i wonder why the backtracer can't find the original
> stack. Should probably add some printk diagnosis here.
> 
> Can you send the output with this patch?
> 
> Index: linux/arch/x86_64/kernel/traps.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/traps.c
> +++ linux/arch/x86_64/kernel/traps.c
> @@ -238,6 +238,7 @@ void show_trace(unsigned long *stack)
>  			HANDLE_STACK (stack < estack_end);
>  			i += printk(" <EOE>");
>  			stack = (unsigned long *) estack_end[-2];
> +			printk("new stack %lx (%lx %lx %lx %lx %lx)\n", stack, estack_end[0], estack_end[-1], estack_end[-2], estack_end[-3], estack_end[-4]);
>  			continue;
>  		}
>  		if (irqstack_end) {

Thanks for running this Andy:

http://test.kernel.org/abat/30183/debug/console.log
