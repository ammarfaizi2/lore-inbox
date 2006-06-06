Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWFFNao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWFFNao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWFFNan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:30:43 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:10678
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932168AbWFFNam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:30:42 -0400
Message-ID: <44858369.2040507@microgate.com>
Date: Tue, 06 Jun 2006 08:30:17 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: 2.6.17-rc5-mm3
References: <20060603232004.68c4e1e3.akpm@osdl.org>	<20060605230248.GE3963@redhat.com>	<20060605184407.230bcf73.rdunlap@xenotime.net>	<4484E06B.9020609@microgate.com>	<20060605190355.c1be6d75.rdunlap@xenotime.net> <20060605191951.1ee122d3.rdunlap@xenotime.net>
In-Reply-To: <20060605191951.1ee122d3.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Here's another version of the patch for you to consider.
> ---
> --- linux-2617-rc5mm3.orig/drivers/char/Kconfig
> +++ linux-2617-rc5mm3/drivers/char/Kconfig
> @@ -197,7 +197,6 @@ config ISI
>  config SYNCLINK
>  	tristate "SyncLink PCI/ISA support"
>  	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
> -	select HDLC if SYNCLINK_HDLC
>  	help
>  	  Driver for SyncLink ISA and PCI synchronous serial adapters.
>  	  These adapters are no longer in production and have
> @@ -205,7 +204,7 @@ config SYNCLINK
>  
>  config SYNCLINK_HDLC
>  	bool "Generic HDLC support for SyncLink driver"
> -	depends on SYNCLINK
> +	depends on SYNCLINK && HDLC
>  	help
>  	  Enable generic HDLC support for the SyncLink PCI/ISA driver.
>  	  Generic HDLC implements multiple higher layer networking

Now I remember that this was tried before and does
not work because SYNCLINK_HDLC is a bool and will
force the HDLC module to 'y' even if the synclink
driver is a 'm' which results in build errors.

I also tried 'depends on HDLC if SYNCLINK_HDLC'
in the config SYNCLINK section, but that causes a
cyclic dependency error. I suppose I could do that if I
remove 'depends on SYNCLINK' from config SYNCLINK_HDLC.
The only down side of that is the way the
SYNCLINK_HDLC option would be displayed.

I'll review this again to find the best solution.

-- 
Paul Fulghum
Microgate Systems, Ltd.
