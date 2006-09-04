Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWIDOtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWIDOtr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWIDOtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:49:47 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:44171 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751441AbWIDOtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:49:46 -0400
Message-ID: <44FC3D08.4030707@drzeus.cx>
Date: Mon, 04 Sep 2006 16:49:44 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060904141300.87440.qmail@web36712.mail.mud.yahoo.com>
In-Reply-To: <20060904141300.87440.qmail@web36712.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> --- Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
>   
>> I suppose it's a matter of taste, but personally I think the mere
>> mentioning of 'for' allows you to directly see that there is some kind
>> of looping involved. And it shouldn't be terribly complex:
>>
>> for (i = 0;i < 8;i++) {
>>     resp[i] = readw(addr + RESPONSE + (7 - i)*4) << 16;
>>     resp[i] |= readw(addr + RESPONSE + (6 - i)*4);
>> }
>>
>>     
>
> The actual loop is slightly different (there are 4 elements in cmd->resp):
>   

My bad. I got confused with your eight registers. ;)

> for (i=0; i < 4; i++) {
>       resp[i] = readl(addr + RESP + (7 - 2 * i) * 4) << 16;
>       resp[i] |= readl(addr + RESP + (6 - 2 * i) * 4);
> }
> As there are only 4 iterations it's not a lot of work to spare the compiler from address
> calculation. readl also seems more appropriate than readw, as resp is array of u32.
>
>   

I smell premature optimisation. Besides, the compiler is probably better
than you at unraveling that loop in an efficient manner anyway. You
should generally start with readable and obviously correct code and
optimise only when bottle necks are found. It keeps the code
maintainable in the long run.

As for the readw(), it was because you said only 16 of the 32 bits
contained anything of value.

> I changed the variable and function names to *_timeout, but left the macros as *_TO. This way,
> the macro name corresponds to the datasheet and the meaning is evident from context:
>
> writel(data_timeout, sock->addr + SOCK_MMCSD_DATA_TO);
>
>   

Great. That should allow even the most inexperienced reader to
understand the code.

> Additionally, I added defines for response and command types.
>
>   

Should be ready for merge then. We just need to sort out exactly where
to put the files. And Russell probably wants his say in this as well. ;)

Rgds
Pierre

