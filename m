Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbUDFC21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 22:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbUDFC21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 22:28:27 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:38281 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263366AbUDFC2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 22:28:25 -0400
Message-ID: <40721629.6000202@blueyonder.co.uk>
Date: Tue, 06 Apr 2004 03:30:01 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm1
References: <40715203.8070004@blueyonder.co.uk> <20040405153423.GK31152@smtp.west.cox.net>
In-Reply-To: <20040405153423.GK31152@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Apr 2004 02:28:26.0292 (UTC) FILETIME=[D72A4F40:01C41B7E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

>On Mon, Apr 05, 2004 at 01:33:07PM +0100, Sid Boyce wrote:
>
>  
>
>>CC      arch/x86_64/kernel/setup.o
>>arch/x86_64/kernel/setup.c:258: warning: initialization from 
>>incompatible pointer type
>>arch/x86_64/kernel/setup.c: In function `setup_arch':
>>arch/x86_64/kernel/setup.c:411: error: `saved_command_line' undeclared 
>>(first use in this function)
>>arch/x86_64/kernel/setup.c:411: error: (Each undeclared identifier is 
>>reported only once
>>arch/x86_64/kernel/setup.c:411: error: for each function it appears in.)
>>make[1]: *** [arch/x86_64/kernel/setup.o] Error 1
>>make: *** [arch/x86_64/kernel] Error 2
>>-------------------------------------------------------------------
>>strlcpy(saved_command_line, early_command_line, COMMAND_LINE_SIZE);
>>    
>>
>
>Yes, something like this is needed, on top of Rusty's early_param patch:
>diff -puN include/linux/init.h~fix-rusty include/linux/init.h
>--- linux-2.6.5-rc3/include/linux/init.h~fix-rusty	2004-04-02 08:30:50.600483739 -0700
>+++ linux-2.6.5-rc3-trini/include/linux/init.h	2004-04-02 08:30:50.604482833 -0700
>@@ -143,6 +143,7 @@ extern void setup_arch(void);
> 
> /* Relies on saved_command_line being set */
> void __init parse_early_options(void);
>+extern char saved_command_line[];
> #endif /* __ASSEMBLY__ */
> 
> /**
>
>Assuming that is, that arch/x86_64/kernel/setup.c has #include
><linux/init.h>, which I assume it does.
>
>  
>
That fixes it.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

