Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVLTSBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVLTSBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVLTSBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:01:54 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:3507 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750766AbVLTSBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:01:53 -0500
Message-ID: <43A84730.9020602@ru.mvista.com>
Date: Tue, 20 Dec 2005 21:02:24 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI:  async message handing library update
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051215151948.497d703b.vwool@ru.mvista.com> <200512181059.14301.david-b@pacbell.net>
In-Reply-To: <200512181059.14301.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David --

just a cuple of notes here and below...

General one: how is it supposed to set SPI bus clock in this model? I 
guess that the only option is to set it in txrx_*.
That is not optimal since it means setting clock for each transfer which 
is not an optimal solution, better have a function (bitbang->set_clock 
or whatever) )to set clock per message.

>	if (!spi->max_speed_hz)
>		spi->max_speed_hz = 500 * 1000;
>
>	/* nsecs = max(50, (clock period)/2), be optimistic */
>	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
>	if (cs->nsecs < 50)
>		cs->nsecs = 50;
>  
>
Suggest not to hardcode values here.

>			/* set up default clock polarity, and activate chip */
>			if (!chipselect) {
>				bitbang->chipselect(spi, 1);
>				ndelay(nsecs);
>  
>
Suggest special enum/define for chipselect value.

>			/* protocol tweaks before next transfer */
>			if (t->delay_usecs)
>				udelay(t->delay_usecs);
>  
>
Suggest nsecs here as well.

Generic note: haven't tested that with DMA, will have more comments 
prolly...
Another one: I just feel comfortabel with using 'bitbang' term for the 
variety of SPI stuff which this library suits.

Vitaly
