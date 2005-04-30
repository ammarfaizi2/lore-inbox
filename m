Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVD3OVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVD3OVQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 10:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVD3OVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 10:21:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12811 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261231AbVD3OUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 10:20:37 -0400
Date: Sat, 30 Apr 2005 16:20:35 +0200
From: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@holomorphy.com>,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.12-rc3-mm1
Message-ID: <20050430142035.GB3571@stusta.de>
References: <20050429231653.32d2f091.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 11:16:53PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc2-mm3:
>...
> +x86-x86_64-deferred-handling-of-writes-to-proc-irq-xx-smp_affinitypatch-added-to-mm-tree.patch
> 
>  x86_64 updates
>...


This patch contains at least two bugs:


The static inline set_irq_info() is not available 
for CONFIG_GENERIC_PENDING_IRQ=n, resulting in the following warning:

<--  snip  -->

...
  CC      arch/i386/kernel/io_apic.o
arch/i386/kernel/io_apic.c: In function `set_ioapic_affinity_irq':
arch/i386/kernel/io_apic.c:251: warning: implicit declaration of function `set_irq_info'
...

<--  snip  -->


The second bug is that although irq.h defines set_irq_info() as a static 
inline, this patch adds an empty function to kernel/irq/manage.c .

The second bug shadows the first bug, but both have to be fixed.


cu
Adrian

BTW: This patch is not in anyway x86_64 specific.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

