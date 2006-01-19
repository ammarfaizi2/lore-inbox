Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161454AbWASWEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161454AbWASWEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWASWEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:04:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161450AbWASWEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:04:09 -0500
Date: Thu, 19 Jan 2006 14:05:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: npiggin@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch] sg: simplify page_count manipulations
Message-Id: <20060119140525.223a8ebf.akpm@osdl.org>
In-Reply-To: <20060119144548.GF958@wotan.suse.de>
References: <20060118155242.GB28418@wotan.suse.de>
	<20060118195937.3586c94f.akpm@osdl.org>
	<20060119144548.GF958@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> On Wed, Jan 18, 2006 at 07:59:37PM -0800, Andrew Morton wrote:
> > Nick Piggin <npiggin@suse.de> wrote:
> > > -	/* N.B. correction _not_ applied to base page of each allocation */
> > > -	for (k = 0; k < rsv_schp->k_use_sg; ++k, ++sg) {
> > > -		for (m = PAGE_SIZE; m < sg->length; m += PAGE_SIZE) {
> > > -			page = sg->page;
> > > -			if (startFinish)
> > > -				get_page(page);
> > > -			else {
> > > -				if (page_count(page) > 0)
> > > -					__put_page(page);
> > > -			}
> > > -		}
> > > -	}
> > > -}
> > 
> > What on earth is the above trying to do?  The inner loop is a rather
> > complex way of doing atomic_add(&page->count, sg->length/PAGE_SIZE).  One
> > suspects there's a missing "[m]" in there.
> > 
> 
> It does this on the first mmap of the device, in the hope that subsequent
> nopage, unmaps would not free the constituent pages in the scatterlist.
> 

But it's doing it wrongly, isn't it?  Or am I completely nuts?

