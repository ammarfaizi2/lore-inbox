Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVBUT2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVBUT2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 14:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVBUT1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 14:27:10 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:49162 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262080AbVBUTRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 14:17:32 -0500
Date: Mon, 21 Feb 2005 20:17:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Adam 'dredzik' Kuczynski" <dredzik@ekg2.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Maarten Deprez <maartendeprez@users.sourceforge.net>
Subject: Re: GL520SM Sensor Chip driver fix
Message-Id: <20050221201730.5f880556.khali@linux-fr.org>
In-Reply-To: <20050220150604.GA658@lotus.ma.gda.pl>
References: <20050220150604.GA658@lotus.ma.gda.pl>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

> I've been recently trying to get my lmsensors working under
> 2.6.9, and i've found this:
> 
> http://seclists.org/lists/linux-kernel/2005/Feb/2856.html
> http://lkml.org/lkml/2005/2/11/90
> 
> kernel patch for gl520 chip, but after applying it kernel refused to
> compile. So I've fixed it using gl518sm module source code and I want
> to share the results of my work with you. I hope that it will be
> useful.
> (...)
> +static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
> +static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };

Ranges were taken apart in 2.6.10-rc2, and Maarten's patch was meant for
linux-2.6.11-rc3-mm2, so it comes to no surprise that you had to
reintroduce them when backporting to 2.6.9.

>  static int gl520_attach_adapter(struct i2c_adapter *adapter)
>  {
> - if (!(adapter->clRD_DATA))
> - goto exit;
> + if (!(adapter->class & I2C_CLASS_HWMON))
> + return 0;
> + return i2c_detect(adapter, &addr_data, gl520_detect);
> +}
>  
> +static int gl520_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> + struct i2c_client *new_client;
> + struct gl520_data *data;
> + int err = 0;
> + 
> + if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> + I2C_FUNC_SMBUS_WORD_DATA))
> + goto exit;
> +							     

I suspect that a problem happened when you retrieved the original patch
and it somehow got corrupted, because everything you restore here is
already correct in Maarten's patch.

As a summary, Maarten's patch was just fine and doesn't need any update.

Thanks,
-- 
Jean Delvare
