Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWDGPOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWDGPOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWDGPOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:14:15 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:60579 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964790AbWDGPOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:14:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s1xyemykei9CKq1ErrtGPHqgmOpi6mX+JP195qd9mx7KK36GoJuZKh/H/dJwLmHh9eIB8EgDPFTLuc9dLOEKg2s/sMwVUuUGwAx1raxVumm6TiSWajJ6WCbqc2Eea3t7v3o8S309ckWMXsuLocopbdfXjMUs3/3P3JtVkOrKNVI=
Message-ID: <443681D3.8000805@gmail.com>
Date: Fri, 07 Apr 2006 23:14:27 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filessytem Events Reporter V2
References: <4433C456.7010708@gmail.com> <20060407062428.GA31351@2ka.mipt.ru> <44361F39.4020501@gmail.com> <20060407094732.GA13235@2ka.mipt.ru> <443638D8.2010800@gmail.com> <20060407102602.GA27764@2ka.mipt.ru>
In-Reply-To: <20060407102602.GA27764@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov 写道:
> On Fri, Apr 07, 2006 at 06:03:04PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
>   
>>>> Can you explain why there is such a big difference between 
>>>> netlink_unicast and netlink_broadcast?
>>>>    
>>>>         
>>> Netlink broadcast clones skbs, while unicasting requires the whole new
>>> one.
>>>  
>>>       
>> No, I also use clone to send skb, so they should have the same overhead.
>>     
>
> I missed that.
> After rereading fsevent_send_to_process() I do not see how original skb
> is freed though.
>   
I'm considering how to free it, because cloned skbs share data with 
original skb, so this case is special,
I try to clarify the logic of kfree_skb.
>   
>>>>> Btw, you need some rebalancing of the per-cpu queues, probably in
>>>>> keventd, since CPUs can go offline and your messages will stuck foreve
>>>>> there.
>>>>>
>>>>>      
>>>>>           
>>>> Does keventd not do it? if so, keventd should be modified.
>>>>    
>>>>         
>>> How does keventd know about your own structures?
>>> You have an per-cpu object, but your keventd function gets object 
>>>       
>> >from running cpu, not from any other cpus.
>>     
>
>   

