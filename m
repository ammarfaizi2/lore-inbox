Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSIOXLw>; Sun, 15 Sep 2002 19:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSIOXLw>; Sun, 15 Sep 2002 19:11:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44043 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318288AbSIOXLv>;
	Sun, 15 Sep 2002 19:11:51 -0400
Message-ID: <3D8514C0.1030705@mandrakesoft.com>
Date: Sun, 15 Sep 2002 19:16:16 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 8/9]Four new i2c drivers and __init/__exit cleanup to
 i2c
References: <Pine.LNX.4.44.0209151844090.7637-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> --- linux/drivers/i2c/i2c-adap-ibm_ocp.c.orig	2002-09-13 01:16:58.000000000 -0400
> +++ linux-2.5.34/drivers/i2c/i2c-adap-ibm_ocp.c	2002-09-15 01:13:57.000000000 -0400
> @@ -90,6 +90,14 @@
>  static wait_queue_head_t iic_wait[IIC_NUMS];
>  static int iic_pending;
>  
> +#ifdef MODULE
> +static
> +#else
> +extern
> +#endif
> +	int __init iic_ibmocp_init(void);
> +static void __exit iic_ibmocp_exit(void);
> +

ug, don't add this crap to the codebase...



> --- linux/drivers/i2c/i2c-algo-8xx.c.orig	2002-09-13 01:17:07.000000000 -0400
> +++ linux-2.5.34/drivers/i2c/i2c-algo-8xx.c	2002-09-13 01:47:42.000000000 -0400
> @@ -51,6 +51,13 @@
>  int cpm_scan = 1;
>  int cpm_debug = 0;
>  
> +#ifdef MODULE
> +static
> +#else
> +extern
> +#endif
> +	int __init i2c_algo_8xx_init (void);
> +

likewise [repeated many times]


