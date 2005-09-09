Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbVIIIBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbVIIIBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVIIIBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:01:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:11908 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751440AbVIIIBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:01:05 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 2.6.13] x86_64: Add notify_die() to another spot in do_page_fault()
Date: Fri, 9 Sep 2005 10:01:00 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050908163840.GR3966@smtp.west.cox.net>
In-Reply-To: <20050908163840.GR3966@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091001.01325.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:38, Tom Rini wrote:
> This adds a call to notify_die() in the "no context" portion of
> do_page_fault() as someone on the chain might care and want to do a fixup.
>
> ---
>
>  linux-2.6.13-trini/arch/x86_64/mm/fault.c |    4 ++++
>  1 files changed, 4 insertions(+)
>
> diff -puN arch/x86_64/mm/fault.c~x86_64-no_context_hook
> arch/x86_64/mm/fault.c ---
> linux-2.6.13/arch/x86_64/mm/fault.c~x86_64-no_context_hook	2005-09-01
> 12:00:43.000000000 -0700 +++
> linux-2.6.13-trini/arch/x86_64/mm/fault.c	2005-09-01 12:00:43.000000000
> -0700 @@ -514,6 +514,10 @@ no_context:
>  	if (is_errata93(regs, address))
>  		return;
>
> +	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
> +				SIGSEGV) == NOTIFY_STOP)
> +		return;
> +

But how would the chain users distingush this from the DIE_PAGE_FAULT
reported at the beginning of the page fault handler? I don't see how
it can work. If anything you would need a DIE_NO_CONTEXT or somesuch, no? 

-Andi
