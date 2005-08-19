Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbVHSDY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVHSDY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVHSDY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:24:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751047AbVHSDY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:24:57 -0400
Date: Thu, 18 Aug 2005 20:23:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org
Subject: Re: [PATCH] Mobil Pentium 4 HT and the NMI
Message-Id: <20050818202300.254410f4.akpm@osdl.org>
In-Reply-To: <1124416748.5186.94.camel@localhost.localdomain>
References: <1124416748.5186.94.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Hi,
> 
> I'm resending this since I don't see it in git yet, and I'm wondering if
> there is a problem with this patch.  I have a IBM ThinkPad G41 with a
> Mobile Pentium 4 HT.  Without this patch, the NMI won't be setup.  Is
> there a reason that if the x86_model is greater than 0x3 it will return.
> Since my processor has a 0x4 x86_model, I upped it to that. Otherwise my
> laptop won't be able to use the NMI.
> 

Well I was hoping that someone with knowledge of the low-level Intel model
differences would pipe up, but they all seem to be in hiding.  (Wildly
bcc's lots of x86 people).

> 
> Description:
>   This patch is to allow the Mobile Penitum 4 HT to use the NMI.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> --- linux-2.6.13-rc6-git10/arch/i386/kernel/nmi.c.orig	2005-08-18 21:51:11.000000000 -0400
> +++ linux-2.6.13-rc6-git10/arch/i386/kernel/nmi.c	2005-08-18 21:52:03.000000000 -0400
> @@ -195,7 +195,7 @@ static void disable_lapic_nmi_watchdog(v
>  			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
>  			break;
>  		case 15:
> -			if (boot_cpu_data.x86_model > 0x3)
> +			if (boot_cpu_data.x86_model > 0x4)
>  				break;
>  
>  			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
> @@ -432,7 +432,7 @@ void setup_apic_nmi_watchdog (void)
>  			setup_p6_watchdog();
>  			break;
>  		case 15:
> -			if (boot_cpu_data.x86_model > 0x3)
> +			if (boot_cpu_data.x86_model > 0x4)
>  				return;
>  
>  			if (!setup_p4_watchdog())
