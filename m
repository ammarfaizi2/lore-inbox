Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVCWUzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVCWUzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVCWUv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:51:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13199 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262924AbVCWUtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:49:00 -0500
Subject: Re: repeat a function after fixed time period
From: Arjan van de Ven <arjan@infradead.org>
To: linux-os@analogic.com
Cc: sounak chakraborty <sounakrin@yahoo.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503231522070.16567@chaos.analogic.com>
References: <20050323194308.8459.qmail@web53307.mail.yahoo.com>
	 <Pine.LNX.4.61.0503231522070.16567@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 21:48:54 +0100
Message-Id: <1111610935.6306.97.camel@laptopd505.fenrus.org>
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


> 
> This kernel code should do just fine.
> 
> 
> 
> struct INFO {
>      struct timer_list timer;            // For test timer
>      atomic_t running;                   // Timer is running
>      };
> 
> //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
> //
> //   This stops the timer. This must NOT be called with a spin-lock
> //   held.
> //
> static void stop_timer()
> {
>      if(atomic_read(&info->running))
>      {
>          atomic_dec(&info->running);

this is a race.

>          if(info->timer.function)
>              del_timer(&info->timer);

you probably want del_timer_sync() here.


> static void start_timer(void)
> {
>      if(!atomic_read(&info->running))
>      {
>          atomic_inc(&info->running);

same race.


