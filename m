Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVCBH5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVCBH5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 02:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVCBH5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 02:57:42 -0500
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:26261 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262214AbVCBH5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 02:57:40 -0500
Message-ID: <422571DA.7070401@mech.kuleuven.ac.be>
Date: Wed, 02 Mar 2005 08:57:14 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Possible AMD8111e free irq issue
References: <20050228140742.A29902@lumumba.luc.ac.be> <42255B8E.3010507@pobox.com>
In-Reply-To: <42255B8E.3010507@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jeff Garzik wrote:

>> diff -uprN linux-2.6.11-rc5-bk2/drivers/net/amd8111e.c 
>> linux-2.6.11-rc5-bk2-pi/drivers/net/amd8111e.c
>> --- linux-2.6.11-rc5-bk2/drivers/net/amd8111e.c    2005-02-28 
>> 13:44:46.000000000 +0100
>> +++ linux-2.6.11-rc5-bk2-pi/drivers/net/amd8111e.c    2005-02-28 
>> 13:45:09.000000000 +0100
>> @@ -1381,6 +1381,8 @@ static int amd8111e_open(struct net_devi
>>  
>>      if(amd8111e_restart(dev)){
>>          spin_unlock_irq(&lp->lock);
>> +        if (dev->irq)
>> +            free_irq(dev->irq, dev);
>>          return -ENOMEM;
>
>
> Yes, this is a needed fix.  Thanks.

Should the release of the irq happen before or after unlocking the 
spinlock? I wasn't really
sure about it.

With friendly regards,
Takis

-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/

