Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbUC2AqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUC2AqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 19:46:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:9185 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262535AbUC2AqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 19:46:16 -0500
Date: Sun, 28 Mar 2004 16:46:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dan Hopper <ku4nf@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
Message-Id: <20040328164613.18316ab8.akpm@osdl.org>
In-Reply-To: <20040328235928.GA32243@obiwan.dummynet>
References: <1E741-Sh-5@gated-at.bofh.it>
	<20040328235928.GA32243@obiwan.dummynet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hopper <ku4nf@austin.rr.com> wrote:
>
> On a Thinkpad T40p, 2.6.5-rc2-mm4 does not boot successfully,
>  whereas 2.6.5-rc2 does.  All the typical things (ACPI, CPUFREQ, APIC
>  & IOAPIC, etc.) are built in.  The -mm4 kernel config was derived
>  from the working config for 2.6.5-rc2.  
> 
>  I have to pass the nolapic kernel option to disable the local APIC
>  in order to successfully boot 2.6.x kernels.  It appears that with
>  2.6.5-rc2-mm4, this option is ignored, or perhaps there's a ordering
>  issue with when it is checked.  With -mm4, a message saying that it
>  is enabling the local APIC appears _before_ the "Kernel command
>  line: ... nolapic" line appears.
> 
>  Without the -mm4 patch, the nolapic command line option is parsed
>  before it would have tried to reenable the local APIC.  With -mm4,
>  it is parsed after it tries to renable it.  Boom, and then it locks
>  on "Calibrating delay loop...".
> 
>  Any relevant config options I should try with/without to help narrow
>  it down?

Does this fix it?

---

 25-akpm/arch/i386/kernel/apic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/apic.c~early-param-i386-nolapic-fix arch/i386/kernel/apic.c
--- 25/arch/i386/kernel/apic.c~early-param-i386-nolapic-fix	2004-03-28 16:41:06.685335888 -0800
+++ 25-akpm/arch/i386/kernel/apic.c	2004-03-28 16:42:17.299600888 -0800
@@ -616,7 +616,7 @@ static int __init lapic_disable(char *st
 	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 	return 0;
 }
-__setup("nolapic", lapic_disable);
+__early_param("nolapic", lapic_disable);
 
 static int __init lapic_enable(char *str)
 {

_


