Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVAPMXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVAPMXB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 07:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVAPMXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 07:23:01 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:33446 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262491AbVAPMWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 07:22:50 -0500
Message-ID: <41EA5C8D.8070407@drzeus.cx>
Date: Sun, 16 Jan 2005 13:22:37 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Richard Purdie <rpurdie@rpsys.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com>
In-Reply-To: <41E7DD5E.5070901@f2s.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:

>
> I've been getting errors replying to you but had no alternative 
> address to use. perhaps you could mail me from another account ?
>
Afraid everything gets routed to the same account in the end anyway. I 
checked the logs and the problem is that your mail server has a HELO 
that differs from its IP (outmail.freedom2surf.net vs. 194.106.33.237). 
Reverse is ok, but forward points to 194.106.56.14.

>> * Moved SD-specific commands to a separate section in the header so 
>> they are more easily distinguished.
>
>
> I had been meaning to move all the c code referencing SD to a seperate 
> sd.c file such that it could be compiled optionally on top of MMC. at 
> the time it wasnt mature enough to be worth it, but that may be worth 
> revisiting now.
>
I've had the same idea. But I think it will be difficult since we need 
som funky logic during init. Perhaps a model where each mode 
(MMC/SD/SDIO) each gets their turn trying to find something on the bus. 
But this would require a rather large rewrite of the MMC layer. We would 
need to separate MMC logic from the driver interface. And mmc_block and 
sd_block would more or less be the same. Considering how much is similar 
(and most people want SD support anyhow), I'm not sure that we have much 
to gain from separating them.

>> * The mode (SD/MMC) of the host is stored. Since MMC uses a bus 
>> topology and SD uses a star one it is useful to be able to see which 
>> mode the controller is in.
>
>
> Is this needed? presumably any controller that implements MMC/SD slots 
> can only have one card/slot anyhow.
>
> Mind you, I have plans to look at SDIO, so that may alter things...
>
I need it to determine if the code should send an RCA or ask for one, 
and to determine if it should try and read the SCR. Your solution used 
an extra parameter but I thought a mode flag would be better since we 
might need to know mode later on (after init.).

>
> The toshiba controller appears to want to be told when an ACMD is 
> issued, compared to a normal CMD.

No hints in the spec about why? Seems very strange since there's no 
change in what goes over the wire.

Rgds
Pierre

