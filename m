Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWBPRAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWBPRAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWBPRAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:00:05 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19722 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932150AbWBPRAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:00:04 -0500
Date: Thu, 16 Feb 2006 16:59:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [RFC] mmc: add OMAP driver
Message-ID: <20060216165957.GC29443@flint.arm.linux.org.uk>
Mail-Followup-To: Carlos Aguiar <carlos.aguiar@indt.org.br>,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Pierre Ossman <drzeus-list@drzeus.cx>
References: <43F48BCA.8010608@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F48BCA.8010608@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One additional comment on the patch which I missed, and has shown to
be a related cause of problems on a different host controller...

On Thu, Feb 16, 2006 at 10:27:22AM -0400, Carlos Aguiar wrote:
> +static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_request *req)
> +{
> +	int timeout;
> +	u16 reg;
> +
> +	/* Convert ns to clock cycles by assuming 20MHz frequency
> +	 * 1 cycle at 20MHz = 500 ns
> +	 */
> +	timeout = req->data->timeout_clks + req->data->timeout_ns / 500;
> +
> +	/* Some cards require more time to do at least the first read operation */
> +	timeout = timeout << 4;

This is a hack because you got your calculation above wrong.  If you
assume a fast clock, the timeout will be too slow for a slower clock.
If you do the calculation correctly and you won't need such hacks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
