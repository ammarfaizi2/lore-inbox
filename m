Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751903AbWCIOHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbWCIOHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCIOG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:06:58 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13829 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751903AbWCIOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:06:57 -0500
Date: Thu, 9 Mar 2006 15:06:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       scjody@modernduck.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/ieee1394/ohci1394.c: function calls without effect
Message-ID: <20060309140656.GF21864@stusta.de>
References: <20060309114138.GA21864@stusta.de> <tkrat.be39a8854a3c82c0@s5r6.in-berlin.de> <20060309135100.GD21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309135100.GD21864@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 02:51:00PM +0100, Adrian Bunk wrote:
> On Thu, Mar 09, 2006 at 02:18:28PM +0100, Stefan Richter wrote:
> > ohci1394: Remove superfluous call to free_dma_rcv_ctx,
> > spotted by Adrian Bunk. Also remove some superfluous comments.
> > 
> > Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> > 
> > Index: linux/drivers/ieee1394/ohci1394.c
> > ===================================================================
> > --- linux.orig/drivers/ieee1394/ohci1394.c     2006-03-06 20:04:10.000000000 +0100
> > +++ linux/drivers/ieee1394/ohci1394.c  2006-03-09 14:09:21.000000000 +0100
> > @@ -3462,24 +3462,13 @@ static void ohci1394_pci_remove(struct p
> >  	case OHCI_INIT_HAVE_TXRX_BUFFERS__MAYBE:
> >  		/* The ohci_soft_reset() stops all DMA contexts, so we
> >  		 * dont need to do this.  */
> > -		/* Free AR dma */
> >  		free_dma_rcv_ctx(&ohci->ar_req_context);
> >  		free_dma_rcv_ctx(&ohci->ar_resp_context);
> > -
> > -		/* Free AT dma */
> >  		free_dma_trm_ctx(&ohci->at_req_context);
> >  		free_dma_trm_ctx(&ohci->at_resp_context);
> > -
> > -		/* Free IR dma */
> >  		free_dma_rcv_ctx(&ohci->ir_legacy_context);
> > -
> > -		/* Free IT dma */
> >  		free_dma_trm_ctx(&ohci->it_legacy_context);
> >...
> 
> Unless I'm mireading the code, it's impossible after the call of 
> free_dma_rcv_ctx() that free_dma_trm_ctx() will do anything.

Skip this, Ben already explained to me that an r (ir_) isn't a t (it_).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

