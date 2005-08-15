Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVHOIPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVHOIPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVHOIPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:15:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42374 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932218AbVHOIPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:15:22 -0400
Subject: Re: [-mm patch] make kcalloc() a static inline
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Adrian Bunk <bunk@stusta.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200508151106.05973.vda@ilport.com.ua>
References: <20050808223842.GM4006@stusta.de>
	 <200508151106.05973.vda@ilport.com.ua>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 10:14:20 +0200
Message-Id: <1124093660.3228.14.camel@laptopd505.fenrus.org>
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

On Mon, 2005-08-15 at 11:06 +0300, Denis Vlasenko wrote:

> > +static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
> > +{
> > +	if (n != 0 && size > INT_MAX / n)
> > +		return NULL;
> > +	return kzalloc(n * size, flags);
> > +}

> Can you conditionalize it on __builtin_constant_p(n) ?
> Otherwise with variable n you have 3 oprations in inlined
> code, one of them a division.

you can't conditionalize the security check really. If it's constant,
gcc will optimize it anyway, and if it's not constant you for sure want
the check there...


