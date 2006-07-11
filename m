Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWGKMaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWGKMaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWGKMaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:30:20 -0400
Received: from koto.vergenet.net ([210.128.90.7]:41936 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751247AbWGKMaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:30:19 -0400
From: Horms <horms@verge.net.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] i386 kexec:  Allow the kexec on panic support to compile on voyager.
In-Reply-To: <m1y7v1krwi.fsf@ebiederm.dsl.xmission.com>
X-Newsgroups: gmane.linux.kernel,gmane.comp.boot-loaders.fastboot.general
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.17-1-686 (i686))
Message-Id: <20060711123017.5F15A3403D@koto.vergenet.net>
Date: Tue, 11 Jul 2006 21:30:17 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 16:37:49 -0600, Eric W. Biederman wrote:
> 
> This patch removes the foolish assumption that SMP implied local
> apics.  That assumption is not-true on the Voyager subarch.  This
> makes that dependency explicit, and allows the code to build.

Doesn't only a small portion of the code in question rely
on CONFIG_X86_LOCAL_APIC? Is just a workaround until proper
voager support materialises?

> What gets disabled is just an optimization to get better crash
> dumps so the support should work if there is a kernel that will
> initialization on the voyager subarch under those harsh conditions.

By that do you mean, a crash kernel that is able to boot even
though the non-crashing CPUs have not been shutdown?

> Hopefully we can figure out how to initialize apics in init_IRQ
> and remove the need to disable io_apics and this dependency.

That does sound nice. Do you have any ideas on how that could be 
made to happen?

> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> arch/i386/kernel/crash.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/i386/kernel/crash.c b/arch/i386/kernel/crash.c
> index f10da80..67d297d 100644
> --- a/arch/i386/kernel/crash.c
> +++ b/arch/i386/kernel/crash.c
> @@ -92,7 +92,7 @@ static void crash_save_self(struct pt_re
>        crash_save_this_cpu(regs, cpu);
> }
> 
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
> static atomic_t waiting_for_crash_ipi;
> 
> static int crash_nmi_callback(struct notifier_block *self,



-- 
Horms                                           
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

