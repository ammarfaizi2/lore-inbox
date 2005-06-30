Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVF3LXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVF3LXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVF3LXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:23:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22145 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262941AbVF3LXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:23:12 -0400
Subject: Re: [PATCH] deinline sleep/delay functions
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200506301410.43524.vda@ilport.com.ua>
References: <200506300852.25943.vda@ilport.com.ua>
	 <200506301321.20692.vda@ilport.com.ua>
	 <1120128441.3181.37.camel@laptopd505.fenrus.org>
	 <200506301410.43524.vda@ilport.com.ua>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 13:22:53 +0200
Message-Id: <1120130573.3181.42.camel@laptopd505.fenrus.org>
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


> An if(usec > 2000) { printk(..); dump_stack(); } will do.

that's runtime not compile time.
The old situation was a compile time check which is far more powerful.

> 
> But do you really want to do this? There might be legitimate reasons
> to compute udelay's parameter with results which are sometimes large.

however that's not valid, because a really large udelay parameter will
cause the delay loop math to overflow. That was the main reason for the
"no more than 2ms or so" restriction.
> 
> If you really want to, let's decide on this limit now,

the existing code already has a limit so why not just use that?


