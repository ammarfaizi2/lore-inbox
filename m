Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVIEJ7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVIEJ7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 05:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVIEJ7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 05:59:41 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:36311 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750707AbVIEJ7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 05:59:41 -0400
Message-ID: <431C170A.7070208@dev.rtsoft.ru>
Date: Mon, 05 Sep 2005 13:59:38 +0400
From: Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Vitaly Wool <vitalhome@rbcmail.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] custom PM support for 8250
References: <43159011.3060206@rbcmail.ru> <20050831122622.B1118@flint.arm.linux.org.uk>
In-Reply-To: <20050831122622.B1118@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

I tried the patch provided by Vitaly Wool. And it works correctly. And 
now I'm successful with the PM support for my own serial8250 driver. Are 
you planning to commit the Vitlaly's changes into the mainstream? I 
guess it'll be helpful for the other people too. What I want is to know 
whether this changes will be supported by the Community or not. It's 
important for the project I'm worin on, cause I'm planning to push it 
into Open Source ;)

Thanks,
Grigory.

Russell King wrote:

>On Wed, Aug 31, 2005 at 03:10:09PM +0400, Vitaly Wool wrote:
>  
>
>>please find the patch that allows passing the pointer to custom power 
>>management routine (via platform_device) to 8250 serial driver.
>>Please note that the interface to the outer world (i. e. exported 
>>functions) remained the same.
>>    
>>
>
>I'd rather change the structure passed via the platform device to
>something like:
>
>struct platform_serial_data {
>	void	(*pm)(struct uart_port *port, unsigned int state, unsigned int old);
>	int	nr_ports;
>	struct plat_serial8250_port *ports;
>};
>
>which also eliminates the empty plat_serial8250_port terminator from
>all the serial8250 platform devices (which appears to have caused some
>folk problems.)
>
>It does mean that a set of 8250 ports (grouped by each platform device)
>have a common power management method - which seems a logical restriction.
>
>  
>

