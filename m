Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVANO4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVANO4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVANO4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:56:09 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:15315 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262003AbVANO4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:56:02 -0500
Message-ID: <41E7DD5E.5070901@f2s.com>
Date: Fri, 14 Jan 2005 14:55:26 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Richard Purdie <rpurdie@rpsys.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx>
In-Reply-To: <41E7AF11.6030005@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Nice too see that you're alive Ian ;)
> 
> I've been trying to send you some mail regarding your SD implementation 
> but I haven't received any replies. Perhaps they've gotten lost somewhere?

I've been getting errors replying to you but had no alternative address 
to use. perhaps you could mail me from another account ?

> A summary of what I've done (relative your work):
> 
> * flags renamed to caps to better reflect what it does.
> * SD_4_BITS changed to 4_BIT_DATA. Hopefully 4-bit mode in SD and MMC 
> will be compatible, at least on the driver level.
> * HOST_ changed to MMC_ to conform with the rest of the macros.
> * Added a function in the driver to test for SD read-only switch.

Good stuff.

> * Moved SD-specific commands to a separate section in the header so they 
> are more easily distinguished.

I had been meaning to move all the c code referencing SD to a seperate 
sd.c file such that it could be compiled optionally on top of MMC. at 
the time it wasnt mature enough to be worth it, but that may be worth 
revisiting now.

> * SCR register is read from card and used when determining bus width.

Good. This was needed.

> * I've separated SD detection a bit.

Good (see above :)

> * The mode (SD/MMC) of the host is stored. Since MMC uses a bus topology 
> and SD uses a star one it is useful to be able to see which mode the 
> controller is in.

Is this needed? presumably any controller that implements MMC/SD slots 
can only have one card/slot anyhow.

Mind you, I have plans to look at SDIO, so that may alter things...

> I also couldn't find the reason for the ACMD flags you've added. 
> Application commands only differ in semantics, not format, so I couldn't 
> figure out why these where needed. Perhaps I'm missing something.

The toshiba controller appears to want to be told when an ACMD is 
issued, compared to a normal CMD.

>> as such my code should be 100% safe to commit to the kernel.
> 
> My code is based on the SD card specs I've found so it probably isn't as 
> safe.

The card specs I have seen were public docs so we should be clear there.


