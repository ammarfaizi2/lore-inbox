Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVAKEAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVAKEAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVAKEAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:00:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38602 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262426AbVAKD44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:56:56 -0500
Message-ID: <41E34E6F.70002@pobox.com>
Date: Mon, 10 Jan 2005 22:56:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE PATCH] net/sb1000: replace nicedelay() with ssleep()
References: <20050110164703.GD14307@nd47.coderock.org> <20050111003908.GJ9186@us.ibm.com>
In-Reply-To: <20050111003908.GJ9186@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
> @@ -475,7 +467,7 @@ sb1000_reset(const int ioaddr[], const c
>  	udelay(1000);
>  	outb(0x0, port);
>  	inb(port);
> -	nicedelay(60000);
> +	ssleep(1);
>  	outb(0x4, port);
>  	inb(port);
>  	udelay(1000);
> @@ -537,7 +529,7 @@ sb1000_activate(const int ioaddr[], cons
>  	const unsigned char Command0[6] = {0x80, 0x11, 0x00, 0x00, 0x00, 0x00};
>  	const unsigned char Command1[6] = {0x80, 0x16, 0x00, 0x00, 0x00, 0x00};
>  
> -	nicedelay(50000);
> +	ssleep(1);
>  	if ((status = card_send_command(ioaddr, name, Command0, st)))
>  		return status;
>  	if ((status = card_send_command(ioaddr, name, Command1, st)))
> @@ -944,7 +936,7 @@ sb1000_open(struct net_device *dev)
>  	/* initialize sb1000 */
>  	if ((status = sb1000_reset(ioaddr, name)))
>  		return status;
> -	nicedelay(200000);
> +	ssleep(1);
>  	if ((status = sb1000_check_CRC(ioaddr, name)))
>  		return status;


Your conversion of nicedelay() -> ssleep() values is imprecise.

The author clearly intended the values to be different, right?

	Jeff


