Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVAOHnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVAOHnk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 02:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVAOHnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 02:43:40 -0500
Received: from canuck.infradead.org ([205.233.218.70]:12306 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262233AbVAOHni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:43:38 -0500
Subject: Re: Linux 2.4.29-rc2
From: Arjan van de Ven <arjan@infradead.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Steffen Moser <lists@steffen-moser.de>, linux-kernel@vger.kernel.org,
       David Dyck <david.dyck@fluke.com>
In-Reply-To: <20050114231712.GH3336@logos.cnet>
References: <20050112151334.GC32024@logos.cnet>
	 <20050114225555.GA17714@steffen-moser.de>
	 <20050114231712.GH3336@logos.cnet>
Content-Type: text/plain
Date: Sat, 15 Jan 2005 08:43:26 +0100
Message-Id: <1105775006.6300.21.camel@laptopd505.fenrus.org>
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


> Please try this:
> 
> --- a/drivers/char/tty_io.c.orig	2005-01-14 21:11:58.002189784 -0200
> +++ b/drivers/char/tty_io.c	2005-01-14 21:12:53.743715784 -0200
> @@ -718,7 +718,7 @@
>  	wake_up_interruptible(&tty->write_wait);
>  }
>  
> -EXPORT_SYMBOL_GPL(tty_wakeup);
> +EXPORT_SYMBOL(tty_wakeup);
>  
when you merge this, please also add a comment that says "this is
actually a _GPL export but we can't do that in 2.4 for modutils compat
reasons"

To not loose that information and to make the status clear that people
shouldn't rely on these in binary modules

