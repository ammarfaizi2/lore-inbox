Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWIZX7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWIZX7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWIZX7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:59:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64190 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbWIZX7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:59:18 -0400
Date: Tue, 26 Sep 2006 16:58:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>, Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86: Allow users to force a panic on NMI
Message-Id: <20060926165857.4bf90fd6.akpm@osdl.org>
In-Reply-To: <200609262259.k8QMxxa9012876@hera.kernel.org>
References: <200609262259.k8QMxxa9012876@hera.kernel.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 22:59:59 GMT
Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -21,6 +21,7 @@ #include <linux/kexec.h>
>  #include <linux/debug_locks.h>
>  
>  int panic_on_oops;
> +int panic_on_unrecovered_nmi;
>  int tainted;
>  static int pause_on_oops;
>  static int pause_on_oops_flag;

Is visible to all architectures.

> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 040de6b..220e205 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -642,6 +642,14 @@ #if defined(CONFIG_X86_LOCAL_APIC) && de
>  #endif
>  #if defined(CONFIG_X86)
>  	{
> +		.ctl_name	= KERN_PANIC_ON_NMI,
> +		.procname	= "panic_on_unrecovered_nmi",
> +		.data		= &panic_on_unrecovered_nmi,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec,
> +	},
> +	{

But is x86-only.
