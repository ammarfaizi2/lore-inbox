Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVHOWAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVHOWAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVHOWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:00:13 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:16390 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964999AbVHOWAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:00:12 -0400
Date: Tue, 16 Aug 2005 00:00:54 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Nathan Lutchansky <lutchann@litech.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/5] remove attach_adapter from i2c hwmon drivers
Message-Id: <20050816000054.31543cb9.khali@linux-fr.org>
In-Reply-To: <20050815175342.GC24959@litech.org>
References: <20050815175106.GA24959@litech.org>
	<20050815175342.GC24959@litech.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

> Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/atxp1.c
> ===================================================================
> --- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/atxp1.c
> +++ linux-2.6.13-rc6+gregkh/drivers/hwmon/atxp1.c
> @@ -44,7 +44,6 @@ static unsigned short normal_i2c[] = { 0
>  
>  I2C_CLIENT_INSMOD_1(atxp1);
>  
> -static int atxp1_attach_adapter(struct i2c_adapter * adapter);
>  static int atxp1_detach_client(struct i2c_client * client);
>  static struct atxp1_data * atxp1_update_device(struct device *dev);
>  static int atxp1_detect(struct i2c_adapter *adapter, int address, int
>  kind);
> @@ -53,7 +52,8 @@ static struct i2c_driver atxp1_driver = 
>  	.owner		= THIS_MODULE,
>  	.name		= "atxp1",
>  	.flags		= I2C_DF_NOTIFY,
> -	.attach_adapter = atxp1_attach_adapter,
> +	.address_data	= &addr_data,
> +	.detect_client	= atxp1_detect,
>  	.detach_client	= atxp1_detach_client,
>  };
>  
> @@ -251,11 +251,6 @@ static ssize_t atxp1_storegpio2(struct d
>  static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2,
>  atxp1_storegpio2);
>  
>  
> -static int atxp1_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	return i2c_probe(adapter, &addr_data, &atxp1_detect);
> -};
> -
>  static int atxp1_detect(struct i2c_adapter *adapter, int address, int
>  kind) {
>  	struct i2c_client * new_client;
> Index: linux-2.6.13-rc6+gregkh/drivers/hwmon/ds1621.c
> ===================================================================
> --- linux-2.6.13-rc6+gregkh.orig/drivers/hwmon/ds1621.c
> +++ linux-2.6.13-rc6+gregkh/drivers/hwmon/ds1621.c
> @@ -80,7 +80,6 @@ struct ds1621_data {
>  	u8 conf;			/* Register encoding, combined */
>  };
>  
> -static int ds1621_attach_adapter(struct i2c_adapter *adapter);
>  static int ds1621_detect(struct i2c_adapter *adapter, int address,
>  			 int kind);
>  static void ds1621_init_client(struct i2c_client *client);
> @@ -93,7 +92,8 @@ static struct i2c_driver ds1621_driver =
>  	.name		= "ds1621",
>  	.id		= I2C_DRIVERID_DS1621,
>  	.flags		= I2C_DF_NOTIFY,
> -	.attach_adapter	= ds1621_attach_adapter,
> +	.address_data	= &addr_data,
> +	.detect_client	= ds1621_detect,
>  	.detach_client	= ds1621_detach_client,
>  };
>  
> @@ -178,12 +178,6 @@ static DEVICE_ATTR(temp1_min, S_IWUSR | 
>  static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
>  set_temp_max);
>  
>  
> -static int ds1621_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	return i2c_probe(adapter, &addr_data, ds1621_detect);
> -}
> -
> -/* This function is called by i2c_probe */
>  int ds1621_detect(struct i2c_adapter *adapter, int address,
>                    int kind)
>  {

I noticed that these two drivers do not properly define their .class to
I2C_CLASS_HWMON. I understand that doing so doesn't belong to this
patch, but having an additional patch to apply on top it fixing the
problem would be great. Can you do that? Or I will, it doesn't really
matter (the patch should be really straightforward now.)

Thanks,
-- 
Jean Delvare
