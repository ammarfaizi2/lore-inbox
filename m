Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTKRISO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 03:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTKRISO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 03:18:14 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:50136 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262427AbTKRISH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 03:18:07 -0500
Message-ID: <27804138.1069143411125.JavaMail.ngmail@webmail06.arcor-online.net>
Date: Tue, 18 Nov 2003 09:16:51 +0100 (CET)
From: thomas.mey3r@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Re: Re: Hard lock on 2.6-test9 (More Info)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: : 193.150.166.43, 193.150.166.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is really strange. 
irq5 is shared between yenta_socket driver, uhci_hcd and ohci1394.
loading the modules ohci1394 and uhci_hcd -> system run stable.
loading the modules yenta_socket and uhci_hcd -> system run stable.
loading all 3 modules-> systems hangs.
there are no devices connected to usb controller and to 1394 controller.

with kind regards
Thomas Meyer

----- Original Nachricht ----
Von:     Dan Creswell <dan@dcrdev.demon.co.uk>
An:      Thomas Meyer <thomas.mey3r@arcor.de>
Datum:   17.11.2003 22:48
Betreff: Re: Hard lock on 2.6-test9 (More Info)

Thanks for the info - certainly seems to help to remove it in my case as 
well but I've still got a few problems - another culprit hiding 
somewhere....

Cheers,

Dan.

Thomas Meyer wrote:

> Hi,
>
> i have got the same type of hardlock. i first thought it was the 
> yenta_socket driver that causes this error, but it seems to be the 
> ohci1394 driver.
>
> on my computer irq 5 is shared between yenta_socket driver, uhci_hcd 
> and ohci1394. when not loading module ohci1394 system runs stable
>
> with kind regards
> Thomas Meyer
>
> Dan Creswell wrote:
>
>> Thanks for the advice Linus - I'll give that a go.
>>
>> As an aside, I've tried both the nvidia drivers and the 
>> out-of-the-box Xfree ones with the same results (2.4 stable, 2.6 not).
>>
>> I'll get back to the list with more info once I've done the testing.
>>
>> Thanks again for your time,
>>
>> Dan.
>>
>> Linus Torvalds wrote:
>>
>>> On Mon, 17 Nov 2003, Dan Creswell wrote:
>>>  
>>>
>>>> 17:       5267       3420   IO-APIC-level  ohci1394, Intel ICH4, 
>>>> nvidia
>>>>
>>>> When I boot X under kernel 2.6, I see the additional nvidia 
>>>> interrupt path as per the 2.4 output (which was taken whilst I was 
>>>> running X).
>>>>
>>>> But, within seconds of this additional interrupt assignment 
>>>> appearing, 2.6 dies a horrible death whilst 2.4 just keeps on rolling.
>>>>   
>>>
>>>
>>>
>>> Two potential reasons:
>>> - the nvidia driver is just broken under 2.6.x
>>> - or a driver bug in ohci1394 _or_ the Intel ICH4 driver, which 
>>> could   become unhappy if they see a lot of interrupts that aren't 
>>> for them   (maybe it uncovers a race).
>>>
>>> You can test for the latter by just disabling those drivers, and 
>>> seeing what happens. If it still breaks, it's nvidia. If the crashes 
>>> stop, it might _still_ be nvidia, but at that point somebody else 
>>> might start being interested in it.
>>>
>>>         Linus
>>>
>>>
>>>
>>>  
>>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
>







