Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWGRKNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWGRKNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWGRKNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:13:09 -0400
Received: from [216.208.38.107] ([216.208.38.107]:46208 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932128AbWGRKNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:13:08 -0400
Subject: Re: [RFC PATCH 16/33] Add support for Xen to entry.S.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
In-Reply-To: <20060718091952.505770000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091952.505770000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:11:56 +0200
Message-Id: <1153217516.3038.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> +#ifndef CONFIG_XEN
>  	movl %cr0, %eax
>  	testl $0x4, %eax		# EM (math emulation bit)
> -	jne device_not_available_emulate
> -	preempt_stop
> -	call math_state_restore
> -	jmp ret_from_exception
> -device_not_available_emulate:
> +	je device_available_emulate
>  	pushl $0			# temporary storage for ORIG_EIP
>  	CFI_ADJUST_CFA_OFFSET 4
>  	call math_emulate
>  	addl $4, %esp
>  	CFI_ADJUST_CFA_OFFSET -4
> +	jmp ret_from_exception
> +device_available_emulate:
> +#endif


Hi,

can you explain what this chunk is for? It appears to be for the non-xen
case due to the ifndef, yet it seems to visibly change the code for
that... that deserves an explanation for sure ...

Greetings,
   Arjan van de Ven

