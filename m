Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVF3KuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVF3KuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVF3KuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:50:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39296 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262935AbVF3Krh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:47:37 -0400
Subject: Re: [PATCH] deinline sleep/delay functions
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200506301321.20692.vda@ilport.com.ua>
References: <200506300852.25943.vda@ilport.com.ua>
	 <20050630021111.35aaf45f.akpm@osdl.org>
	 <1120123189.3181.28.camel@laptopd505.fenrus.org>
	 <200506301321.20692.vda@ilport.com.ua>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 12:47:21 +0200
Message-Id: <1120128441.3181.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Thu, 2005-06-30 at 13:21 +0300, Denis Vlasenko wrote:
> On Thursday 30 June 2005 12:19, Arjan van de Ven wrote:
> > 
> > > > There are a number of compile-time checks that your patch has removed
> > > > which catch such things, and as such your patch is not acceptable.
> > > > Some architectures have a lower threshold of acceptability for the
> > > > maximum udelay value, so it's absolutely necessary to keep this.
> > > 
> > > It removes that check from x86 - other architectures retain it.
> > > 
> > > 
> For users, _any_ value, however large, will work for
> any delay function.

that's not desired though. Desired is to limit udelay() to say 2000 or
so. And force anything above that to go via mdelay() (just to make it
stand out as broken code ;)

Over time we also want to phase out mdelay of course...


