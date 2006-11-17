Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932935AbWKQQEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbWKQQEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWKQQEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:04:50 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:19468 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932935AbWKQQEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:04:49 -0500
Date: Fri, 17 Nov 2006 16:04:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anderson Briglia <anderson.briglia@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: Re: [patch 2/6] [RFC] Add MMC Password Protection (lock/unlock) support V6
Message-ID: <20061117160439.GB28514@flint.arm.linux.org.uk>
Mail-Followup-To: Anderson Briglia <anderson.briglia@indt.org.br>,
	"Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>,
	linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
	ext David Brownell <david-b@pacbell.net>,
	Tony Lindgren <tony@atomide.com>,
	"Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
	"Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
References: <455DB2D2.5020502@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455DB2D2.5020502@indt.org.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 09:02:10AM -0400, Anderson Briglia wrote:
> @@ -366,15 +434,33 @@ static int __init mmc_init(void)
>  	if (ret == 0) {
>  		ret = class_register(&mmc_host_class);
>  		if (ret)
> -			bus_unregister(&mmc_bus_type);
> +			goto error;
> +	}
> +#ifdef	CONFIG_MMC_PASSWORDS
> +	else {
> +		ret = register_key_type(&mmc_key_type);
> +		if (ret)
> +			goto error_mmc_pwd;

This is obviously untested - you won't get to register the key type if
bus_register() succeeds.  You actually only register it if bus_register()
fails.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
