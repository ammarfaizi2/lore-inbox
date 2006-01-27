Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWA0NQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWA0NQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWA0NQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:16:31 -0500
Received: from [85.8.13.51] ([85.8.13.51]:14297 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750803AbWA0NQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:16:30 -0500
Message-ID: <43DA1D23.1000508@drzeus.cx>
Date: Fri, 27 Jan 2006 14:16:19 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127123917.GI4311@suse.de>
In-Reply-To: <20060127123917.GI4311@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jan 27 2006, Pierre Ossman wrote:
>> That would still make things rather difficult since there is no way to
>> get both maps into joining vaddrs. Is there no way to say "don't cross
>> page boundaries"? Setting a segment size of PAGE_SIZE still causes
>> problems when the offset isn't 0.
>>     
>
> To be absolutely sure, you can just disallow multiple pages in a bio.
>
>   

The only stuff that reaches the MMC drivers is the scatter list. So
anything that operates on the request queue or any other block layer
specifics is probably out of the question since it breaks the abstraction.

Doesn't seem like a generic solution is easily implemented. I'll start
hacking together some way of specifying that highmem isn't supported so
that mmc_block can indicate this to the block layer.

Rgds
Pierre

