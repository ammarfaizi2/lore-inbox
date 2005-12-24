Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbVLXBIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbVLXBIc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 20:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161148AbVLXBIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 20:08:32 -0500
Received: from thorn.pobox.com ([208.210.124.75]:31627 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1161147AbVLXBIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 20:08:31 -0500
Date: Fri, 23 Dec 2005 19:08:38 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Suresh Kodati <kodatisu@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] fix smp_processor_id() use in include/asm-generic/percpu.h
Message-ID: <20051224010838.GA9734@localhost.localdomain>
References: <20051222203528.GA4407@dyn9041041086.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222203528.GA4407@dyn9041041086.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh Kodati wrote:
> This patch suppresses the following BUG() seen during bootup of 2.6.15-rc5-mm3 on i386 machines by replacing smp_processor_id with raw_smp_processor_id().
> 
> <snip>
> [   11.258828] Freeing unused kernel memory: 260k freed
> [   11.258864] BUG: using smp_processor_id() in preemptible [00000001] code: swapper/1 
> [   11.258878] caller is mod_page_state_offset+0x12/0x28
> </snip>
> 
> Signed-off-by: Suresh Kodati <kodatisu@in.ibm.com>
> -- 
> 
> include/asm-generic/percpu.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.15-rc5/include/asm-generic/percpu.h.orig	2005-12-21 15:13:27.000000000 -0600
> +++ linux-2.6.15-rc5/include/asm-generic/percpu.h	2005-12-21 15:13:43.000000000 -0600
> @@ -13,7 +13,7 @@ extern unsigned long __per_cpu_offset[NR
>  
>  /* var is in discarded region: offset to particular copy we want */
>  #define per_cpu(var, cpu) (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
> -#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
> +#define __get_cpu_var(var) per_cpu(var, raw_smp_processor_id())

Surely this isn't the right way to address the warning you are seeing?

This change would keep us from catching preempt-unsafe uses of per-cpu
data.


Nathan
