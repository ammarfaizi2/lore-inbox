Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWEQRYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWEQRYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWEQRYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:24:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:2504 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750751AbWEQRYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:24:15 -0400
Date: Wed, 17 May 2006 10:24:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, discuss@x86-64.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage boundries
 when needed
In-Reply-To: <1147885316.26468.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605171020390.13767@schroedinger.engr.sgi.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006, Eric Paris wrote:

> --- linux-2.6.16.14/include/asm-sparc64/page.h.paris
> +++ linux-2.6.16.14/include/asm-sparc64/page.h
> @@ -104,6 +104,8 @@ typedef unsigned long pgprot_t;
>  #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
>  #define ARCH_HAS_SETCLEAR_HUGE_PTE
>  #define ARCH_HAS_HUGETLB_PREFAULT_HOOK
> +/* to align the pointer to the (next) page boundary when dealing with hugepages*/
> +#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
>  #endif

Could you put the definition of HPAGE_ALIGN into include/linux/hugetlb.h 
to avoid modifying all the page.h files?
