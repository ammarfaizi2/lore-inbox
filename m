Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVHFCGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVHFCGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 22:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVHFCGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 22:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261904AbVHFCGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 22:06:19 -0400
Date: Fri, 5 Aug 2005 19:05:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: benoit.boissinot@ens-lyon.fr, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: fix invalid kmalloc flags
Message-Id: <20050805190500.1a78322b.akpm@osdl.org>
In-Reply-To: <20050806020035.GA24455@kvack.org>
References: <20050806002603.GA29515@ens-lyon.fr>
	<20050805173629.78f3a0e6.akpm@osdl.org>
	<20050806020035.GA24455@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Fri, Aug 05, 2005 at 05:36:29PM -0700, Andrew Morton wrote:
> > No, GFP_DMA should work OK.  Except GFP_DMA doesn't have __GFP_VALID set. 
> > It's strange that this didn't get noticed earlier.
> > 
> > Ben, was there a reason for not giving GFP_DMA the treatment?
> 
> Not really.  Traditionally GFP_DMA was always mixed in with GFP_KERNEL or 
> GFP_ATOMIC.  It seems that GFP_DMA wasn't in the hunk of defines that all 
> the other kernel flags were in, so if GFP_DMA is really valid all by itself, 
> adding in the __GFP_VALID should be okay.
> 

OK, it seems that pretty much all callers do remember to add GFP_KERNEL so
I guess we can treat this as a bug-which-ben's-patch-found and merge
Benoit's fix.
