Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSKAC1I>; Thu, 31 Oct 2002 21:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265252AbSKAC1I>; Thu, 31 Oct 2002 21:27:08 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:44560 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264706AbSKAC1H>; Thu, 31 Oct 2002 21:27:07 -0500
Date: Thu, 31 Oct 2002 23:33:07 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, ac9410@attbi.com, dperks@ibm.net
Subject: Re: [PATCH] 2.5.45 : drivers/media/video/saa7111.c
Message-ID: <20021101023306.GF17128@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
	ac9410@attbi.com, dperks@ibm.net
References: <Pine.LNX.4.44.0210312217170.963-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210312217170.963-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 31, 2002 at 10:20:45PM -0500, Frank Davis escreveu:
> Hello all,
>   This converts the saa7111 driver's i2c api from i2c-old --> i2c . This 
> one was never converted (for some reason). Please review. 
> Regards,
> Frank
> 
>  static struct i2c_driver i2c_driver_saa7111 = {
>  	"saa7111",		/* name */
> -	I2C_DRIVERID_VIDEODECODER,	/* ID */
> -	I2C_SAA7111, I2C_SAA7111 + 1,
> -
> -	saa7111_attach,
> +	I2C_DRIVERID_SAA7111,	/* ID */
> +	I2C_DF_NOTIFY,
> +	saa7111_probe,
>  	saa7111_detach,
>  	saa7111_command
>  };

Could you please use the named initializers in C99?

like

static struct i2c_driver i2c_driver_saa7111 = {
	.name	= "saa7111",
	.id	= I2C_DRIVERID_VIDEODECODER,
.
.
.

> +static struct i2c_client client_template = {
> +	"saa7111_client",
> +	-1,
> +	0,
> +	0,
> +	NULL,
> +	&i2c_driver_saa7111
> +};

ditto, and in this one you can kill all the 0 and the NULL, as it will
be initialized to null if you omit its initializations.

- Arnaldo
