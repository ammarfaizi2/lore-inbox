Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVEKIgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVEKIgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVEKIgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:36:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29866 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261926AbVEKIfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:35:24 -0400
Subject: Re: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Abhay Salunke <Abhay_Salunke@dell.com>, linux-kernel@vger.kernel.org,
       matt_domsch@dell.com, Greg KH <greg@kroah.com>
In-Reply-To: <20050510165925.271d7967.akpm@osdl.org>
References: <20050510220520.GA30741@littleblue.us.dell.com>
	 <20050510165925.271d7967.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 May 2005 10:35:18 +0200
Message-Id: <1115800518.6029.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 16:59 -0700, Andrew Morton wrote:

> > +			
> > +			/* free this memory as we need it with in 4GB range */
> > +			free_pages ((unsigned long)pbuf, *ordernum);
> > +			
> > +			/* try allocating a new buffer from the GFP_DMA range 
> > +			   as it is with in 16MB range.*/
> > +			pbuf =(unsigned char *)__get_free_pages(GFP_DMA, *ordernum);
> > +			
> > +			if (pbuf == NULL)
> > +				pr_debug("Failed to get memory of size %ld using GFP_DMA\n", size);
> > +		}
> > +	}
> > +	return pbuf;
> > +}
> 
> What architecture is this code designed for?  On x86 a GFP_KERNEL
> allocation will never return highmem.  I guess x86_64?
> 
> I assume this code is here because the x86_64 BIOS will only access the
> lower 4GB?  If so, a comment to that extent would be useful.
> 
> Sometime I expect that x86_64 will gain a new zone, GFP_DMA32 which will be
> guaranteed to return memory below he 4GB point.  When that happens, this
> driver should be converted to use it.

Almost always when this happens the driver actually wanted to use
pci_alloc_consistent memory... (i've not seen the rest of the driver yet
so can't say how appropriate that would be here)


