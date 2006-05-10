Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWEJWdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWEJWdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWEJWdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:33:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:34857 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751520AbWEJWdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:33:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rZlu6uxM4y4O60e3c0xJ/RLI1ncmSBqMSCYCNzPZi3QTtXL5ZYru6tnHX0knh0nMPC1WPqpYHhJN7gPU49/cOOoz9ImTP2jq63WULtgaqOKfyqyg+uIj+oMv03oZrSY50v6T+VvH56JO9def8cq/iZRHnt813chFtntZBX7XHBE=
Date: Thu, 11 May 2006 02:32:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Scott Alfter <salfter@ssai.us>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new driver for TLV320AIC23B
Message-ID: <20060510223212.GG7237@mipter.zuzino.mipt.ru>
References: <44626150.9050804@ssai.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44626150.9050804@ssai.us>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 02:55:28PM -0700, Scott Alfter wrote:
>                                                 the attached patch adds a
> driver for the TI TLV320AIC23B audio codec.  It implements analog audio capture
> at 32, 44.1, and 48 kHz (16-bit stereo).  The hardware is capable of more (it
> supports more sample rates and includes analog output), but in its current
> form, the driver works well with ivtv.

> --- linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.c
> +++ linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.c

> +static int tlv320aic23b_attach(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	struct i2c_client *client;
> +	struct tlv320aic23b_state *state;
> +
> +	/* Check if the adapter supports the needed features */
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return 0;
> +
> +	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
> +	if (client == 0)
> +		return -ENOMEM;

client is a pointer, so

	if (client == NULL)

or

	if (!client)

> +	snprintf(client->name, sizeof(client->name) - 1, "tlv320aic23b");

	snprintf(buf, sizeof(buf), ...)

is idiomatic.

> +static int tlv320aic23b_detach(struct i2c_client *client)
> +{
> +	int err;
> +
> +	err = i2c_detach_client(client);
> +	if (err) {
> +		return err;
> +	}

Preferred style is

	if (err)
		return err;

> diff -Nupr -X dontdiff linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c

> --- linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c
> +++ linux-2.6.16-gentoo-r1/drivers/media/video/tlv320aic23b.mod.c

This file is generated and you have outdated dontdiff. Use "-X Documentation/dontdiff".

