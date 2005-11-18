Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161269AbVKRVxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbVKRVxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbVKRVxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:53:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64914 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161269AbVKRVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:53:09 -0500
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, ak@suse.de
Subject: Re: [PATCH 8/10] kdump: x86_64 save cpu registers upon crash
References: <20051117131339.GD3981@in.ibm.com>
	<20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com>
	<20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com>
	<20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com>
	<20051117132659.GK3981@in.ibm.com> <20051117132850.GL3981@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 18 Nov 2005 14:52:33 -0700
In-Reply-To: <20051117132850.GL3981@in.ibm.com> (Vivek Goyal's message of
 "Thu, 17 Nov 2005 18:58:50 +0530")
Message-ID: <m1mzk1mxni.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -puN arch/x86_64/kernel/crash.c~x86_64-save-cpu-registers-upon-crash
> arch/x86_64/kernel/crash.c
> ---
> linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/crash.c~x86_64-save-cpu-registers-upon-crash

>  #ifdef CONFIG_SMP
>  static atomic_t waiting_for_crash_ipi;
>  
> @@ -38,6 +106,7 @@ static int crash_nmi_callback(struct pt_
>  		return 1;
>  	local_irq_disable();
>  
> +	crash_save_this_cpu(regs, cpu);
>  	disable_local_APIC();
>  	atomic_dec(&waiting_for_crash_ipi);
>  	/* Assume hlt works */
> @@ -113,4 +182,5 @@ void machine_crash_shutdown(struct pt_re
>  	disable_IO_APIC();
>  #endif
>  
> +	crash_save_self(regs);
>  }

Where did this disable_local_APIC and disable_IO_APIC on x86_64 come
from?  I know we had it on x86 but that was supposed to be a stop gap
until we have the real fix.  Now I know it needs a little more
debugging but the real fix has been written.  Putting it there on
x86_64 makes the code less reliable and it allows things to start
depending on it. 

Please don't saving of the apics to x86_64 propagate this to x86_64.

The rest of the patch looks fine fairly sane, although from a purely
paranoid perspective I can see a few things I would need to look
at more to be certain they are safe.

Eric

