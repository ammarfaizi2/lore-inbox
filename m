Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVGRSW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVGRSW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVGRSW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 14:22:56 -0400
Received: from [85.8.12.41] ([85.8.12.41]:7809 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261453AbVGRSWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 14:22:52 -0400
Message-ID: <42DBF378.7080804@drzeus.cx>
Date: Mon, 18 Jul 2005 20:22:48 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
References: <42D538D4.7050803@drzeus.cx> <20050715093114.B25428@flint.arm.linux.org.uk> <42D81AD7.3000407@drzeus.cx> <20050718184554.A31022@flint.arm.linux.org.uk>
In-Reply-To: <20050718184554.A31022@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Fri, Jul 15, 2005 at 10:21:43PM +0200, Pierre Ossman wrote:
>  
>
>>Russell King wrote:
>>    
>>
>>>Also note that since we have a class_dev, the mmc_host 'dev' field can
>>>be removed.  However, we'll probably have to update the host drivers
>>>to do this, so it should be a separate patch.
>>>      
>>>
>>I believe there's a bit of abstraction to be gained from not poking
>>around inside the class_dev struct in too many places. It's not like
>>we're wasting any large amounts of memory.
>>    
>>
>
>I still don't like the needless duplication.  How about doing it this
>way (see the attached patch.)
>  
>

The mmc_hostname macro seems like a good solution. It'll keep the
abstraction even if stuff needs to be moved around.

I see a problem with waiting until mmc_add_host() until initialising the
kobject though. If a driver calls mmc_alloc_host() and then
mmc_free_host(), perhaps because of some error, then the structure won't
be freed since we rely on release getting called. That's why I tried to
get the kobject stuff set up with the allocation.

Perhaps it is possible to test if a kobject is initialised and if not
free the structure directly?

Rgds
Pierre

