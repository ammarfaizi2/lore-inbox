Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUH3JLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUH3JLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 05:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUH3JLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 05:11:55 -0400
Received: from wasp.net.au ([203.190.192.17]:13754 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S267514AbUH3JLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 05:11:51 -0400
Message-ID: <4132EF78.9000200@wasp.net.au>
Date: Mon, 30 Aug 2004 13:12:24 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata dev_config call order wrong.
References: <41320DAF.2060306@wasp.net.au> <41321288.4090403@pobox.com>	 <413216CC.5080100@wasp.net.au> <4132198B.8000504@pobox.com>	 <41321F7F.7050300@pobox.com> <1093805994.28289.4.camel@localhost.localdomain>
In-Reply-To: <1093805994.28289.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2004-08-29 at 19:25, Jeff Garzik wrote:
> 
>>According to the Serial ATA docs, IDENTIFY DEVICE word 93 will be zero 
>>if it's Serial ATA.  Who knows if that's true, given the wierd wild 
>>world of ATA devices.
> 
> 
> You need to check if word 93 is valid first. Same with things like the
> cache control word - its value is only meaningful if the drive says the
> word is meaningful.

I'm making some assumptions here based on information I could scrape up off the net.

IDENTIFY DEVICE Word 93 support has been mandatory at least since ATA-5.

ATA-5 did not have lba48 or > udma/66.

SATA->PATA bridge boards support > udma/33 and thus must emulate an 80 conductor cable.

Thus, any device capable of lba48 (and these are the ones that trigger the > 200 sector problem) 
must (according to the ATA-5 and up standard) support correct use of the IDENTIFY DEVICE word 93 
register.

Given that the SATA->PATA bridge boards support 80 pin detection, then bit 13 of word 93 must be 
high on any drive that supports lba48, and given the *current* sata spec states that word 93 must be 
zero, we should be able to use this detection method.

Now, remember I have been an "ATA researcher" for about 4 hours now, please feel free to belt me 
with the wet salmon of enlightenment and point out the flaw in my logic. Otherwise, when I get home 
this evening I'm going to have a crack and getting this working.

Regards,
Brad
