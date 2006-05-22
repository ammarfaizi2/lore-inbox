Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWEVOOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWEVOOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWEVOOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:14:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:37019 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750838AbWEVOOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:14:02 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH 3/6] reliable stack trace support (x86-64 IRQ stack adjustment)
Date: Mon, 22 May 2006 16:10:16 +0200
User-Agent: KMail/1.9.1
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <4471D60F.76E4.0078.0@novell.com>
In-Reply-To: <4471D60F.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221610.16909.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  1:	incl	%gs:pda_irqcount	# RED-PEN should check preempt count
> -	movq %gs:pda_irqstackptr,%rax
> -	cmoveq %rax,%rsp /*todo This needs CFI annotation! */
> +	cmoveq %gs:pda_irqstackptr,%rsp
> +#if !defined(CONFIG_DEBUG_INFO) && !defined(CONFIG_UNWIND_INFO)
>  	pushq %rdi			# save old stack	
> -#ifndef CONFIG_DEBUG_INFO

The tests for DEBUG_INFO are obsolete here. It should only test for 
UNWIND_INFO. I'll fix that up.

-Andi

