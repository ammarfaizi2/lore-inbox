Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265750AbUFOQ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUFOQ0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUFOQ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:26:14 -0400
Received: from ned.cc.purdue.edu ([128.210.189.24]:44417 "EHLO
	ned.cc.purdue.edu") by vger.kernel.org with ESMTP id S265750AbUFOQ0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:26:12 -0400
From: Patrick Finnegan <pat@computer-refuge.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Compile problems on alpha: 2.6.6, 2.6.7-rc2
Date: Tue, 15 Jun 2004 11:26:04 -0500
User-Agent: KMail/1.5.4
Cc: Russell King <rmk@arm.linux.org.uk>
References: <200406151100.25284.pat@computer-refuge.org> <20040615160709.GY1444@holomorphy.com> <20040615201648.A28597@jurassic.park.msu.ru>
In-Reply-To: <20040615201648.A28597@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406151126.04228.pat@computer-refuge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 June 2004 11:16, Ivan Kokshaysky wrote:
> On Tue, Jun 15, 2004 at 09:07:09AM -0700, William Lee Irwin III wrote:
> > Could you try to locate it with scripts/reference_discard.pl, and
> > if that fail, post your .config (preferably compressed) so I can
> > try to debug this on my alphas?
>
> This is known problem - missing __devexit_p() wrapper in serial PnP
> driver.
>
> Ivan.
>
> --- 2.6/drivers/serial/8250_pnp.c	Mon May 10 06:31:59 2004
> +++ linux/drivers/serial/8250_pnp.c	Mon May 10 22:47:45 2004
> @@ -437,7 +437,7 @@ static struct pnp_driver serial_pnp_driv
>  	.name		= "serial",
>  	.id_table	= pnp_dev_table,
>  	.probe		= serial_pnp_probe,
> -	.remove		= serial_pnp_remove,
> +	.remove		= __devexit_p(serial_pnp_remove),
>  };
>
>  static int __init serial8250_pnp_init(void)

Nifty, that works perfectly.  Thanks.

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
