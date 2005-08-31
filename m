Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVHaLkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVHaLkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVHaLkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:40:14 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:59598 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932428AbVHaLkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:40:12 -0400
Message-ID: <4315973E.7040103@rbcmail.ru>
Date: Wed, 31 Aug 2005 15:40:46 +0400
From: Vitaly Wool <vitalhome@rbcmail.ru>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org,
       Grigory Tolstolytkin <gtolstolytkin@dev.rtsoft.ru>
Subject: Re: [PATCH] custom PM support for 8250
References: <43159011.3060206@rbcmail.ru> <20050831122622.B1118@flint.arm.linux.org.uk>
In-Reply-To: <20050831122622.B1118@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, that's also something I was thinking of, but I wasn't sure enough 
in this radical change :)
Anyway, I do agree that this way looks better than the current one.
So, if you don't object against other changes (say, the suggested 
approach to set uart->pm), I can proceed with the changes you suggest 
and work it out to the new patch. ;)

Best regards,
   Vitaly

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

