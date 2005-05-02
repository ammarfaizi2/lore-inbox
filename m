Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVEBKPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVEBKPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 06:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVEBKPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 06:15:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17910 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261191AbVEBKPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 06:15:04 -0400
Date: Mon, 2 May 2005 11:14:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Jesper Juhl <juhl-lkml@dif.dk>, sneakums@zork.net, rbrito@ime.usp.br,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.12-rc3-mm2: ppc pte_offset_map()
In-Reply-To: <20050501154654.2bf7606d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505021110450.6198@goblin.wat.veritas.com>
References: <20050430164303.6538f47c.akpm@osdl.org> 
    <6uu0lnf0gm.fsf@zork.zork.net> 
    <Pine.LNX.4.62.0505011749280.2488@dragon.hyggekrogen.localhost> 
    <20050501154654.2bf7606d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 02 May 2005 10:14:14.0720 (UTC) 
    FILETIME=[B13E3C00:01C54EFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005, Andrew Morton wrote:
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > 
> > --- linux-2.6.12-rc3-mm2-orig/fs/proc/task_mmu.c	2005-05-01 04:04:25.000000000 +0200
> > +++ linux-2.6.12-rc3-mm2/fs/proc/task_mmu.c	2005-05-01 17:49:14.000000000 +0200
> > @@ -2,6 +2,7 @@
> >  #include <linux/hugetlb.h>
> >  #include <linux/mount.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/highmem.h>
> >  
> >  #include <asm/elf.h>
> >  #include <asm/uaccess.h>
> > @@ -204,7 +205,7 @@ static void smaps_pte_range(pmd_t *pmd,
> >  			}
> >  		}
> >  	} while (address < end);
> > -	pte_unmap(pte);
> > +	pte_unmap((void *)pte);
> >  }
> 
> Should be
> 
> 	pte_unmap(ptep);

Almost.  Should be

	pte_unmap(ptep - 1);
