Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWCOXSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWCOXSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbWCOXSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:18:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16047 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751797AbWCOXSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:18:20 -0500
Date: Thu, 16 Mar 2006 00:17:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 9/24] i386 Vmi smp support
Message-ID: <20060315231755.GB1919@elf.ucw.cz>
References: <200603131805.k2DI5wlO005693@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131805.k2DI5wlO005693@zach-dev.vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 13-03-06 10:05:58, Zachary Amsden wrote:
> SMP bootstrapping support.  Just as in the physical platform model,
> the BSP is responsible for initializing the AP state prior to execution.
> The dependence on lots of processor state information is a design choice
> of our implementation.  Conceivably, this could be a hypercall that
> awakens the same start of day state on APs as on the BSP.
> 
> It is likely the AP startup and the start-of-day model will eventually
> merge into a more common interface.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Signed-off-by: Daniel Arai <arai@vmware.com>

I have to admit booting virtual CPUs is easy compared to booting real
ones :-).

> +#include <asm/io.h>
> +#include <asm/highmem.h>
> +#include <asm/pgtable.h>
> +#include <vmi.h>

How it is possible that vmi.h is included without path?

> +APState ap;

Please don't hide structs like this.
> +static __init int no_ipi_broadcast(char *str)
> +{
> +	get_option(&str, &no_broadcast);
> +	printk ("Using %s mode\n", no_broadcast ? "No IPI Broadcast" :
> +											"IPI Broadcast");

Excesive number of spaces,             I'          d            say .

> @@ -0,0 +1,51 @@
> +/* 
> + * include/asm-i386/mach-default/smpboot_hooks.h
> + *
> + * Portions Copyright 2005 VMware, Inc.
> + */

Whose are the other portions?


> +static inline void smpboot_restore_warm_reset_vector(void)
> +{
> +	/*
> +	 * Install writable page 0 entry to set BIOS data area.
> +	 */
> +	local_flush_tlb();

Code does not seem to match the comment.

> +/*
> + * The following vectors are part of the Linux architecture, there
> + * is no hardware IRQ pin equivalent for them, they are triggered
> + * through the ICC by us (IPIs)
> + */
> +#ifdef CONFIG_X86_SMP
> +BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
> +BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
> +BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
> +#endif

How is it different from CONFIG_SMP? Also please add " " after ",".

> +/*
> + * every pentium local APIC has two 'local interrupts', with a

"Every Pentium"

> + * soft-definable vector attached to both interrupts, one of
> + * which is a timer interrupt, the other one is error counter
> + * overflow. Linux uses the local APIC timer interrupt to get
> + * a much simpler SMP time architecture:
> + */

							Pavel

-- 
184:        br = new BinaryReader( fs );
