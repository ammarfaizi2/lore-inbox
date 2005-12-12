Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVLLQ4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVLLQ4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVLLQ4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:56:49 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:51914 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751273AbVLLQ4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:56:48 -0500
Message-ID: <439DABEC.8000301@ru.mvista.com>
Date: Mon, 12 Dec 2005 19:57:16 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git] SPI core refresh
References: <20051130195053.713ea9ef.vwool@ru.mvista.com> <200511301327.02053.david-b@pacbell.net>
In-Reply-To: <200511301327.02053.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW:

David Brownell wrote:

>+How do I write an "SPI Master Controller Driver"?
>+-------------------------------------------------
>+An SPI controller will probably be registered on the platform_bus; write
>+a driver to bind to the device, whichever bus is involved.
>+
>+The main task of this type of driver is to provide an "spi_master".
>+Use spi_alloc_master() to allocate the master, and class_get_devdata()
>+to get the driver-private data allocated for that device.
>+
>+	struct spi_master	*master;
>+	struct CONTROLLER	*c;
>+
>+	master = spi_alloc_master(dev, sizeof *c);
>+	if (!master)
>+		return -ENODEV;
>+
>+	c = class_get_devdata(&master->cdev);
>  
>
Here's an example of a mixture of two approaches which leads to 
misleading code.
If you want to have abstract spi_master, then you have to disallow (or 
at least discourage) explicit usage of spi_master fields, otherwise 
'kzalloc is your friend' and you don't have toadd this spi_alloc_master 
API as it's basically useless IMHO.

As opposed to this, we use abstract handles where possible (i. e. for 
spi_message).
I'd have understood your dissatisfaction with that if you were 
consistently following the approach 'expose everything, forget the 
extensibility, viva lightwieghtness', but you're mixing things.

Vitaly
