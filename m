Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264381AbTCXT61>; Mon, 24 Mar 2003 14:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264387AbTCXT61>; Mon, 24 Mar 2003 14:58:27 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:58298 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S264381AbTCXT6Z> convert rfc822-to-8bit; Mon, 24 Mar 2003 14:58:25 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: davej@codemonkey.org.uk, torvalds@transmeta.com
Subject: Re: [x86-64] Add missing tlb flush after change_page_attr
Date: Mon, 24 Mar 2003 21:08:43 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, ak@suse.de
References: <200303241641.h2OGfw35008208@deviant.impure.org.uk>
In-Reply-To: <200303241641.h2OGfw35008208@deviant.impure.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200303242108.53534.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. März 2003 17:41 schrieb davej@codemonkey.org.uk:
> diff -urpN --exclude-from=/home/davej/.exclude 
bk-linus/arch/x86_64/kernel/pci-gart.c 
linux-2.5/arch/x86_64/kernel/pci-gart.c
> --- bk-linus/arch/x86_64/kernel/pci-gart.c	2003-03-08 09:56:51.000000000 
+0000
> +++ linux-2.5/arch/x86_64/kernel/pci-gart.c	2003-03-18 21:19:53.000000000 
+0000
> @@ -419,6 +419,7 @@ static __init int init_k8_gatt(agp_kern_
>  		panic("Cannot allocate GATT table"); 
>  	memset(gatt, 0, gatt_size); 
>  	change_page_attr(virt_to_page(gatt), gatt_size/PAGE_SIZE, 
PAGE_KERNEL_NOCACHE);
> +	global_flush_tlb();
>  	agp_gatt_table = gatt;
>  	
>  	for_all_nb(dev) { 

The global_flush_tlb() for the change_page_attr() is already present about 20 
lines below...
