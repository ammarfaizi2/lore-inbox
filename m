Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbUL0PNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUL0PNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUL0PNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:13:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46790 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261896AbUL0PN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:13:29 -0500
Date: Mon, 27 Dec 2004 16:06:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Twibright I2C2P driver
Message-ID: <20041227150618.GG1043@openzaurus.ucw.cz>
References: <20041227131840.GC3045@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227131840.GC3045@beton.cybernet.src>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have just published Twibright I2C2P:
> 
>     * I2C interface (adaptor) for parallel port
>     * Free technology electronics device
>     * Bidirectional: Both SDA and SCL are bidirectional
>     * Optically isolated
>     * Powered from parallel port
>     * Driver for Linux kernel 

Its quite short. Did you forget to attach actual c source? Or is it
this simple?

> @@ -140,7 +141,11 @@
>  	.getscl		= parport_getscl,
>  	.udelay		= 60,
>  	.mdelay		= 60,
> -	.timeout	= HZ,
> +	.timeout	= (HZ+99)/100,
> +			/* This is 10ms. Parport adapter of type 6 may be
> +			 * powered down which introduces 90sec delay to
> +			 * machine boot. I consider 10ms to be sufficient for

90msec?

> +			 * the parport adapter timeout. --Clock */

Avoid signing comments like this. Neccessary info is
in bitkeeper logs anyway.
> @@ -38,6 +38,9 @@
>  	struct lineop getsda;
>  	struct lineop getscl;
>  	struct lineop init;
> +	struct lineop init2;	/* Added by Clock                    */

and this.


				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

