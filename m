Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTBXW0c>; Mon, 24 Feb 2003 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTBXW0c>; Mon, 24 Feb 2003 17:26:32 -0500
Received: from packet.digeo.com ([12.110.80.53]:10720 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261375AbTBXW0b>;
	Mon, 24 Feb 2003 17:26:31 -0500
Date: Mon, 24 Feb 2003 14:33:41 -0800
From: Andrew Morton <akpm@digeo.com>
To: Paul Larson <plars@linuxtestproject.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pte_alloc_kernel needs additional check
Message-Id: <20030224143341.0b3e1faa.akpm@digeo.com>
In-Reply-To: <1046123680.13919.67.camel@plars>
References: <1046123680.13919.67.camel@plars>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Feb 2003 22:36:38.0240 (UTC) FILETIME=[319B7E00:01C2DC55]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson <plars@linuxtestproject.org> wrote:
>
> This applies against 2.5.63.
> pte_alloc_kernel needs a check for pmd_present(*pmd) at the end.
> 
> Thanks,
> Paul Larson
> 
> --- linux-2.5.63/mm/memory.c	Mon Feb 24 13:05:31 2003
> +++ linux-2.5.63-fix/mm/memory.c	Mon Feb 24 15:45:05 2003
> @@ -186,7 +186,9 @@
>  		pmd_populate_kernel(mm, pmd, new);
>  	}
>  out:
> -	return pte_offset_kernel(pmd, address);
> +	if (pmd_present(*pmd))
> +		return pte_offset_kernel(pmd, address);
> +	return NULL;
>  }
>  #define PTE_TABLE_MASK	((PTRS_PER_PTE-1) * sizeof(pte_t))
>  #define PMD_TABLE_MASK	((PTRS_PER_PMD-1) * sizeof(pmd_t))

Confused.  I cannot see a codepath which makes this test necessary?


