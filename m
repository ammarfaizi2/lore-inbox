Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUFXTH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUFXTH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbUFXTH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:07:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:57560 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264788AbUFXTD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:03:28 -0400
Date: Thu, 24 Jun 2004 12:02:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2 oopses and badness
Message-Id: <20040624120229.7995f5f4.akpm@osdl.org>
In-Reply-To: <1968860000.1088089370@[10.10.2.4]>
References: <1968860000.1088089370@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> During bootup, shortly after CPU init (mm1 was fine):
> 
>  Only candidate I can see is 
>  +reduce-tlb-flushing-during-process-migration-2.patch
>  Will try backing that out unless you want something else ...

yes, that is the culprit.


 Only candidate I can see is 
 +reduce-tlb-flushing-during-process-migration-2.patch
 Will try backing that out unless you want something else ...


diff -puN include/asm-generic/tlb.h~reduce-tlb-flushing-during-process-migration-2-fix include/asm-generic/tlb.h
--- 25/include/asm-generic/tlb.h~reduce-tlb-flushing-during-process-migration-2-fix	2004-06-24 12:01:14.127142208 -0700
+++ 25-akpm/include/asm-generic/tlb.h	2004-06-24 12:01:27.815061328 -0700
@@ -147,6 +147,6 @@ static inline void tlb_remove_page(struc
 		__pmd_free_tlb(tlb, pmdp);			\
 	} while (0)
 
-#define tlb_migrate_finish(mm) flush_tlb_mm(mm)
+#define tlb_migrate_finish(mm) do { } while (0)
 
 #endif /* _ASM_GENERIC__TLB_H */
_

