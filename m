Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTEBNGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 09:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTEBNGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 09:06:43 -0400
Received: from holomorphy.com ([66.224.33.161]:16096 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262742AbTEBNGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 09:06:41 -0400
Date: Fri, 2 May 2003 06:18:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
Message-ID: <20030502131857.GH8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030502020149.1ec3e54f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502020149.1ec3e54f.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 02:01:49AM -0700, Andrew Morton wrote:
> +dont-set-kernel-pgd-on-PAE.patch
>  little ia32 optimisation/cleanup

It looks like no one listened to my commentary on the set_pgd() patch.

Remove pointless #ifdef, pointless set_pgd(), and a mysterious line
full of nothing but whitespace after the #endif, and update commentary.

-- wli

$ diffstat ../patches/mm4-2.5.68-2
 fault.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -urpN mm4-2.5.68-1/arch/i386/mm/fault.c mm4-2.5.68-2/arch/i386/mm/fault.c
--- mm4-2.5.68-1/arch/i386/mm/fault.c	2003-05-02 05:32:27.000000000 -0700
+++ mm4-2.5.68-2/arch/i386/mm/fault.c	2003-05-02 05:54:14.000000000 -0700
@@ -333,16 +333,12 @@ vmalloc_fault:
 
 		if (!pgd_present(*pgd_k))
 			goto no_context;
+
 		/*
-		 * kernel pmd pages are shared among all processes
-		 * with PAE on.  Since vmalloc pages are always
-		 * in the kernel area, this will always be a 
-		 * waste with PAE on.
+		 * set_pgd(pgd, *pgd_k); here would be useless on PAE
+		 * and redundant with the set_pmd() on non-PAE.
 		 */
-#ifndef CONFIG_X86_PAE
-		set_pgd(pgd, *pgd_k);
-#endif
-		
+
 		pmd = pmd_offset(pgd, address);
 		pmd_k = pmd_offset(pgd_k, address);
 		if (!pmd_present(*pmd_k))
