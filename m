Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUFXVAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUFXVAQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUFXVAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:00:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24193 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261252AbUFXVAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:00:06 -0400
Date: Thu, 24 Jun 2004 13:59:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2 oopses and badness
Message-ID: <34050000.1088110774@flay>
In-Reply-To: <20040624120229.7995f5f4.akpm@osdl.org>
References: <1968860000.1088089370@[10.10.2.4]> <20040624120229.7995f5f4.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> During bootup, shortly after CPU init (mm1 was fine):
>> 
>>  Only candidate I can see is 
>>  +reduce-tlb-flushing-during-process-migration-2.patch
>>  Will try backing that out unless you want something else ...
> 
> yes, that is the culprit.
> 
> 
>  Only candidate I can see is 
>  +reduce-tlb-flushing-during-process-migration-2.patch
>  Will try backing that out unless you want something else ...
> 
> 
> diff -puN include/asm-generic/tlb.h~reduce-tlb-flushing-during-process-migration-2-fix include/asm-generic/tlb.h
> --- 25/include/asm-generic/tlb.h~reduce-tlb-flushing-during-process-migration-2-fix	2004-06-24 12:01:14.127142208 -0700
> +++ 25-akpm/include/asm-generic/tlb.h	2004-06-24 12:01:27.815061328 -0700
> @@ -147,6 +147,6 @@ static inline void tlb_remove_page(struc
>  		__pmd_free_tlb(tlb, pmdp);			\
>  	} while (0)
>  
> -#define tlb_migrate_finish(mm) flush_tlb_mm(mm)
> +#define tlb_migrate_finish(mm) do { } while (0)
>  
>  #endif /* _ASM_GENERIC__TLB_H */

Thanks - tested ... fixes it ;-)

M.

