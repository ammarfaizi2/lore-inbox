Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVBZKBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVBZKBi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 05:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVBZKBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 05:01:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19394 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261889AbVBZKBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 05:01:36 -0500
Subject: Re: [2.6 patch] unexport do_settimeofday
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050225152009.14cdf450.akpm@osdl.org>
References: <20050224233742.GR8651@stusta.de>
	 <20050224212448.367af4be.akpm@osdl.org> <20050225214326.GE3311@stusta.de>
	 <20050225135504.7749942e.akpm@osdl.org> <20050225230246.GI3311@stusta.de>
	 <20050225152009.14cdf450.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 26 Feb 2005 11:01:24 +0100
Message-Id: <1109412084.6414.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 15:20 -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > > +#ifdef MODULE
> > > +#define __deprecated_in_modules __deprecated
> > > +#else
> > > +#define __deprecated_in_modules /* OK in non-modular code */
> > > +#endif
> > > +
> > >...
> > 
> > Looks good.
> > 
> > 
> > One more question:
> > 
> > You get a false positive if the file containing the symbol is itself a 
> > module.
> 
> I don't understand what you mean.
> 
> You mean that a module is doing an EXPORT_SYMBOL of a symbol which is on
> death row?
> 
> If so: err, not sure.  I guess we could just live with the warning.

also those should be rare; it's certainly not a "core" export that 3rd
party stuff depends on but most of the time just accidentally exported
(by people who thought that they needed EXPORT_SYMBOL to glue two .c
files into the same one .o module)

