Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265749AbUFOQXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbUFOQXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUFOQXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:23:09 -0400
Received: from holomorphy.com ([207.189.100.168]:48551 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265749AbUFOQXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:23:07 -0400
Date: Tue, 15 Jun 2004 09:23:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Patrick Finnegan <pat@computer-refuge.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: Compile problems on alpha: 2.6.6, 2.6.7-rc2
Message-ID: <20040615162301.GZ1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Patrick Finnegan <pat@computer-refuge.org>,
	linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
References: <200406151100.25284.pat@computer-refuge.org> <20040615160709.GY1444@holomorphy.com> <20040615201648.A28597@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615201648.A28597@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 09:07:09AM -0700, William Lee Irwin III wrote:
>> Could you try to locate it with scripts/reference_discard.pl, and if that
>> fail, post your .config (preferably compressed) so I can try to debug this
>> on my alphas?

On Tue, Jun 15, 2004 at 08:16:48PM +0400, Ivan Kokshaysky wrote:
> This is known problem - missing __devexit_p() wrapper in serial PnP
> driver.
> Ivan.
> --- 2.6/drivers/serial/8250_pnp.c	Mon May 10 06:31:59 2004
> +++ linux/drivers/serial/8250_pnp.c	Mon May 10 22:47:45 2004
> @@ -437,7 +437,7 @@ static struct pnp_driver serial_pnp_driv
>  	.name		= "serial",
>  	.id_table	= pnp_dev_table,
>  	.probe		= serial_pnp_probe,
> -	.remove		= serial_pnp_remove,
> +	.remove		= __devexit_p(serial_pnp_remove),
>  };
>  static int __init serial8250_pnp_init(void)

Thanks for handling this for me.

-- wli
