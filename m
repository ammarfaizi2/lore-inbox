Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVHTIBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVHTIBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 04:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVHTIBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 04:01:23 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:61754 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932162AbVHTIBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 04:01:22 -0400
Message-ID: <4306E345.90102@cosmosbay.com>
Date: Sat, 20 Aug 2005 10:01:09 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] SLAB : removes local_irq_save()/local_irq_restore() pair
 in ksize()
References: <20050819233828.GC3615@stusta.de>
In-Reply-To: <20050819233828.GC3615@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------040402000707090800090909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040402000707090800090909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes unnecessary critical section in ksize() function, as cli/sti are rather expensive on modern CPUS.


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------040402000707090800090909
Content-Type: text/plain;
 name="patch_ksize"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_ksize"

diff -Nru linux-2.6.13-rc6-ed/mm/slab.c linux-2.6.13-rc6/mm/slab.c
--- linux-2.6.13-rc6-ed/mm/slab.c	2005-08-20 09:22:29.000000000 +0200
+++ linux-2.6.13-rc6/mm/slab.c	2005-08-20 09:39:42.000000000 +0200
@@ -3080,10 +3080,8 @@
 	unsigned int size = 0;
 
 	if (likely(objp != NULL)) {
-		local_irq_save(flags);
 		c = GET_PAGE_CACHE(virt_to_page(objp));
 		size = kmem_cache_size(c);
-		local_irq_restore(flags);
 	}
 
 	return size;

--------------040402000707090800090909--
