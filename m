Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbRCVAWQ>; Wed, 21 Mar 2001 19:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131874AbRCVAV6>; Wed, 21 Mar 2001 19:21:58 -0500
Received: from nrg.org ([216.101.165.106]:21088 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131861AbRCVAVh>;
	Wed, 21 Mar 2001 19:21:37 -0500
Date: Wed, 21 Mar 2001 16:20:50 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel
In-Reply-To: <3AB87CE3.2DB0DA14@uow.edu.au>
Message-ID: <Pine.LNX.4.05.10103211613350.705-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Andrew Morton wrote:
> It's a problem for uniprocessors as well.
> 
> Example:
> 
> #define current_cpu_data boot_cpu_data
> #define pgd_quicklist (current_cpu_data.pgd_quick)
> 
> extern __inline__ void free_pgd_fast(pgd_t *pgd)
> {
>         *(unsigned long *)pgd = (unsigned long) pgd_quicklist;
>         pgd_quicklist = (unsigned long *) pgd;
>         pgtable_cache_size++;
> }
> 
> Preemption could corrupt this list.

Thanks, Andrew, for pointing this out.  I've added fixes to the patch
for this problem and the others in pgalloc.h.  If you know of any other
similar problems on uniprocessors, please let me know.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com

