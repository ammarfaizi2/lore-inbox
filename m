Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWERUuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWERUuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 16:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWERUuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 16:50:50 -0400
Received: from rtr.ca ([64.26.128.89]:9629 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751398AbWERUut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 16:50:49 -0400
Message-ID: <446CDE26.8090504@rtr.ca>
Date: Thu, 18 May 2006 16:50:46 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Zang Roy-r61911 <tie-fei.zang@freescale.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Alexandre.Bounine@tundra.com,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
       Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
 c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com>
In-Reply-To: <446C9219.4080300@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
>> On Thu, 2006-05-18 at 12:03 +0800, Zang Roy-r61911 wrote:
..
>>> @@ -1567,13 +1570,18 @@ static void mv5_read_preamp(struct mv_ho
>>>  static void mv5_enable_leds(struct mv_host_priv *hpriv, void __iomem
>> *mmio)
>>>  {
>>>       u32 tmp;
>>> -
>>> +#ifndef CONFIG_PPC
>>>       writel(0, mmio + MV_GPIO_PORT_CTL);
>>> +#endif
>>
>> You'll have to do better here too... I don't wee why when compiled on
>> PPC, this driver should "magically" not clear those bits... At the very
>> least, you should test the machine type if you want to do something
>> specific to your platform, but first, you'll have to convince Jeff why
>> this change has to be done in the first place and if there is a better
>> way to handle it.
> 
> Correct...  it does seem some bugs were found, but #ifdef powerpc is 
> certainly out of the question.  We want the driver to work without 
> ifdefs on all platforms.

Yup.  I have a powerpc platform here with PCI-X, and a PCI-X Marvell card
to try in it.  So I'll pick up these changes and try to integrate them a
little more nicely in my internal updated driver, and then pass it on to Jeff.

Cheers
