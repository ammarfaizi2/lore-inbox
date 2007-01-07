Return-Path: <linux-kernel-owner+w=401wt.eu-S965165AbXAGVHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbXAGVHU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbXAGVHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:07:20 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:38603 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965165AbXAGVHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:07:18 -0500
Date: Sun, 7 Jan 2007 13:06:58 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, md@google.com, mingo@elte.hu, pravin.shelar@calsoftinc.com,
       shai@scalex86.org
Subject: Re: + spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch added to -mm tree
Message-ID: <20070107210658.GA7436@localhost.localdomain>
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net> <1168122953.26086.230.camel@imap.mvista.com> <20070106232641.68511f15.akpm@osdl.org> <1168176285.26086.241.camel@imap.mvista.com> <20070107120503.ceadb6ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107120503.ceadb6ed.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 12:05:03PM -0800, Andrew Morton wrote:
> On Sun, 07 Jan 2007 05:24:45 -0800
> Daniel Walker <dwalker@mvista.com> wrote:
> 
> > Now it fails with CONFIG_PARAVIRT off .
> > 
> > scripts/kconfig/conf -s arch/i386/Kconfig
> >   CHK     include/linux/version.h
> >   CHK     include/linux/compile.h
> >   CHK     include/linux/utsrelease.h
> >   UPD     include/linux/compile.h
> >   CC      arch/i386/kernel/asm-offsets.s
> > In file included from include/linux/spinlock.h:88,
> >                  from include/linux/module.h:10,
> >                  from include/linux/crypto.h:22,
> >                  from arch/i386/kernel/asm-offsets.c:8:
> > include/asm/spinlock.h: In function '__raw_spin_lock_irq':
> > include/asm/spinlock.h:100: error: expected string literal before '__CLI_STI_INPUT_ARGS'
> 
> bah.
> 
> --- a/include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix-fix
> +++ a/include/asm-i386/spinlock.h
> @@ -14,6 +14,7 @@
>  #define STI_STRING	"sti"
>  #define CLI_STI_CLOBBERS
>  #define CLI_STI_INPUT_ARGS
> +#define __CLI_STI_INPUT_ARGS
>  #endif /* CONFIG_PARAVIRT */

Apologies for the broken patch and thanks for the fix,
But, the above is needed to fix the build even with CONFIG_PARAVIRT!!!
Apparently because arch/i386/mm/boot_ioremap.c undefs CONFIG_PARAVIRT.

Question is, now we have 2 versions of spin_locks_irq implementation
with CONFIG_PARAVIRT -- one with regular cli sti and other with virtualized 
CLI/STI -- sounds odd!

Thanks,
Kiran
