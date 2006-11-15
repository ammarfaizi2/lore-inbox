Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030755AbWKORvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030755AbWKORvY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030766AbWKORvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:51:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:43728 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030755AbWKORvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:51:23 -0500
Date: Wed, 15 Nov 2006 18:49:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
Message-ID: <20061115174957.GA27827@elte.hu>
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <20061115172003.GA20403@elte.hu> <200611151824.36198.ak@suse.de> <200611151846.31109.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611151846.31109.dada1@cosmosbay.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> Machine boots but freeze when init starts. Any idea ?

probably caused by this:

> +# define GET_CPU_NUM(reg)

>  #define FIXUP_ESPFIX_STACK \
>  	/* since we are on a wrong stack, we cant make it a C code :( */ \
> -	movl %gs:PDA_cpu, %ebx; \
> +	GET_CPU_NUM(%ebx) \
>  	PER_CPU(cpu_gdt_descr, %ebx); \
>  	movl GDS_address(%ebx), %ebx; \

%ebx very definitely wants to have a current CPU number loaded ;) Pick 
it up from the task struct.

	Ingo
