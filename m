Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267290AbSIRQ3U>; Wed, 18 Sep 2002 12:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267297AbSIRQ3U>; Wed, 18 Sep 2002 12:29:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267290AbSIRQ3S>;
	Wed, 18 Sep 2002 12:29:18 -0400
Message-ID: <3D88AAEA.2010009@mandrakesoft.com>
Date: Wed, 18 Sep 2002 12:33:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cranford <ac9410@attbi.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] 2.5.36 i2c new adapter i2c-pport driver
References: <Pine.LNX.4.44.0209180205270.358-200000@home1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> +static int bit_pport_init(void)
> +{
> +	if (!request_region((base+2),1, "i2c (PPORT adapter)")) {
> +		return -ENODEV;	
> +	} else {
> +
> +		/* test for PPORT adap. 	*/
> +	
> +
> +		PortData=inb(base+2);
> +		PortData= (PortData SET_SDA) SET_SCL;
> +		outb(PortData,base+2);				
> +
> +		if (!(inb(base+2) | 0x06)) {	/* SDA and SCL will be high	*/
> +			DEBINIT(printk("i2c-pport.o: SDA and SCL was low.\n"));
> +			return -ENODEV;
> +		} else {
> +		
> +			/*SCL high and SDA low*/
> +			PortData = PortData SET_SCL CLR_SDA;
> +			outb(PortData,base+2);	
> +			udelay(400);


use schedule_timeout() instead of udelay() since you're in process 
context.  otherwise, looks ok...

