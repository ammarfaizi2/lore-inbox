Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWHKPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWHKPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHKPp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:45:59 -0400
Received: from mail.oxtel.com ([195.219.3.158]:22280 "EHLO oxtel.com")
	by vger.kernel.org with ESMTP id S932167AbWHKPp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:45:58 -0400
Message-ID: <44DCA631.9040505@miranda.com>
Date: Fri, 11 Aug 2006 16:45:53 +0100
From: Chris Pringle <chris.pringle@miranda.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serial driver 8250 hangs the kernel with the VIA Nehemiah...
References: <44DC6524.4000401@miranda.com> <1155297728.24077.52.camel@localhost.localdomain>
In-Reply-To: <1155297728.24077.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: chris.pringle
X-Server: VPOP3 Enterprise V2.3.0e - Registered
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-08-11 am 12:08 +0100, ysgrifennodd Chris Pringle:
>   
>>> Unlikely as it would affect both. More likely would be that the ISA bus
>>> clock is generated off the PCI bus clock and you have one of the
>>> multipliers wrong or too high for the board.
>>>   
>>>       
>> Thats interesting, but wouldn't this produce strange side affects for 
>> the 2.4 kernel as well? 2.4 works fine on both VIAs and Celerons.
>>     
>
> That I wonder about. The power management stuff and some other things
> that matter for timing are different however.
>   
We don't use any kind of power management (not compiled in) as our 
systems are always on... Is there any timing related options in the 
kernel config you'd recommend I look at?
>   
>> I'll give the interrupt disabling a go...
>>     
>
> Its just a guess but if you have low latency stuff, you have pre-empt
> enabled and you actually depend upon the semantics of inb_p/outb_p
> giving delays reliably then I'm not convinced are guarantees are strong
> enough
>
> Specifically we don't have any pre-empt protection between the I/O delay
> and the I/O so we could violate it as we don't have pre-empt disables in
> inb_p/outb_p and if your CPU context switch is quick enough it could
> trigger a problem.
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   
Okay, I've tried disabling both preemption and interrupts (separately, 
and together) and its still hanging...

I've had the Celeron systems being thrashed for well over 4 days now, 
and they are working fine... Why would the VIA system be any different? 
They have a slightly different CPU speed (the VIAs are 1000MHz, whereas 
the Celerons are 850MHz), but I would expect them to be fully compatible 
otherwise... unless its a microcode bug?

Any more ideas? Do you think writing to port 0x80 could be causing issues?

Thanks,
Chris

-- 

______________________________
Chris Pringle
Software Engineer

Miranda Technologies Ltd.
Hithercroft Road
Wallingford
Oxfordshire OX10 9DG
UK

Tel. +44 1491 820206
Fax. +44 1491 820001
www.miranda.com

