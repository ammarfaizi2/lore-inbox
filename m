Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVBBSmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVBBSmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVBBSmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:42:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60864 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262717AbVBBSln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:41:43 -0500
Date: Wed, 2 Feb 2005 13:32:56 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
Message-ID: <20050202153256.GA19615@logos.cnet>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com> <1106828124.19262.45.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106828124.19262.45.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 12:15:24PM +0000, David Woodhouse wrote:
> On Fri, 2005-01-21 at 12:29 -0800, Christoph Lameter wrote:
> > Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> > called scrubd. scrubd is disabled by default but can be enabled
> > by writing an order number to /proc/sys/vm/scrub_start. If a page
> > is coalesced of that order or higher then the scrub daemon will
> > start zeroing until all pages of order /proc/sys/vm/scrub_stop and
> > higher are zeroed and then go back to sleep.
> 
> Some architectures tend to have spare DMA engines lying around. There's
> no need to use the CPU for zeroing pages. How feasible would it be for
> scrubd to use these?

Hi David,

I suppose you are talking about DMA engines which are not being driven 
by any driver ?

Sounds very interesting idea to me. Guess it depends on whether the cost of 
DMA write for memory zeroing, which is memory architecture/DMA engine dependant, 
offsets the cost of CPU zeroing.

Do you have any thoughts on that?

I wonder if such thing (using unrelated devices DMA engine's for zeroing) ever been
done on other OS'es?

AFAIK SGI's BTE is special purpose hardware for memory zeroing.

BTW, Andrew noted on lkml sometime ago that disabling caches before doing 
zeroing could enhance overall system performance by decreasing cache thrashing.
What are the conclusions about that?
