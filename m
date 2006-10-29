Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWJ2JcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWJ2JcD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWJ2JcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:32:03 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:10899 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932128AbWJ2JcB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:32:01 -0500
Message-ID: <4544750F.4000301@drzeus.cx>
Date: Sun, 29 Oct 2006 10:31:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
CC: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
Subject: Re: [patch 2/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
References: <20061020164914.012378000@localhost.localdomain> <20061020165134.378993000@localhost.localdomain>
In-Reply-To: <20061020165134.378993000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Aguiar wrote:
> +int mmc_key_instantiate(struct key *key, const void *data, size_t datalen)
>   

static

> +int mmc_key_match(const struct key *key, const void *description)
>   

static

> +void mmc_key_destroy(struct key *key)
>   

static

> @@ -335,6 +403,15 @@ static int __init mmc_init(void)
>  		ret = class_register(&mmc_host_class);
>  		if (ret)
>  			bus_unregister(&mmc_bus_type);
> +#ifdef	CONFIG_MMC_PASSWORDS
> +		else {
> +			ret = register_key_type(&mmc_key_type);
> +			if (ret) {
> +				class_unregister(&mmc_host_class);
> +				bus_unregister(&mmc_bus_type);
> +			}
> +		}
> +#endif
>  	}
>  	return ret;
>  }
>   

We're starting to get a bit of code duplication here. Perhaps an error
handling section at the end of the function would be better.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

