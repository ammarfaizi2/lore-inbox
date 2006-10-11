Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWJKF63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWJKF63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWJKF63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:58:29 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:11152 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030280AbWJKF62
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:58:28 -0400
Message-ID: <452C87FB.6080302@drzeus.cx>
Date: Wed, 11 Oct 2006 07:58:19 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: philipl@overt.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 1/1] mmc: Add support for mmc v4 high speed mode
References: <21173.67.169.45.37.1159940502.squirrel@overt.org>    <452B3B00.5080209@drzeus.cx> <11208.67.169.45.37.1160545100.squirrel@overt.org>
In-Reply-To: <11208.67.169.45.37.1160545100.squirrel@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

philipl@overt.org wrote:
>> Pierre Ossman wrote:
>>     
>>> +	 	cmd.arg = 0x03B90100;
>>>
>>>       
>> I'd prefer some defines and shifts here. Also, this should be done at
>> init, not at select. The reason SD does it is that the spec says it
>> drops out of wide mode when it gets unselected.
>>     
>
> I have done this, but your suggestion somewhat contradicts your original
> suggestion to remove the defines. Essentially, my updated change restores
> the relevant definitions from my very first diff. I hope this is what you
> wanted. I prefer to have the #defines, so I'm not complaining.
>   

I know I can be a bit unclear some times, so feel free to be utterly
confused. :)

What I don't like is defines used for structure offsets where those
fields will be transformed into a normal C structure. I.e. the defines
will only be used once.

In this case, it's protocol opcodes, which are far more vital to have
readable. Currently we only use this in one place, but this will
probably grow. If I understand things correctly, switching to 4-bit and
8-bit bus also uses the SWITCH command?

> I also moved the explaination of the MMC_SWITCH argument to protocol.h I
> think it's worth documenting somewhere.
>   

A variant of this would be to do a macro. But this is fine as well.

> I have moved this work into the read_ext_csd function and renamed it
> process_ext_csd.
>
>   

Looks good.

>> A "max_dtr" int the mmc_ext_csd structure would be nicer here. And you
>> cannot do a kernel BUG because the card is broken. You should mark it as
>> dead.
>>     
>
> I have replaced storing the CARD_TYPE value with storing a dtr based on
> the CARD_TYPE which should achieve what you wanted. I've replaced the
> BUG with marking the card as bad.
>
>   

Very nice. This is a lot less confusing when someone else will be
mucking about with the clock selection routines (e.g. adding SDIO support).

> Finally, as pointed out by Jarkko, I added the missing MMC_CMD flags to
> the calls to MMC_SWITCH and MMC_SEND_EXT_CSD;
>   

Rgds
Pierre

