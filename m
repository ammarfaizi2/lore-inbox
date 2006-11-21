Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031389AbWKUUUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031389AbWKUUUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031386AbWKUUUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:20:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29449 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031392AbWKUUUq (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:20:46 -0500
Date: Tue, 21 Nov 2006 21:20:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: d binderman <dcb314@hotmail.com>, ak@suse.de
Cc: Linux-Kernel@vger.kernel.org, discuss@x86-64.org, mingo@redhat.com
Subject: [2.6 patch] x86_64 __setup_APIC_LVTT(): remove unused variable
Message-ID: <20061121202046.GL5200@stusta.de>
References: <BAY107-F214E963C5A93489762562E9CEC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY107-F214E963C5A93489762562E9CEC0@phx.gbl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 07:46:46PM +0000, d binderman wrote:
> 
> Hello there,
> 
> I just tried to compile Linux kernel 2.6.18.3 with the Intel C
> C compiler.
> 
> The compiler said
> 
> arch/x86_64/kernel/apic.c(701): remark #593: variable "ver" was set but 
> never used
> 
> The source code is
> 
>    unsigned int lvtt_value, tmp_value, ver;
> 
> I have checked the source code and I agree with the compiler.
> Suggest delete local variable.

Thanks for your report, patch below.

> Regards
> 
> David Binderman

cu
Adrian


<--  snip  -->


This patch removes a variable that whose usage was removed some time ago 
by Andi.

Spotted by the Intel C compiler.

Reported by David Binderman.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/arch/x86_64/kernel/apic.c.old	2006-11-21 21:17:03.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/x86_64/kernel/apic.c	2006-11-21 21:17:16.000000000 +0100
@@ -722,10 +722,9 @@
 
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
-	unsigned int lvtt_value, tmp_value, ver;
+	unsigned int lvtt_value, tmp_value;
 	int cpu = smp_processor_id();
 
-	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 
 	if (cpu_isset(cpu, timer_interrupt_broadcast_ipi_mask))

