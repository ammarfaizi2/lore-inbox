Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031148AbWKPJWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031148AbWKPJWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 04:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031153AbWKPJWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 04:22:10 -0500
Received: from mail.suse.de ([195.135.220.2]:17039 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031148AbWKPJWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 04:22:08 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Date: Thu, 16 Nov 2006 10:22:03 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061116084855.GA8848@elte.hu> <200611161001.01407.ak@suse.de> <20061116011733.e119eae5.akpm@osdl.org>
In-Reply-To: <20061116011733.e119eae5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161022.04022.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 10:17, Andrew Morton wrote:
> On Thu, 16 Nov 2006 10:01:01 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > +#ifdef CONFIG_HOTPLUG_CPU
> >  	hotcpu_notifier(cpu_vsyscall_notifier, 0);
> > +#endif
> 
> this part isn't needed - the definition handles that.

Thanks. Updated patch appended.

-Andi

Fix vsyscall.c compilation on UP

Broken by earlier patch by me.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -274,6 +274,7 @@ static void __cpuinit cpu_vsyscall_init(
 	vsyscall_set_cpu(raw_smp_processor_id());
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int __cpuinit
 cpu_vsyscall_notifier(struct notifier_block *n, unsigned long action, void *arg)
 {
@@ -282,6 +283,7 @@ cpu_vsyscall_notifier(struct notifier_bl
 		smp_call_function_single(cpu, cpu_vsyscall_init, NULL, 0, 1);
 	return NOTIFY_DONE;
 }
+#endif
 
 static void __init map_vsyscall(void)
 {
