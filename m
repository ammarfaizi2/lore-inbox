Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVCWV14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVCWV14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVCWV14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:27:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17552 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261960AbVCWV1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:27:18 -0500
Subject: Re: repeat a function after fixed time period
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: sounak chakraborty <sounakrin@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503231551570.16734@chaos.analogic.com>
References: <20050323194308.8459.qmail@web53307.mail.yahoo.com>
	 <Pine.LNX.4.61.0503231522070.16567@chaos.analogic.com>
	 <1111610935.6306.97.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0503231551570.16734@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 22:27:10 +0100
Message-Id: <1111613230.12808.0.camel@laptopd505.fenrus.org>
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

On Wed, 2005-03-23 at 15:56 -0500, linux-os wrote:
> >> static void start_timer(void)
> >> {
> >>      if(!atomic_read(&info->running))
> >>      {
> >>          atomic_inc(&info->running);
> >
> > same race.
> 
> No such race at all.

here there is one; you use add_timer() which isn't allowed on running
timers, only mod_timer() is. So yes there is a race.


