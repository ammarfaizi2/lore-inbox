Return-Path: <linux-kernel-owner+w=401wt.eu-S1750825AbXACPC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbXACPC2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbXACPC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:02:28 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:38644 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXACPC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:02:27 -0500
X-Originating-Ip: 74.109.98.100
Date: Wed, 3 Jan 2007 09:55:48 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Jiri Slaby <jirislaby@gmail.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Replace __get_free_page() + memset(0) with get_zeroed_page()
 calls.
In-Reply-To: <459BBB36.1070907@gmail.com>
Message-ID: <Pine.LNX.4.64.0701030954470.26882@localhost.localdomain>
References: <Pine.LNX.4.64.0701030845500.5042@localhost.localdomain>
 <459BBB36.1070907@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	timed out)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Jiri Slaby wrote:

> Robert P. J. Day wrote:
> [...]
> > index fd82411..b3932e5 100644
> > --- a/include/asm-m68k/sun3_pgalloc.h
> > +++ b/include/asm-m68k/sun3_pgalloc.h
> > @@ -36,12 +36,11 @@ static inline void pte_free(struct page *page)
> >  static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> >  					  unsigned long address)
> >  {
> > -	unsigned long page = __get_free_page(GFP_KERNEL|__GFP_REPEAT);
> > +	unsigned long page = get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);
> >
> >  	if (!page)
> >  		return NULL;
> >
> > -	memset((void *)page, 0, PAGE_SIZE);
> >  	return (pte_t *) (page);
> >  }
>
> perhaps simply
> return (pte_t *)get_zeroed_page(GFP_KERNEL|__GFP_REPEAT);

i thought about it, but figured i'd keep the change minimal and not
get into any "editorializing."

rday
