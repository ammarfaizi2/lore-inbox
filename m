Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262544AbSITNQp>; Fri, 20 Sep 2002 09:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbSITNQp>; Fri, 20 Sep 2002 09:16:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262544AbSITNQo>;
	Fri, 20 Sep 2002 09:16:44 -0400
Message-ID: <3D8B20CD.80403@mandrakesoft.com>
Date: Fri, 20 Sep 2002 09:21:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: ALTPATCH: 8139cp: LinkChg support
References: <1032487254.247.7.camel@tank> 	<3D8ABCEF.9060207@mandrakesoft.com> <1032494983.247.70.camel@tank>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio wrote:
>>+	int advertise, lpa, media, duplex;
> 
> 
> 	Shouldn't advertise and lpa be either "unsigned short" or u16?

No, they don't need to be.



>>+	lpa = mii->mdio_read(mii->dev, mii->phy_id, MII_LPA);
>>+
>>+	/* figure out media and duplex from advertise and LPA values */
>>+	media = mii_nway_result(lpa & advertise);
> 
>         ^^^^^^^^^^^^^^^^^^^^^^^ 
> 
> 	mii_nway_result returns a "unsigned int", so media also doesn't look
> good.

mii_nway_result _really_ returns a small bitmapped value, so it doesn't 
matter.


>>+	duplex = (media & (ADVERTISE_100FULL | ADVERTISE_10FULL)) ? 1 : 0;
> 
> 
> 	Or we could do
> 
> 	duplex = (media & ADVERTISE_FULL) ? 1 : 0;


True.  I forgot about that constant...

	Jeff



