Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSFLWww>; Wed, 12 Jun 2002 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317353AbSFLWwv>; Wed, 12 Jun 2002 18:52:51 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:8927 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316047AbSFLWwt>; Wed, 12 Jun 2002 18:52:49 -0400
Date: Thu, 13 Jun 2002 00:52:38 +0200
From: Andi Kleen <ak@muc.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] pageattr update
Message-ID: <20020613005238.A17700@averell>
In-Reply-To: <20020612010443.B1350@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 07:04:43AM +0200, Benjamin LaHaise wrote:
> Below are some updates to the pageattr patch you posted earlier.  The 
> first set of changes were to add change_page_attrs in several paths 
> where the AGP and DRM code would allocate a page and then call 
> ioremap_nocache on it to create an uncachable mapping.  Secondly, I 

I don't think these changes are needed. The GART tables itself have no physical
alias and the CPU AFAIK deals fine with virtual aliases.

> removed the #ifdef __i386__ around the change_page_attr hook, and 
> instead put dummy macros in the headers for the various other archs.  
> There was a race in pageattr.c that would make the P4 unhappy, so I 
> moved the pte page free to after the tlb flush.  The tlb flush was 

I had already fixed that, but thanks.

> not flushing global pages, so I replaced the code with a call to 
> flush_tlb_all() to do the job.  Lastly, since the top page of the 
> page tables on x86 is unique to each mm and contains copies of the 
> pmd entries in non-PAE mode, I added a function to walk all mms via 
> the mmlist to update the pmds before the tlb flush.

Urks. last version was only tested on PAE @)

Will release a new version tomorrow.

-Andi
