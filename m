Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbTBQQve>; Mon, 17 Feb 2003 11:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbTBQQvd>; Mon, 17 Feb 2003 11:51:33 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1976 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267157AbTBQQvc>; Mon, 17 Feb 2003 11:51:32 -0500
Date: Mon, 17 Feb 2003 09:01:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: asm-i386/numaq.h fixes
Message-ID: <4540000.1045501282@[10.10.2.4]>
In-Reply-To: <20030217075107.GA14324@holomorphy.com>
References: <20030217075107.GA14324@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As can be seen from:
> 
> http://www-3.ibm.com/software/data/db2/benchmarks/050300.html
> 
> MAX_NUMNODES is 16 on NUMA-Q, not 8.

Not unless we have NUM_CPUS > BITS_PER_LONG it's not. Please don't change that.
 
> Also, PHYSADDR_TO_NID() needs to parenthesize its argument.

Fair enough.

> -- wli
> 
> ===== include/asm-i386/numaq.h 1.5 vs edited =====
> --- 1.5/include/asm-i386/numaq.h	Tue Jan  7 03:11:19 2003
> +++ edited/include/asm-i386/numaq.h	Sun Feb 16 23:47:34 2003
> @@ -37,8 +37,8 @@
>  #define PAGES_PER_ELEMENT (16777216/256)
>  
>  #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
> -#define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
> -#define MAX_NUMNODES		8
> +#define PHYSADDR_TO_NID(pa) pfn_to_nid((pa) >> PAGE_SHIFT)
> +#define MAX_NUMNODES		16
>  extern int pfn_to_nid(unsigned long);
>  extern void get_memcfg_numaq(void);
>  #define get_memcfg_numa() get_memcfg_numaq()
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


