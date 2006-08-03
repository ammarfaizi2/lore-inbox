Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWHCUpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWHCUpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWHCUpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:45:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61653 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751355AbWHCUpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:45:14 -0400
Subject: Re: don't taint UP K7's running SMP kernels.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060803183224.GA10797@redhat.com>
References: <20060803183224.GA10797@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 22:04:32 +0100
Message-Id: <1154639072.23655.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 14:32 -0400, ysgrifennodd Dave Jones:
> We have a test that looks for invalid pairings of certain athlon/durons
> that weren't designed for SMP, and taint accordingly (with 'S') if we find
> such a configuration.  However, this test shouldn't fire if there's only
> a single CPU present. It's perfectly valid for an SMP kernel to boot on UP
> hardware for example.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6/arch/i386/kernel/smpboot.c~	2006-08-03 14:29:47.000000000 -0400
> +++ linux-2.6/arch/i386/kernel/smpboot.c	2006-08-03 14:30:43.000000000 -0400
> @@ -177,6 +177,9 @@ static void __devinit smp_store_cpu_info
>  	 */
>  	if ((c->x86_vendor == X86_VENDOR_AMD) && (c->x86 == 6)) {
>  
> +		if (num_online_cpus() == 1)
> +			goto valid_k7;
> +
>  		/* Athlon 660/661 is valid. */	
>  		if ((c->x86_model==6) && ((c->x86_mask==0) || (c->x86_mask==1)))
>  			goto valid_k7;

Acked-by: Alan Cox <alan@redhat.com>


