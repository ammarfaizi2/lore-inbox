Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWFVWQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWFVWQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 18:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWFVWQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 18:16:25 -0400
Received: from mx0.towertech.it ([213.215.222.73]:17065 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1030420AbWFVWQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 18:16:24 -0400
Date: Fri, 23 Jun 2006 00:16:22 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] RTC: add rtc-ds1553 and rtc-ds1742 driver
Message-ID: <20060623001622.65db7c0f@inspiron>
In-Reply-To: <20060623.001927.74750182.anemo@mba.ocn.ne.jp>
References: <20060623.001927.74750182.anemo@mba.ocn.ne.jp>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 00:19:27 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> Add RTC drivers for the Dallas DS1553 and DS1742 RTC chip.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 please split this into two patches.

 
>  
> +config RTC_DRV_DS1553
> +	tristate "Dallas DS1553"
> +	depends on RTC_CLASS
> +	help
> +	  If you say yes here you get support for the
> +	  Dallas DS1553 timekeeping chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-ds1553.
> +
>  config RTC_DRV_DS1672
>  	tristate "Dallas/Maxim DS1672"
>  	depends on RTC_CLASS && I2C
> @@ -96,6 +106,16 @@ config RTC_DRV_DS1672
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-ds1672.
>  
> +config RTC_DRV_DS1742
> +	tristate "Dallas DS1742"
> +	depends on RTC_CLASS
> +	help
> +	  If you say yes here you get support for the
> +	  Dallas DS1742 timekeeping chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-ds1742.
> +


 on which systems will we likely find those twos? no extra
 depends?


> +static int ds1553_rtc_ioctl(struct device *dev, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (pdata->irq < 0)
> +		return -ENOIOCTLCMD;

 inappropriate -Exxx . maybe -ENODEV?.



-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

