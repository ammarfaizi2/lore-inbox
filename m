Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992784AbWKATwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992784AbWKATwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992786AbWKATwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:52:14 -0500
Received: from outmx002.isp.belgacom.be ([195.238.5.52]:42940 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S2992784AbWKATwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:52:13 -0500
Date: Wed, 1 Nov 2006 20:52:08 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: ggaleotti@interfree.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] watchdog driver for Digital-Logic MSM-P5XEN PC104 unit
Message-ID: <20061101195208.GC7056@infomag.infomag.iguana.be>
References: <20061017123440.4321.qmail@community1.interfree.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017123440.4321.qmail@community1.interfree.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriele,

> A simple watchdog driver for Digital-Logic's MSM-P5XEN PC104 unit.
> The watchdog is a LTC1232 controlled by a single I/O port @ 0x1037.
> The watchdog must be refreshed (writing a single byte) to the device
> at least every 600 msecs (which is a little of overhead, but PC104
> industrial applications requires a high degree of safety/reliability.)

I was looking at your code and have a question:
> +static void
> +wdt_ping(void)
> +{
> +	/*
> +	 * Clear-pulse trailing edge scheduling.
> +	 *
> +	 * We use mod_timer() rather than add_timer() because a timer could
> +	 * be already activated.
> +	 * kernel/timer.c:
> +	 * "... since add_timer() cannot modify an already running timer."
> +	 */
> +	mod_timer(&wdt_timer, jiffies + (HZ / 10));
> +
> +	wdt_disable();
> +}

Shouldn't this be wdt_enable();?
Please clarify.

Thanks,
Wim.

