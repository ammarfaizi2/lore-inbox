Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUEABsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUEABsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 21:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUEABsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 21:48:10 -0400
Received: from ns.suse.de ([195.135.220.2]:7914 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261914AbUEABsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 21:48:08 -0400
Date: Sat, 1 May 2004 03:48:07 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP
Message-ID: <20040501014807.GC14663@wotan.suse.de>
References: <200404301611.i3UGBkdK026345@harpo.it.uu.se> <20040430112704.3dca3c4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430112704.3dca3c4c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this fix?
> 
> diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
> --- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
> +++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
> @@ -20,6 +20,8 @@
>  #include <asm/mmsegment.h>
>  #include <linux/personality.h>
>  
> +#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES

16 should be enough actually. The problem is the FXSAVE instruction that 
is used to switch the FPU state, and that only requires 16 byte alignment.

-Andi
