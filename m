Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWHKLI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWHKLI1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 07:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWHKLI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 07:08:27 -0400
Received: from mail.oxtel.com ([195.219.3.158]:26118 "EHLO oxtel.com")
	by vger.kernel.org with ESMTP id S1750973AbWHKLI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 07:08:26 -0400
Message-ID: <44DC6524.4000401@miranda.com>
Date: Fri, 11 Aug 2006 12:08:20 +0100
From: Chris Pringle <chris.pringle@miranda.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Serial driver 8250 hangs the kernel with the VIA Nehemiah...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: chris.pringle
X-Server: VPOP3 Enterprise V2.3.0e - Registered
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-08-11 am 09:52 +0100, ysgrifennodd Chris Pringle:
>  
>> on it. However, when the port is receiving a lot of data, it has the
>> tendency to either get corrupted data, or to crash the kernel.
>>     
>
> What do the crash traces look like
>   

Sorry - the kernel hangs, not crashes. There is no output whatsoever 
after the hang - SysRq doesn't work, but Numlock does.
>  
>> The "inb" as it is will sometimes return bad data - I'm guessing this
>> is due to ISA bus instability... Anyway I changed it to "inb_p" which
>> cured the corruption problem, but has introduced another issue - it
>> hangs the kernel.
>>     
>
> Maybe you need to have a chat with your hardware guys. Certainly if
> inb_p makes a difference you've got hardware not software side problems.
>   
Perhaps - I'm in discussion with them at the moment, but neither our, 
nor their department have managed to come up with an answer yet.
>  
>> Interestingly, it only hangs on systems with a VIA Nehemiah CPU, the
>> Intel Celerons seem to work fine. Could this be a problem with writing
>> to that dreaded port 0x080 within inb_p?
>>     
>
> Unlikely as it would affect both. More likely would be that the ISA bus
> clock is generated off the PCI bus clock and you have one of the
> multipliers wrong or too high for the board.
>   
Thats interesting, but wouldn't this produce strange side affects for 
the 2.4 kernel as well? 2.4 works fine on both VIAs and Celerons.
>  
>> it only occur on the VIA chip and not the Celeron? I don't think the
>> problem is there when the low latency patches are not applied - so I'm
>> thinking it's probably a timing problem of some sort.
>>     
>
> That bit is interesting. Something really off the wall to try - disable
> interrupts around the inb_p(), especially if you are using pre-emption
> and let me know what happens.
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>   
I'll give the interrupt disabling a go...

Thanks Alan.
Chris.

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

