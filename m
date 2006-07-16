Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWGPUww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWGPUww (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWGPUww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:52:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18398 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750833AbWGPUwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:52:51 -0400
Date: Sun, 16 Jul 2006 22:47:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for 2.6.18-rc2] [2/8] i386/x86-64: Don't randomize stack top when no randomization personality is set
Message-ID: <20060716204712.GA29161@elte.hu>
References: <44ba2f8d.0hsur33TTkK+bbJl%ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ba2f8d.0hsur33TTkK+bbJl%ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

>  unsigned long arch_align_stack(unsigned long sp)
>  {
> -	if (randomize_va_space)
> +	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
>  		sp -= get_random_int() % 8192;
>  	return sp & ~0xf;

i'm not opposing this patch at all, but didnt the performance problems 
go away when the 0xf was changed to 0x7f?

looks good otherwise.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
