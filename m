Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933689AbWKQQJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933689AbWKQQJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933692AbWKQQJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:09:04 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:61968 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933689AbWKQQJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:09:02 -0500
Date: Fri, 17 Nov 2006 16:08:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: Re: [patch 3/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Message-ID: <20061117160855.GC28514@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
	ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
References: <455DB31C.40907@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DB31C.40907@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:03:24AM -0400, Anderson Briglia wrote:
> @@ -101,7 +104,7 @@ mmc_start_request(struct mmc_host *host,
>  	pr_debug("%s: starting CMD%u arg %08x flags %08x\n",
>  		 mmc_hostname(host), mrq->cmd->opcode,
>  		 mrq->cmd->arg, mrq->cmd->flags);
> -
> +	

Random whitespace damage; please remove.

> +	do {
> +		/* we cannot use "retries" here because the
> +		 * R1_LOCK_UNLOCK_FAILED bit is cleared by subsequent reads 
> to

#include <std-mail-wrapping-complaint.h>

> +error:
> +	mmc_deselect_cards(card->host);

You don't need to deselect the card prior to releasing the host; in
fact in single card systems, it's better that you don't.  That way
you avoid generating lots of select card messages.

> +	mmc_card_release_host(card);
> +out:
> +	kfree(data_buf);
> +
> +	return err;
> +}
> +
> +//EXPORT_SYMBOL(mmc_lock_unlock);

Either export it or don't.  There's no point in having a commented out
export.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
