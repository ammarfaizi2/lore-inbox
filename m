Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUBSFRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 00:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264310AbUBSFRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 00:17:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26076 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264506AbUBSFRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 00:17:14 -0500
Message-ID: <403446C9.7070803@pobox.com>
Date: Thu, 19 Feb 2004 00:16:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix microcode change for i386
References: <20040219011159.6f60aa69.ak@suse.de>
In-Reply-To: <20040219011159.6f60aa69.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> This patch should fix the i386 compile problem in the microcode driver I caused with
> the IA32e updates.
> 
> diff -u linux-2.6.3-amd64/arch/i386/kernel/microcode.c-o linux-2.6.3-amd64/arch/i386/kernel/microcode.c
> --- linux-2.6.3-amd64/arch/i386/kernel/microcode.c-o	2004-02-19 00:19:32.000000000 +0100
> +++ linux-2.6.3-amd64/arch/i386/kernel/microcode.c	2004-02-19 00:56:41.000000000 +0100
> @@ -371,8 +371,8 @@
>  	spin_lock_irqsave(&microcode_update_lock, flags);          
>  
>  	/* write microcode via MSR 0x79 */
> -	wrmsr(MSR_IA32_UCODE_WRITE, (u64)(uci->mc->bits), 
> -	      (u64)(uci->mc->bits) >> 32);
> +	wrmsr(MSR_IA32_UCODE_WRITE, (u32)(unsigned long)(uci->mc->bits), 
> +	      (u32)(((unsigned long)uci->mc->bits) >> 32));


You still want to do two 16-bit shifts instead of a single 32-bit shift.

	Jeff



