Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVHDOPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVHDOPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVHDOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:13:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22690 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262552AbVHDOKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:10:52 -0400
Subject: Re: How to get the physical page addresses from a kernel virtual
	address for DMA SG List?
From: Arjan van de Ven <arjan@infradead.org>
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <42F21A86.8030408@anagramm.de>
References: <42F20CEC.60206@anagramm.de>
	 <Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com>
	 <42F21A86.8030408@anagramm.de>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 16:10:06 +0200
Message-Id: <1123164606.3318.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 15:39 +0200, Clemens Koller wrote:
> Hello, Dick!
> 
> Thanks for your help so far!
> 
> linux-os (Dick Johnson) wrote:
> > 
> > You are trying to do it backwards. You need to have your driver
> > use get_dma_pages() to acquire pages suitable for DMA. Your
> > driver then impliments mmap().
> 
> Okay, I have seen that, too. I've seen that some drivers do it the other
> way around as I do, but I still try to follow my idea that the
> application allocs the memory and the dma / the driver fills it up.
> Or are there fundamental problems I get with my approach which I haven't seen yet?

there are some very funamental problems with that;
say the user allocation is only half the page, and he uses the other
half of the page for something else.
during the DMA some other thread calls fork().

Now the stuff under DMA can't COW of course, so only one half gets it.
But.. what to do with the second half of the page?

this is just one of the many fine fundamental issues you'll face ;)


