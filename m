Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVA0Ufl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVA0Ufl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVA0Ufl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:35:41 -0500
Received: from canuck.infradead.org ([205.233.218.70]:44048 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261172AbVA0Ufc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:35:32 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <20050127203206.GA2180@infradead.org>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org> <20050127202335.GA2033@infradead.org>
	 <20050127202720.GA12390@infradead.org>
	 <20050127203206.GA2180@infradead.org>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 21:35:26 +0100
Message-Id: <1106858127.5624.136.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 20:32 +0000, Christoph Hellwig wrote:
> > The patch below replaces the existing 8Kb randomisation of the userspace
> > stack pointer (which is currently only done for Hyperthreaded P-IVs) with a
> > more general randomisation over a 64Kb range. 64Kb is not a lot, but it's a
> > start and once the dust settles we can increase this value to a more
> > agressive value.
> 
> Why are we doing this for x86 only, btw? 
> 
> > +unsigned long arch_align_stack(unsigned long sp)
> > +{
> > +	if (randomize_va_space)
> > +		sp -= ((get_random_int() % 4096) << 4);
> > +	return sp & ~0xf;
> > +}
> 
> this looks like it'd work nicely on all architectures.

the problem is that the <<4 is the minimum x86 stack pointer alignment.
That value differs per architecture afaics.....


