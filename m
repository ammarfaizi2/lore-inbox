Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVHHMdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVHHMdN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 08:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVHHMdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 08:33:12 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:35798 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1750845AbVHHMdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 08:33:12 -0400
Subject: Re: [PATCH] DVB: lgdt330x frontend: some bug fixes & add lgdt3303
	support
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-dvb-maintainer@linuxtv.org,
       Mac Michaels <wmichaels1@earthlink.net>,
       Michael Krufky <mkrufky@m1k.net>
In-Reply-To: <42F6A294.90300@linuxtv.org>
References: <42F6A294.90300@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 08 Aug 2005 09:33:06 -0300
Message-Id: <1123504387.17427.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This should't be applied to 2.6.13. It does contain a hack at V4L code,
since mute_tda9887 is implemented outside tda9887.c module and could
potentially cause troubles since there are some work to provide it on a
correct way.
	 It should be applied to -mm and go to mainstream only after provided a
correct implementation.

Mkrufky,
	Please avoid trying to submit yet experimental patches to mainstream.

Mauro.

Em Dom, 2005-08-07 às 20:08 -0400, Michael Krufky escreveu:
> For 2.6.13, if possible.  Patch generated against 2.6.13-rc6
> 
> anexo documento em texto simples (lgdt330x-structure-update.patch)

> diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt330x.c linux/drivers/media/dvb/frontends/lgdt330x.c
> +
> +#ifdef MUTE_TDA9887
> +static int i2c_write_ntsc_demod (struct lgdt330x_state* state, u8 buf[2])
> +{
> +	struct i2c_msg msg =
> +		{ .addr = 0x43,
> +		  .flags = 0, 
> +		  .buf = buf,
> +		  .len = 2 };
> +	int err;
> +
> +	if ((err = i2c_transfer(state->i2c, &msg, 1)) != 1) {
> +			printk(KERN_WARNING "lgdt330x: %s error (addr %02x <- %02x, err = %i)\n", __FUNCTION__, msg.buf[0], msg.buf[1], err);
> +		if (err < 0)
> +			return err;
> +		else
> +			return -EREMOTEIO;
> +	}
> +	return 0;
> +}
> +
> +static void fiddle_with_ntsc_if_demod(struct lgdt330x_state* state)
> +{
> +	// Experimental code
> +	u8 buf0[] = {0x00, 0x20};
> +	u8 buf1[] = {0x01, 0x00};
> +	u8 buf2[] = {0x02, 0x00};
> +
> +	i2c_write_ntsc_demod(state, buf0);
> +	i2c_write_ntsc_demod(state, buf1);
> +	i2c_write_ntsc_demod(state, buf2);
> +}
> +#endif


