Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUCKPyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 10:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUCKPyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 10:54:25 -0500
Received: from holomorphy.com ([207.189.100.168]:58384 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261426AbUCKPyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 10:54:24 -0500
Date: Thu, 11 Mar 2004 07:54:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311155420.GW655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040310233140.3ce99610.akpm@osdl.org> <20040311152346.GV655@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311152346.GV655@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 07:23:46AM -0800, William Lee Irwin III wrote:
> +#define pgoff_prot_to_pte(off, prot) \
> +	(__pte(((off) << (PAGE_SHIFT+2)) | _PAGE_FILE | ((prot >> 8) & 0x3UL)))
> +#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 3UL)

Good thing for me it's rarely exercised. Incremental (one-liner):


--- mm1-2.6.4-3/include/asm-sparc64/pgtable.h	2004-03-11 06:27:40.704004000 -0800
+++ mm1-2.6.4-4/include/asm-sparc64/pgtable.h	2004-03-11 07:35:09.766453000 -0800
@@ -330,7 +330,7 @@
 	(pte_file(pte) ? __file_pte_to_pgprot(pte) : __pte_to_pgprot(pte))
 #define pte_to_pgoff(pte)	(pte_val(pte) >> (PAGE_SHIFT+2))
 #define pgoff_prot_to_pte(off, prot) \
-	(__pte(((off) << (PAGE_SHIFT+2)) | _PAGE_FILE | ((prot >> 8) & 0x3UL)))
+	((__pte(((off) | ((pgprot_val(prot) >> 8) & 0x3UL)))) << (PAGE_SHIFT+2) | _PAGE_FILE)
 #define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 3UL)
 
 extern unsigned long prom_virt_to_phys(unsigned long, int *);
