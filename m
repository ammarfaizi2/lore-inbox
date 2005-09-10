Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVIJVU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVIJVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVIJVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:20:29 -0400
Received: from [85.21.88.2] ([85.21.88.2]:22509 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932315AbVIJVU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:20:27 -0400
Message-ID: <43234E0E.6000308@rbcmail.ru>
Date: Sun, 11 Sep 2005 01:20:14 +0400
From: Vital <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Underwood <basicmark@yahoo.com>
CC: Vital <vitalhome@rbcmail.ru>, David Brownell <david-b@pacbell.net>,
       linux-kernel@vger.kernel.org, dpervushin@ru.mvista.com
Subject: Re: [RFC][PATCH] SPI subsystem
References: <20050910115434.32450.qmail@web30303.mail.mud.yahoo.com>
In-Reply-To: <20050910115434.32450.qmail@web30303.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Underwood wrote:

>>Same as for suspend.
>>
>>And the basic idea anyway looks wrong and not
>>LDM'ish.
>>What if your driver
>>
>>+static struct device_driver spi_adapter_driver = {
>>+ .name = "spi_adapter",
>>+ .bus = &spi_bus_type,
>>+ .probe = spi_adapter_probe,
>>+ .remove = spi_adapter_remove,
>>+};
>>
>>presents also suspend/resume functions (what it
>>should have done anyway).
>>
>>Won't it be in a clash with your suspend/resume
>>technique?
>>    
>>
>
>Probably as I said above I don't know enough about
>this area yet. Maybe you could help me to do this
>correctly?
>
>  
>
I guess that it's basically wrong to use platform_device here. My POV is 
that a specific spi_device structure should be introduced here, just 
like pcidevice, for instance.

>>Also:
>>
>>Can you please specify what is the difference
>>between 'bus' and 'chip' 
>>in your model?
>>    
>>
>
>My current terminology is:
>
>spi adapter: A device that sits on an bus (platform,
>PCI, USB etc) and is a SPI master and/or slave (I
>haven't done any work on the slave part yet).
>
>spi device: A SPI device (e.g. a SPI eeprom) which one
>or more of are connected to a spi adapter.
>
>  
>
>>It's not clear to me how the following situation is
>>handled. Suppose you 
>>have two SPI 'busses' with same devices (for
>>instance, 2 SD card 
>>adapters) attached to different busses.
>>    
>>
>
>I don't understand your question here. You would have
>two instances of a SD card adapter. In sysfs it would
>look like:
>
>SD card 0
>/sys/devices/platform/spi-0/0-0000
>
>SD card 1
>/sys/devices/platform/spi-1/1-0002
>
>As far as the SD card driver is concernedit doesn't
>need to know which one its driving or even how many of
>them they are. The big advantage of using the LDM.
>  
>
Not sure if I get you right.
If we suspend bus 0, how does the SD driver get aware of that?

Vitaly
