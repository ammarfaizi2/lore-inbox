Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbTBEANx>; Tue, 4 Feb 2003 19:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbTBEANx>; Tue, 4 Feb 2003 19:13:53 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:9222 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267610AbTBEANu>; Tue, 4 Feb 2003 19:13:50 -0500
Date: Wed, 5 Feb 2003 00:23:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59: drivers/media/video/bt819.c
Message-ID: <20030205002319.A10956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302041915490.4326-100000@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302041915490.4326-100000@master>; from fdavis@si.rr.com on Tue, Feb 04, 2003 at 07:18:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 07:18:44PM -0500, Frank Davis wrote:
> +
> +I2C_CLIENT_INSMOD;

Please don't use these magic macros, they will go away soon.
Use Rusty's new unified parameter support instead.

>  static struct i2c_driver i2c_driver_bt819 = {
> -	"bt819",		/* name */
> -	I2C_DRIVERID_BT819,	/* ID */
> -	I2C_DF_NOTIFY,
> -	bt819_probe,
> -	bt819_detach,
> -	bt819_command
> +        .name = "bt819",		/* name */
> +	.id = I2C_DRIVERID_BT819,	/* ID */
> +	.flags = I2C_DF_NOTIFY,
> +	.attach_adapter = bt819_probe,
> +	.detach_client = bt819_detach,
> +	.command = bt819_command

This is missing a .owner and the indentation looks strange.  It
should be something like:

static struct i2c_driver i2c_driver_bt819 = {
	.owner			= THIS_MODULE,
	.name			= "bt819",
	.id			= I2C_DRIVERID_BT819,
	.flags			= I2C_DF_NOTIFY,
	.attach_adapter		= bt819_probe,
	.detach_client		= bt819_detach,
	.command		= bt819_command,
};

