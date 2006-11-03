Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752994AbWKCC4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbWKCC4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbWKCC4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:56:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:56251 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752994AbWKCC4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:56:54 -0500
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for paravirtualizing critical operations
Date: Fri, 3 Nov 2006 03:56:53 +0100
User-Agent: KMail/1.9.5
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20061029024504.760769000@sous-sol.org> <20061030231132.GA98768@muc.de> <1162376827.23462.5.camel@localhost.localdomain>
In-Reply-To: <1162376827.23462.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200611030356.54074.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 11:27, Rusty Russell wrote:
> Create a paravirt.h header for all the critical operations which need
> to be replaced with hypervisor calls, and include that instead of
> defining native operations, when CONFIG_PARAVIRT.

Hmm, did this all ever compile in mainline? I had to do a few merges
and in the end i get

/home/lsrc/quilt/linux/kernel/spinlock.c: In function ‘_spin_lock_irqsave’:
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
include2/asm/spinlock.h:59: error: invalid 'asm': operand number missing after %
-letter
{standard input}: Assembler messages:
{standard input}:593: Error: undefined symbol `paravirt_ops' in operation
{standard input}:593: Error: undefined symbol `PARAVIRT_irq_enable' in operation
{standard input}:605: Error: undefined symbol `paravirt_ops' in operation
{standard input}:605: Error: undefined symbol `PARAVIRT_irq_disable' in operatio
n

and lots of new warnings like

/home/lsrc/quilt/linux/arch/i386/kernel/traps.c: In function ‘set_intr_gate’:
/home/lsrc/quilt/linux/arch/i386/kernel/traps.c:1165: warning: implicit declarat
ion of function ‘_set_gate’
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/common.c: In function ‘_cpu_init’:
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/common.c:754: warning: implicit decl
aration of function ‘__set_tss_desc’
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c: In function ‘intel_mach
ine_check’:
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.eax’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.ebx’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.ecx’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.edx’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.esi’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.edi’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.ebp’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.esp’ 
may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.eflag
s’ may be used uninitialized in this function
/home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning: ‘dbg.eip’ 
may be used uninitialized in this function


This is with i386 defconfig + CONFIG_PARAVIRT

-Andi

