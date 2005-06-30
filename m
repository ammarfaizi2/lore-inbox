Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVF3JUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVF3JUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVF3JUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:20:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62700 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262913AbVF3JUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:20:02 -0400
Subject: Re: [PATCH] deinline sleep/delay functions
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, vda@ilport.com.ua,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050630021111.35aaf45f.akpm@osdl.org>
References: <200506300852.25943.vda@ilport.com.ua>
	 <20050630095246.A13407@flint.arm.linux.org.uk>
	 <20050630021111.35aaf45f.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 11:19:48 +0200
Message-Id: <1120123189.3181.28.camel@laptopd505.fenrus.org>
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


> > There are a number of compile-time checks that your patch has removed
> > which catch such things, and as such your patch is not acceptable.
> > Some architectures have a lower threshold of acceptability for the
> > maximum udelay value, so it's absolutely necessary to keep this.
> 
> It removes that check from x86 - other architectures retain it.
> 
> I don't recall seeing anyone trigger the check,

I do ;) Esp in vendor out of tree crap. It's a good compile time
diagnostic so the junk code doesnt' hit mainline but gets fixed first.

>
>  and it hardly seems worth
> adding a "few kb" to vmlinux for it?

but it can be fixed to not add that few kb while retaining the checking
value. All that needs is for it to be a define that calls the worker
function. Eg the check gets optimized out and all that remains is the
call to the worker function that does the actual delay.


