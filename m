Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUCXJzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 04:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUCXJzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 04:55:14 -0500
Received: from gprs214-213.eurotel.cz ([160.218.214.213]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263125AbUCXJzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 04:55:08 -0500
Date: Wed, 24 Mar 2004 10:54:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kenneth Chen <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: add lowpower_idle sysctl
Message-ID: <20040324095422.GA241@elf.ucw.cz>
References: <20040317192821.1fe90f24.akpm@osdl.org> <200403182159.i2ILxhF12208@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403182159.i2ILxhF12208@unix-os.sc.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sounds good, Thanks for the suggestion. I just coded it up:
> 
> 
> diff -Nur linux-2.6.4/include/linux/cpu.h linux-2.6.4.halt/include/linux/cpu.h
> --- linux-2.6.4/include/linux/cpu.h	2004-03-10 18:55:23.000000000 -0800
> +++ linux-2.6.4.halt/include/linux/cpu.h	2004-03-18 13:47:43.000000000 -0800
> @@ -52,6 +52,12 @@
> 
>  #endif /* CONFIG_SMP */
>  extern struct sysdev_class cpu_sysdev_class;
> +extern int idle_mode;
> +
> +#define IDLE_NOOP	0
> +#define IDLE_HALT	1
> +#define IDLE_POLL	2
> +#define IDLE_ACPI	3
> 

How is idle_noop different from idle_poll?

idle_halt is equivalent to idle_acpi_C1. But acpi supports also C2
(deeper sleep), and C3 (sleep without coherent caches) and newer
machines support even more. You might want to talk to Len Brown.

[And yes, limiting to C2 (for example) *is* usefull; some machines
(nforce2 iirc) have bugs, and die if you do C3 at wrong time].

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
