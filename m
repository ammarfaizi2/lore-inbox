Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUHWXRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUHWXRo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268267AbUHWXRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:17:20 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:6615 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268233AbUHWXMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:12:37 -0400
Date: Mon, 23 Aug 2004 19:16:53 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] find_isa_irq_pin should not be __init
In-Reply-To: <Pine.LNX.4.58.0408231842220.13924@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0408231915440.13924@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408231842220.13924@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Zwane Mwaikambo wrote:

> find_isa_irq_pin should not be __init now, i'm surprised this one didn't
> bite you Eric...
>
> Restarting system.
> Unable to handle kernel paging request at virtual address c07bdfb0
>  printing eip:
> c07bdfb0
> *pde = 00843027
> Oops: 0000 [#1]
> PREEMPT SMP DEBUG_PAGEALLOC
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c07bdfb0>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.8.1-mm4)
> EIP is at find_isa_irq_pin+0x0/0x70
> eax: 00000001   ebx: 00000000   ecx: 00000000   edx: 00000017
> esi: 01234567   edi: e842e000   ebp: e842fe88   esp: e842fe60
> ds: 007b   es: 007b   ss: 0068
> Process reboot (pid: 6024, threadinfo=e842e000 task=d18eea30)
> Stack: c011bc27 00000000 00000003 00000001 00000000 e842fe88 c0118286 00000000
>        01234567 e842e000 e842fe94 c01182b9 00000000 e842ffbc c01376c1 00000000
>        c0650a79 c080aac4 00000001 00000000 00000000 e842fee4 c0155212 c1506020
> Call Trace:
>  [<c01089a5>] show_stack+0x75/0x90
>  [<c0108b05>] show_registers+0x125/0x190
>  [<c0108d09>] die+0x109/0x1f0
>  [<c011d8a0>] do_page_fault+0x230/0x5b2
>  [<c010856d>] error_code+0x2d/0x40
>  [<c01182b9>] machine_restart+0x9/0x70
>  [<c01376c1>] sys_reboot+0x151/0x3b0
>  [<c01073e9>] sysenter_past_esp+0x52/0x79
> Code:  Bad EIP value.

Forgot x86/64

 arch/i386/kernel/io_apic.c   |    2 +-
 arch/x86_64/kernel/io_apic.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.8.1-mm4/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm4/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.8.1-mm4/arch/i386/kernel/io_apic.c	23 Aug 2004 08:23:22 -0000	1.1.1.1
+++ linux-2.6.8.1-mm4/arch/i386/kernel/io_apic.c	23 Aug 2004 22:46:09 -0000
@@ -747,7 +747,7 @@ static int __init find_irq_entry(int api
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int __init find_isa_irq_pin(int irq, int type)
+static int find_isa_irq_pin(int irq, int type)
 {
 	int i;

Index: linux-2.6.8.1-mm4/arch/x86_64/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm4/arch/x86_64/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.8.1-mm4/arch/x86_64/kernel/io_apic.c	23 Aug 2004 08:23:39 -0000	1.1.1.1
+++ linux-2.6.8.1-mm4/arch/x86_64/kernel/io_apic.c	23 Aug 2004 23:15:16 -0000
@@ -329,7 +329,7 @@ static int __init find_irq_entry(int api
 /*
  * Find the pin to which IRQ[irq] (ISA) is connected
  */
-static int __init find_isa_irq_pin(int irq, int type)
+static int find_isa_irq_pin(int irq, int type)
 {
 	int i;

