Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRCZQrN>; Mon, 26 Mar 2001 11:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRCZQrD>; Mon, 26 Mar 2001 11:47:03 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:34820 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132484AbRCZQq6>; Mon, 26 Mar 2001 11:46:58 -0500
Date: Mon, 26 Mar 2001 20:42:38 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac25
Message-ID: <20010326204238.B552@jurassic.park.msu.ru>
In-Reply-To: <E14hQaE-0001AK-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14hQaE-0001AK-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 26, 2001 at 07:34:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 07:34:26AM +0100, Alan Cox wrote:
> Alpha has probably been broken by the pre8 merge.

Yep, but not too much. This "unbreaks" it.

Ivan.

--- 2.4.2-ac25/include/asm-alpha/pgalloc.h	Mon Mar 26 17:59:22 2001
+++ linux/include/asm-alpha/pgalloc.h	Mon Mar 26 19:58:19 2001
@@ -303,7 +303,7 @@ static inline void pmd_free_slow(pmd_t *
 	free_page((unsigned long)pmd);
 }
 
-static inline pte_t *pte_alloc_one(void)
+static inline pte_t *pte_alloc_one(unsigned long address)
 {
 	pte_t *pte = (pte_t *)__get_free_page(GFP_KERNEL);
 	if (pte)
@@ -311,7 +311,7 @@ static inline pte_t *pte_alloc_one(void)
 	return pte;
 }
 
-static inline pte_t *pte_alloc_one_fast(void)
+static inline pte_t *pte_alloc_one_fast(unsigned long address)
 {
 	unsigned long *ret;
 
