Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVIFGV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVIFGV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVIFGV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:21:56 -0400
Received: from [85.21.88.2] ([85.21.88.2]:18844 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932414AbVIFGVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:21:55 -0400
Message-ID: <431D35A5.1010201@rbcmail.ru>
Date: Tue, 06 Sep 2005 10:22:29 +0400
From: Vitaly Wool <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] custom PM support for 8250
References: <43159011.3060206@rbcmail.ru> <20050831122622.B1118@flint.arm.linux.org.uk> <431C170A.7070208@dev.rtsoft.ru>
In-Reply-To: <431C170A.7070208@dev.rtsoft.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

what I'd suggest is to separate the changes that allow to provide PM 
callbacks and generic changes in the interface/structures as the latter 
will result in changing a lot of code that uses 8250 serial driver, 
otherwise that code will stop working.
Namely, is it posible to have the first patch I've sent for 8250 in 
place first?
I'll continue to work on 8250 PM/platform_serial_data changes then.

Vitaly

Grigory Tolstolytkin wrote:

> Hi Russel,
>
> I tried the patch provided by Vitaly Wool. And it works correctly. And 
> now I'm successful with the PM support for my own serial8250 driver. 
> Are you planning to commit the Vitlaly's changes into the mainstream? 
> I guess it'll be helpful for the other people too. What I want is to 
> know whether this changes will be supported by the Community or not. 
> It's important for the project I'm worin on, cause I'm planning to 
> push it into Open Source ;)
>
> Thanks,
> Grigory.
>
> Russell King wrote:
>
>> On Wed, Aug 31, 2005 at 03:10:09PM +0400, Vitaly Wool wrote:
>>  
>>
>>> please find the patch that allows passing the pointer to custom 
>>> power management routine (via platform_device) to 8250 serial driver.
>>> Please note that the interface to the outer world (i. e. exported 
>>> functions) remained the same.
>>>   
>>
>>
>> I'd rather change the structure passed via the platform device to
>> something like:
>>
>> struct platform_serial_data {
>>     void    (*pm)(struct uart_port *port, unsigned int state, 
>> unsigned int old);
>>     int    nr_ports;
>>     struct plat_serial8250_port *ports;
>> };
>>
>> which also eliminates the empty plat_serial8250_port terminator from
>> all the serial8250 platform devices (which appears to have caused some
>> folk problems.)
>>
>> It does mean that a set of 8250 ports (grouped by each platform device)
>> have a common power management method - which seems a logical 
>> restriction.
>>
>>  
>>
>

