Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVAZXxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVAZXxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVAZXwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:52:13 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:36882 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262210AbVAZT4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:56:13 -0500
Date: Wed, 26 Jan 2005 20:56:19 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <20050126205619.4c0b41fa.khali@linux-fr.org>
In-Reply-To: <41F6F1D5.90601@mvista.com>
References: <41F6F1D5.90601@mvista.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> Marvell makes a line of host bridge for PPC and MIPS systems.  On
> those  bridges is an i2c controller.  This patch adds the driver for
> that i2c  controller.
> 
> Please let me know if you see any problems with this patch.

I do not feel qualified for a full review of this code. However, I
noticed the following minor issues:

> +config I2C_MV64XXX
> +	tristate "Marvell mv64xxx I2C Controller"
> +	depends on I2C && MV64X60

&& EXPERIMENTAL?

> diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
> --- a/include/linux/i2c-id.h	2005-01-25 18:15:24 -07:00
> +++ b/include/linux/i2c-id.h	2005-01-25 18:15:24 -07:00
> @@ -200,6 +200,7 @@
>  
>  #define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
>  #define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
> +#define I2C_ALGO_MV64XXX 0x170000       /* Marvell mv64xxx i2c ctlr     */

0x170000 is reserved within the legacy i2c project for an USB algorithm,
and 0x180000 for virtual busses. Could you please use 0x190000 instead,
so as to avoid future collisions?

> -#define MV64340_I2C_SLAVE_ADDR                                      0xc000
> -#define MV64340_I2C_EXTENDED_SLAVE_ADDR                             0xc010
> -#define MV64340_I2C_DATA                                            0xc004
> -#define MV64340_I2C_CONTROL                                         0xc008
> -#define MV64340_I2C_STATUS_BAUDE_RATE                               0xc00C
> -#define MV64340_I2C_SOFT_RESET                                      0xc01c
> +#define	MV64XXX_I2C_CTLR_NAME					"mv64xxx i2c"
> +#define MV64XXX_I2C_OFFSET					    0xc000
> +#define MV64XXX_I2C_REG_BLOCK_SIZE				    0x0020

You have a tab instead of space before MV64XXX_I2C_CTLR_NAME, it seems.
Also, you want to align the numerical values using only tabs, no space.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
