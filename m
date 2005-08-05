Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVHEJsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVHEJsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVHEJsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:48:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29381 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262939AbVHEJrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:47:14 -0400
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
From: Arjan van de Ven <arjan@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
In-Reply-To: <Pine.LNX.4.61.0508051132540.3743@scrub.home>
References: <1123219747.20398.1.camel@localhost>
	 <20050804223842.2b3abeee.akpm@osdl.org>
	 <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI>
	 <20050804233634.1406e92a.akpm@osdl.org>
	 <Pine.LNX.4.61.0508051132540.3743@scrub.home>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 11:46:59 +0200
Message-Id: <1123235219.3239.46.camel@laptopd505.fenrus.org>
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

On Fri, 2005-08-05 at 11:37 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 4 Aug 2005, Andrew Morton wrote:
> 
> > > +static inline void *kzalloc(size_t size, unsigned int __nocast flags)
> > > +{
> > > +	return kcalloc(1, size, flags);
> > > +}
> > > +
> > 
> > That'll generate just as much code as simply using kcalloc(1, ...).  This
> > function should be out-of-line and EXPORT_SYMBOL()ed.  And kcalloc() can
> > call it too..
> 
> BTW we already have 420 "kcalloc(1, ...)" user and 41 without the 1 
> argument, most of them are in sound, which introduced it in first place.
> Can we please deprecate that function before it spreads any further?

kcalloc does have value, in that it's a nice api to avoid multiplication
overflows. Just for "1" it's indeed not the most useful API. 

