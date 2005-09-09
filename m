Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbVIIBuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbVIIBuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 21:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVIIBuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 21:50:44 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:22444 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S965233AbVIIBun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 21:50:43 -0400
Message-ID: <4320EC45.1080108@stesmi.com>
Date: Fri, 09 Sep 2005 03:58:29 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathias Adam <a2@adamis.de>
CC: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: Re: [PATCH] 8250.c: Fix to make 16C950 UARTs work
References: <20050909013144.GA6660@adamis.de>
In-Reply-To: <20050909013144.GA6660@adamis.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mathias Adam wrote:
> Currently serial8250_set_termios() refuses to program a baud rate larger
> than uartclk/16. However the 16C950 supports baud rates up to uartclk/4.
> This worked already with Linux 2.4 so the biggest part of this patch was
> simply taken from there and adapted to 2.6.
> -	unsigned int baud, quot;
> +	unsigned int baud, quot, max_baud;
                                 ^^^^^^^^
> -	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
> +	MAX_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
        ^^^^^^^^

Did you even compile test this?

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFDIOxFBrn2kJu9P78RAnG3AJ9EJKl6q4Q4+jXRdMifvmOEdO+HewCfUPd8
T2qQREDAgUq2C7j9yfaPemQ=
=hGK0
-----END PGP SIGNATURE-----
