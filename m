Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267054AbUBEXQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267053AbUBEXPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:15:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:10895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267031AbUBEXOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:14:44 -0500
Date: Thu, 5 Feb 2004 15:15:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] memblks compile fixes
Message-Id: <20040205151556.157c88cb.akpm@osdl.org>
In-Reply-To: <20040205202503.GB6551@sgi.com>
References: <20040205202503.GB6551@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> Looks like Jes forgot missed some conversions in his NR_MEMBLKS removal
> patch.  Here's are the fixes to get ia64 going again.

It seems that Len has fixed one of these in the ACPI tree.

Len, were you planning on a merge soon?   (You should...)

> 
> ===== arch/ia64/kernel/acpi.c 1.60 vs edited =====
> --- 1.60/arch/ia64/kernel/acpi.c	Tue Feb  3 21:35:17 2004
> +++ edited/arch/ia64/kernel/acpi.c	Thu Feb  5 11:46:50 2004
> @@ -395,7 +395,7 @@
>  	size = ma->length_hi;
>  	size = (size << 32) | ma->length_lo;
>  
> -	if (num_memblks >= NR_MEMBLKS) {
> +	if (num_node_memblks >= NR_NODE_MEMBLKS) {
>  		printk(KERN_ERR "Too many mem chunks in SRAT. Ignoring %ld MBytes at %lx\n",
>  		       size/(1024*1024), paddr);
>  		return;
> ===== arch/ia64/sn/kernel/setup.c 1.30 vs edited =====
> --- 1.30/arch/ia64/sn/kernel/setup.c	Tue Feb  3 21:39:58 2004
> +++ edited/arch/ia64/sn/kernel/setup.c	Thu Feb  5 11:46:31 2004
> @@ -136,7 +136,7 @@
>  	int nid;
>  
>  	nid = pxm_to_nid_map[pxm];
> -	for (i = 0; i < num_memblks; i++) {
> +	for (i = 0; i < num_node_memblks; i++) {
>  		if (node_memblk[i].nid == nid) {
>  			return NASID_GET(node_memblk[i].start_paddr);
>  		}
