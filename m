Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVANLiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVANLiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 06:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVANLiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 06:38:11 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:62866 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261958AbVANLh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 06:37:58 -0500
Message-ID: <41E7AF11.6030005@drzeus.cx>
Date: Fri, 14 Jan 2005 12:37:53 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Richard Purdie <rpurdie@rpsys.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MMC Driver RFC
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com>
In-Reply-To: <41E5B177.4060307@f2s.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice too see that you're alive Ian ;)

I've been trying to send you some mail regarding your SD implementation 
but I haven't received any replies. Perhaps they've gotten lost somewhere?

I've made my own SD patch using some of your work but also a lot of my 
own stuff. I had some problems getting your patches to apply cleanly to 
the current tree so I reimplemented it using your code as a template.

The patch can be found at:
http://projects.drzeus.cx/wbsd/sd.php
That page also contains the legal issues as I've understood them.

A summary of what I've done (relative your work):

* flags renamed to caps to better reflect what it does.
* SD_4_BITS changed to 4_BIT_DATA. Hopefully 4-bit mode in SD and MMC 
will be compatible, at least on the driver level.
* HOST_ changed to MMC_ to conform with the rest of the macros.
* Added a function in the driver to test for SD read-only switch.
* Moved SD-specific commands to a separate section in the header so they 
are more easily distinguished.
* SCR register is read from card and used when determining bus width.
* I've separated SD detection a bit.
* The mode (SD/MMC) of the host is stored. Since MMC uses a bus topology 
and SD uses a star one it is useful to be able to see which mode the 
controller is in.

I also couldn't find the reason for the ACMD flags you've added. 
Application commands only differ in semantics, not format, so I couldn't 
figure out why these where needed. Perhaps I'm missing something.

Ian Molton wrote:
>>
>> Unfortunately, such specs only cover MMC cards and not SD cards.
> 
> 
> ISTR seeing a SD card doc at some point

I have specs for SD cards from Sandisk and Toshiba. Both found on the 
respective manufacturer's site using google. These have been the basis 
for my work.

> 
> Well I *know* I never saw the specs from the SD forum. I hacve never 
> reverse engineered a SDHC core driver either (I have reverse engineered 
> a chip driver but it contained no SD *protocol* information.
> 
> as such my code should be 100% safe to commit to the kernel.
> 

My code is based on the SD card specs I've found so it probably isn't as 
safe.

Rgds
Pierre
