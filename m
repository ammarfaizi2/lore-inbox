Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVCON3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVCON3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCON3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:29:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:55458 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261222AbVCON2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:28:48 -0500
Subject: Re: swsusp_restore crap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200503151251.01109.rjw@sisk.pl>
References: <1110857069.29123.5.camel@gaston>
	 <1110857516.29138.9.camel@gaston> <20050315110309.GA1344@elf.ucw.cz>
	 <200503151251.01109.rjw@sisk.pl>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 00:26:44 +1100
Message-Id: <1110893204.24296.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It breaks compilation on i386 either, because nr_copy_pages_check
> is static in swsusp.c.  May I propose the following patch instead (tested on
> x86-64 and i386)?
> 
> Greets,
> Rafael
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> diff -Nrup linux-2.6.11-bk10-a/arch/i386/power/cpu.c linux-2.6.11-bk10-b/arch/i386/power/cpu.c
> --- linux-2.6.11-bk10-a/arch/i386/power/cpu.c	2005-03-15 09:20:53.000000000 +0100
> +++ linux-2.6.11-bk10-b/arch/i386/power/cpu.c	2005-03-15 12:16:57.000000000 +0100
> @@ -147,6 +147,15 @@ void restore_processor_state(void)
>  	__restore_processor_state(&saved_context);
>  }
>  
> +asmlinkage int __swsusp_flush_tlb(void)
> +{
> +	swsusp_restore_check();
> +

Do we really need that check there ? Can't it be moved elsewhere ?

Ben.


