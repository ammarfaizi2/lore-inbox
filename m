Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVEBAjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVEBAjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 20:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVEBAjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 20:39:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:62877 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261570AbVEBAje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 20:39:34 -0400
Subject: Re: 2.6.12-rc3-mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505012224350.2488@dragon.hyggekrogen.localhost>
References: <20050501201145.GA14429@ime.usp.br>
	 <Pine.LNX.4.62.0505012224350.2488@dragon.hyggekrogen.localhost>
Content-Type: text/plain
Date: Mon, 02 May 2005 10:37:27 +1000
Message-Id: <1114994247.7111.347.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I recently posted this patch in another thread, give it a try : 
> 
> --- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
> +++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 17:49:14.000000000 +0200
> @@ -2,6 +2,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/mount.h>
>  #include <linux/seq_file.h>
> +#include <linux/highmem.h>
>  
>  #include <asm/elf.h>
>  #include <asm/uaccess.h>
> @@ -204,7 +205,7 @@ static void smaps_pte_range(pmd_t *pmd,
>  			}
>  		}
>  	} while (address < end);
> -	pte_unmap(pte);
> +	pte_unmap((void *)pte);
>  }
>  
>  static void smaps_pmd_range(pud_t *pud,

This is unrelated, and shouldn't be necessary. I don't lile patches that
defeat typechecking. Of pte isn't a pte_t *, then something is wrong.

Ben.


