Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWC0RLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWC0RLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWC0RLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:11:12 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:10507 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1750717AbWC0RLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:11:11 -0500
Date: Mon, 27 Mar 2006 19:11:11 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-mm1 2/3] rtc: m41t00 driver cleanup
Message-Id: <20060327191111.f7b057cb.khali@linux-fr.org>
In-Reply-To: <20060324012137.GD9560@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012137.GD9560@mag.az.mvista.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> This patch does some cleanup to the m41t00 i2c/rtc driver including:
> - use BCD2BIN/BIN2BCD instead of BCD_TO_BIN/BIN_TO_BCD
> - use strlcpy instead of strncpy
> - some whitespace cleanup

Looks overall good, except:

> @@ -214,6 +208,7 @@ m41t00_detach(struct i2c_client *client)
>  
>  static struct i2c_driver m41t00_driver = {
>  	.driver = {
> +		.owner	= THIS_MODULE,
>  		.name	= M41T00_DRV_NAME,
>  	},
>  	.id		= I2C_DRIVERID_STM41T00,

i2c_add_driver sets the owner for you, so it was omitted here on
purpose.

I'll drop that change before pushing the patch to Greg, no need to
resend.

Thanks,
-- 
Jean Delvare
