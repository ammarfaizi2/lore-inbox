Return-Path: <linux-kernel-owner+w=401wt.eu-S1750731AbWLQTQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWLQTQO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 14:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWLQTQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 14:16:14 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:1496 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750731AbWLQTQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 14:16:14 -0500
X-Greylist: delayed 12022 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 14:16:13 EST
Date: Sun, 17 Dec 2006 20:16:12 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [PATCH] Make lm70_remove a __devexit function
Message-Id: <20061217201612.1c7ba106.khali@linux-fr.org>
In-Reply-To: <20061210192151.GA32262@linux-mips.org>
References: <20061210192151.GA32262@linux-mips.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

On Sun, 10 Dec 2006 19:21:51 +0000, Ralf Baechle wrote:
> Saves a few bytes on the module.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> index 6ba8473..7eaae38 100644
> --- a/drivers/hwmon/lm70.c
> +++ b/drivers/hwmon/lm70.c
> @@ -126,7 +126,7 @@ out_dev_reg_failed:
>  	return status;
>  }
>  
> -static int __exit lm70_remove(struct spi_device *spi)
> +static int __devexit lm70_remove(struct spi_device *spi)
>  {
>  	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
>  

You're not actually saving memory with this change, as __devexit is
resolved to either __exit (i.e. nothing changes) or nothing (i.e. the
code is now always compiled in.) This is a bugfix though as currently
the code may be striped away while the driver still holds a pointer to
it.

Good catch, applied (with a different header comment), thanks.

-- 
Jean Delvare
