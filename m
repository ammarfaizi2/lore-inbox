Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318323AbSG3Oxq>; Tue, 30 Jul 2002 10:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSG3Oxq>; Tue, 30 Jul 2002 10:53:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1292 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318323AbSG3Oxp>;
	Tue, 30 Jul 2002 10:53:45 -0400
Message-ID: <3D46A944.9080401@mandrakesoft.com>
Date: Tue, 30 Jul 2002 10:57:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Abraham vd Merwe <abraham@2d3d.co.za>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: questions about network device drivers
References: <20020730161505.A23281@crystal.2d3d.co.za> <1028044126.6726.35.camel@irongate.swansea.linux.org.uk> <20020730164853.A24348@crystal.2d3d.co.za>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abraham vd Merwe wrote:
> Hi Alan!
> 
> 
>>>hard_start_xmit() method
>>>========================
>>>
>>>when should this function return 0 and when should it return 1 and in which
>>>cases should it do netif_stop_queue() and/or free the dev_kfree_skb() ?
>>
>>0 - OK
>>1 - I am busy, give me it later.
>>
>>If you return 1 be sure to netif_stop_queue. The netif_wake_queue will
>>continue transmission
> 
> 
> In both cases, should I free the sk_buff structure or only if I return 0?
> Also, if I understand you correctly, I should _only_ call netif_stop_queue()
> if the function fails to transmit the packet?
> 
> What about cases where the packet will always fail, e.g. the frame length is
> bigger than what the device supports. I take it in those cases I should
> return 0, but should I call netif_stop_queue() as well?



free it if you are returning zero.  But of course, after the card has 
handled the packet.

If you set your MTU correctly, you shouldn't get frames larger than 
proper length.

netif_stop_queue and netif_start_queue and netif_wake_queue are your 
queue management tools.  _only_ enable the queue when there is room for 
more packets.

	Jeff


