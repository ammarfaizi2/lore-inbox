Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935033AbWKXUNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935033AbWKXUNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935034AbWKXUNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:13:36 -0500
Received: from smtp6.orange.fr ([193.252.22.25]:44804 "EHLO
	smtp-msa-out06.orange.fr") by vger.kernel.org with ESMTP
	id S935033AbWKXUNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:13:35 -0500
X-ME-UUID: 20061124201334499.79F6A1C00225@mwinf0603.orange.fr
Date: Fri, 24 Nov 2006 22:14:29 +0200
From: Samuel Ortiz <samuel@sortiz.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
       irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, arjan <arjan@infradead.org>,
       John Platt <jplatt39@gmail.com>
Subject: Re: [PATCH] lockdep: annotate irda warning
Message-ID: <20061124201428.GA4261@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <200611181612.36008.arvidjaar@mail.ru> <1164014139.5968.138.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164014139.5968.138.camel@twins>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On Mon, Nov 20, 2006 at 10:15:39AM +0100, Peter Zijlstra wrote:
>
> So, under the assumption the author was right, it just needs a lockdep
> annotation.
> 
> (depends on patches in -mm for spin_lock_irqsave_nested())
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  net/irda/irlmp.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6-mm/net/irda/irlmp.c
> ===================================================================
> --- linux-2.6-mm.orig/net/irda/irlmp.c	2006-11-20 09:54:50.000000000 +0100
> +++ linux-2.6-mm/net/irda/irlmp.c	2006-11-20 10:12:11.000000000 +0100
> @@ -1678,7 +1678,8 @@ static int irlmp_slsap_inuse(__u8 slsap_
>  	 *  every IrLAP connection and check every LSAP associated with each
>  	 *  the connection.
>  	 */
> -	spin_lock_irqsave(&irlmp->links->hb_spinlock, flags);
> +	spin_lock_irqsave_nested(&irlmp->links->hb_spinlock, flags,
> +			SINGLE_DEPTH_NESTING);
>  	lap = (struct lap_cb *) hashbin_get_first(irlmp->links);
>  	while (lap != NULL) {
>  		IRDA_ASSERT(lap->magic == LMP_LAP_MAGIC, goto errlap;);

This patch got pushed into mainline, while the spin_lock_irq_save_nested()
patches are not there yet. It breaks IrDA as irlmp.c doesn't build.
Linus, could you please revert the corresponding commit
(700f9672c9a61c12334651a94d17ec04620e1976) unless you are planning to pull
the spin_lock_irq_save_nested() patches soon from -mm ?
Thanks a lot in advance.

Cheers,
Samuel.
