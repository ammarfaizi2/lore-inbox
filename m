Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUFBOMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUFBOMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUFBOMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:12:30 -0400
Received: from [213.239.201.226] ([213.239.201.226]:48538 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262902AbUFBOMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:12:12 -0400
Message-ID: <40BDE1BB.3030605@shadowconnect.com>
Date: Wed, 02 Jun 2004 16:18:35 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com> <40BD95EB.40506@shadowconnect.com> <40BDD4C9.5070602@pobox.com> <40BDDAD9.5070809@shadowconnect.com> <20040602134603.GA8589@havoc.gtf.org>
In-Reply-To: <20040602134603.GA8589@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
>>>>>My preferred approach would be:  consider that the hardware does not 
>>>>>need the entire 0x8000000-byte area mapped.  Plain and simple.
>>>>>This is a "don't do that" situation, and that renders the other 
>>>>>questions moot :)  You should only be mapping what you need to map.
>>>>Okay, i'll let try it out with only 64MB.
>>>Why do you need 64MB, even?  :)
>>I don't know how much space i need :-D But why does the device set the 
>>size to 128MB then?
> Devices often export things you don't care about, such as direct access
> to internal chip RAM.
> Look through the driver that figure out the maximum value that the
> driver actually _uses_.  There is no need to guess.

Okay, i've looked at it, but i don't think i could simply use less 
space, because (if i understand the I2O spec right :-D) the controller 
returns me a address inside this window, where i could write the I2O 
message. So i ask the controller, where do you want my request, then he 
tells me a address...

If i only ioremap 64MB, and the controller tells me write at 80MB, i'm 
in deep trouble :-D

>> 	size = dev->resource[i].end-dev->resource[i].start+1;	
> You should be using pci_resource_start() and pci_resource_len()
> to obtain this information.

Yep, thanks, but a patch for this is already send :-)

Best regards,



Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
