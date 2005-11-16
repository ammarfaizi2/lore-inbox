Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVKPHlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVKPHlc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVKPHlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:41:32 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:10021 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030203AbVKPHlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:41:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=n/OcDDCjb/wMSP2hSabckERNBrgSyBOkpOPSlQQYzaBtnUw6b0tMNAidZEOOFetPxJ4UL6zwHw0rceJ6fe2sA+7GcHMglLzFlnV9cEnnDRbvhdK5KPNjvgcX/isV40NMdxXoJ4V7Ysv/rkiM8DxqPQ2HcdzwesvGwXNvy2oNkuQ=
Message-ID: <437AE21D.9040501@gmail.com>
Date: Wed, 16 Nov 2005 15:39:09 +0800
From: Tony <tony.uestc@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MOD_INC_USE_COUNT
References: <437347B5.6080201@gmail.com> <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com> <43735766.3070205@gmail.com> <20051113102930.GA16973@linux-mips.org> <43795C71.6070108@gmail.com> <20051115153444.GB15733@linux-mips.org>
In-Reply-To: <20051115153444.GB15733@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Tue, Nov 15, 2005 at 11:56:33AM +0800, Tony wrote:
> 
> 
>>>Not strange at all.  The typical network driver is implemented using
>>>pci_register_driver which will set the owner filed of the driver's struct
>>>driver which then is being used for internal reference counting.  Other
>>>busses or line disciplines (SLIP, PPP, AX.25 ...) need to do the equivalent
>>>or the kernel will believe reference counting isn't necessary and it's
>>>ok to unload the module at any time.
>>>
>>>In which driver did you hit this problem?
>>>
>>> Ralf
>>>
>>
>>I have a radio connected to host using ethernet. I'm writing a radio 
>>driver that masquerade radio as a NIC. when the module is loaded, I just 
>>register_netdev a net_device struct, while unregister_netdev at module 
>>cleanup.
> 
> 
> register_netdev / unregister_netdev don't deal with the .owner stuff, so
> your bug isn't there.  If your NIC is a PCI card, it should register it's
> driver through pci_register_driver which would deal with the necessary
> reference counting.  If it's implemented as a platform device you're
> presumably calling driver_register() before platform_device_register() and
> driver_register() would do the necessary magic for you.  If you're using a
> different bus it may have it's own variant of driver_register which you
> should call.  If you don't, you have a problem :-)
> 
>   Ralf
> 
That is indeed my problem. My driver is none of types of drivers, it's 
just a software virtual one. I think I should mimic the way SLIP handle 
it. thank a loooooooot!!!

Tony
