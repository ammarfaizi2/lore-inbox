Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264453AbTCXRWx>; Mon, 24 Mar 2003 12:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264452AbTCXRVZ>; Mon, 24 Mar 2003 12:21:25 -0500
Received: from ns.suse.de ([213.95.15.193]:26642 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264451AbTCXRVM>;
	Mon, 24 Mar 2003 12:21:12 -0500
Subject: Re: [x86-64] Add missing tlb flush after change_page_attr
From: Andi Kleen <ak@suse.de>
To: davej@codemonkey.org.uk
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200303241641.h2OGfw35008208@deviant.impure.org.uk>
References: <200303241641.h2OGfw35008208@deviant.impure.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Mar 2003 18:32:16 +0100
Message-Id: <1048527139.12339.109.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 17:41, davej@codemonkey.org.uk wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/x86_64/kernel/pci-gart.c linux-2.5/arch/x86_64/kernel/pci-gart.c
> --- bk-linus/arch/x86_64/kernel/pci-gart.c	2003-03-08 09:56:51.000000000 +0000
> +++ linux-2.5/arch/x86_64/kernel/pci-gart.c	2003-03-18 21:19:53.000000000 +0000
> @@ -419,6 +419,7 @@ static __init int init_k8_gatt(agp_kern_
>  		panic("Cannot allocate GATT table"); 
>  	memset(gatt, 0, gatt_size); 
>  	change_page_attr(virt_to_page(gatt), gatt_size/PAGE_SIZE, PAGE_KERNEL_NOCACHE);
> +	global_flush_tlb();
>  	agp_gatt_table = gatt;
>  	
>  	for_all_nb(dev) { 

No it needs to be completely removed. the pci aperture is supposed to be
cachable (unlike the AGP aperture) That's still a trace of an earlier
design.

-Andi


