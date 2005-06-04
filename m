Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFDUOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFDUOW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 16:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVFDUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 16:14:22 -0400
Received: from [85.8.12.41] ([85.8.12.41]:41394 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261235AbVFDUOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 16:14:17 -0400
Message-ID: <42A20B97.4080504@drzeus.cx>
Date: Sat, 04 Jun 2005 22:14:15 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Support for read-only MMC cards
References: <42A2070D.9060608@drzeus.cx> <20050604205810.A23449@flint.arm.linux.org.uk> <42A2096C.9010108@drzeus.cx> <20050604210733.B23449@flint.arm.linux.org.uk>
In-Reply-To: <20050604210733.B23449@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sat, Jun 04, 2005 at 10:05:00PM +0200, Pierre Ossman wrote:
>  
>
>>Russell King wrote:
>>    
>>
>>>I'd prefer this to be:
>>>
>>>	printk(KERN_INFO "%s: %s %s %dKiB%s\n",
>>>		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
>>>		(card->csd.capacity << card->csd.read_blkbits) / 1024,
>>>		card->csd.cmdclass & CCC_BLOCK_WRITE ? "" : " (ro)");
>>>
>>> 
>>>
>>>      
>>>
>>I'd rather not since the SD patches have a similar test but on a
>>different condition.
>>    
>>
>
>That's just a case of adding another %s and ?:.  I'd really prefer it
>to be done this way.
>
>  
>

Well that would turn out something like:

    printk(KERN_INFO "%s: %s %s %dKiB%s\n",
        md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
        (card->csd.capacity << card->csd.read_blkbits) / 1024,
        (!(card->csd.cmdclass & CCC_BLOCK_WRITE) ||
mmc_card_readonly(card)) ? " (ro)" : "");

which is a bit messy IMHO.

