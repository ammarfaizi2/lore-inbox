Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVATKjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVATKjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 05:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVATKjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 05:39:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54441 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262108AbVATKjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 05:39:46 -0500
Date: Thu, 20 Jan 2005 10:39:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, robert.olsson@its.uu.se,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
Message-ID: <20050120103937.GA32209@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, robert.olsson@its.uu.se,
	linux-kernel@vger.kernel.org
References: <20050119213818.55b14bb0.akpm@osdl.org> <20050120095709.GA29811@gareth.mathematik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120095709.GA29811@gareth.mathematik.tu-chemnitz.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:57:09AM +0100, Steffen Klassert wrote:
> On Wed, Jan 19, 2005 at 09:38:18PM -0800 or thereabouts, Andrew Morton wrote:
> 
> > +kill-softirq_pending.patch
> > 
> >  Remove softirq_pending().  This breaks net/core/pktgen.c.
> 
> net/built-in.o: In function `pktgen_thread_worker':
> /usr/src/linux-2.6.11-rc1-mm2/net/core/pktgen.c:2809: undefined reference to `softirq_pending'
> make: *** [.tmp_vmlinux1] Error 1
> 
> The patch below is a compile fix.
> 
> Signed-off-by: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
> 
> --- vanilla-2.6.11-rc1-mm2/net/core/pktgen.c	Thu Jan 20 10:30:12 2005
> +++ linux-2.6.11-rc1-mm2/net/core/pktgen.c	Thu Jan 20 10:26:03 2005
> @@ -2806,7 +2806,7 @@
>  			tx_since_softirq += pkt_dev->last_ok;
>  
>  			if (tx_since_softirq > max_before_softirq) {
> -				if(softirq_pending(smp_processor_id()))  
> +				if(local_softirq_pending())  

That patch is fine, thanks.
