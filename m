Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWEKGOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWEKGOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 02:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWEKGOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 02:14:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:492 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965140AbWEKGOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 02:14:11 -0400
Subject: Re: [RFC][PATCH] Cascaded interrupts: a simple solution
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1147325215.30380.45.camel@localhost.localdomain>
References: <1147325215.30380.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 11 May 2006 16:13:43 +1000
Message-Id: <1147328023.30380.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Index: linux-work/kernel/irq/manage.c
> ===================================================================
> --- linux-work.orig/kernel/irq/manage.c	2006-05-11 11:45:09.000000000 +1000
> +++ linux-work/kernel/irq/manage.c	2006-05-11 12:00:52.000000000 +1000
> @@ -371,6 +371,13 @@ int request_irq(unsigned int irq,
>  	if (!handler)
>  		return -EINVAL;
>  
> +	/*
> +	 * SA_CASCADE implies SA_INTERRUPT (that is, the demux itself happens
> +	 * with interrupts disabled, the final handler is still called with
> +	 */
> +	if (irqflags & SA_CASCADEIRQ)
> +		irqflags |= SA_INTERRUPT;
> +

Oh and that bit isn't actually necessary ...

Ben.


