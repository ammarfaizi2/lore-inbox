Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVCOCGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVCOCGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVCOCGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:06:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:46481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261393AbVCOCGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:06:11 -0500
Date: Mon, 14 Mar 2005 18:05:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jason Davis <jason@rightthere.net>
Cc: linux-kernel@vger.kernel.org, natalie.protasevich@unisys.com,
       jason.davis@unisys.com
Subject: Re: [PATCH] ES7000 Legacy Mappings Update
Message-Id: <20050314180554.10455185.akpm@osdl.org>
In-Reply-To: <20050314183533.GA28889@righTThere.net>
References: <20050314183533.GA28889@righTThere.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You triggered my trivia twitch.

Jason Davis <jason@rightthere.net> wrote:
>
>  -	 * ES7000 has no legacy identity mappings
>  +	 * Older generations of ES7000 have no legacy identity mappings
>   	 */
>  -	if (es7000_plat)
>  +	if (es7000_plat && es7000_plat < 2) 
>   		return;

Why not

	if (es7000_plat == 1)

?

>   	/* 
>  diff -Naurp linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c
>  --- linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c	2005-03-13 01:44:41.000000000 -0500
>  +++ linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c	2005-03-14 11:52:44.000000000 -0500
>  @@ -138,7 +138,14 @@ parse_unisys_oem (char *oemptr, int oem_
>   		es7000_plat = 0;
>   	} else {
>   		printk("\nEnabling ES7000 specific features...\n");
>  -		es7000_plat = 1;
>  +		/*
>  +		 * Check to see if this is a x86_64 ES7000 machine.
>  +		 */
>  +		if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
>  +			es7000_plat = 2;
>  +		else
>  +			es7000_plat = 1;
>  +

Perhaps some nice enumerated identifiers here, rather than magic numbers?
