Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVLQWZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVLQWZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVLQWZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:25:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7365 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964985AbVLQWZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:25:30 -0500
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
From: Arjan van de Ven <arjan@infradead.org>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: Christoph Hellwig <hch@infradead.org>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1134857953.20575.59.camel@phosphene.durables.org>
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	 <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	 <20051217131456.GA13043@infradead.org>
	 <1134857953.20575.59.camel@phosphene.durables.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 23:25:23 +0100
Message-Id: <1134858323.2997.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 14:19 -0800, Robert Walsh wrote:
> > > +{
> > > +	void *ssv, *dsv;
> > > +	uint32_t csv;
> > > +	__asm__ __volatile__("cld\n\trep\n\tmovsb":"=&c"(csv), "=&D"(dsv),
> > > +			     "=&S"(ssv)
> > > +			     :"0"(cnt), "1"(dest), "2"(src)
> > > +			     :"memory");
> > > +}
> > 
> > No way we're gonna put assembler code into such a driver.
> 
> Why not?  The chip (and therefore the driver) only works with Opterons.
> It's tied to the HT bus, but PCI or anything like that.

and opterons can already run 2 architectures. And the HT bus is a
generic bus.. with public specs. Others than just AMD use it as well.

also.. what is wrong with memcpy and co ?

> > > +static __inline__ uint32_t ipath_kget_kreg32(const ipath_type stype,
> > > +					     ipath_kreg regno)
> > > +{
> > > +	volatile uint32_t *kreg32;
> > > +
> > > +	if (!devdata[stype].ipath_kregbase)
> > > +		return ~0;
> > > +
> > > +	kreg32 = (volatile uint32_t *)&devdata[stype].ipath_kregbase[regno];
> > 
> > volatile use is probably always wrong. but this whole functions looks like
> > a very odd wrapper anyway?
> 
> The volatile is there so the compiler doesn't optimize away the read.
> This is important, because reads of our hardware have side-effects and
> cannot be optimized out.

then you need to use readl() and family most like; they already take
care of this anyway.


