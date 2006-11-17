Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756024AbWKQXBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbWKQXBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbWKQXBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:01:43 -0500
Received: from mgw-ext13.nokia.com ([131.228.20.172]:18785 "EHLO
	mgw-ext13.nokia.com") by vger.kernel.org with ESMTP
	id S1756024AbWKQXBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:01:42 -0500
Message-ID: <455E3FFE.90001@indt.org.br>
Date: Fri, 17 Nov 2006 19:04:30 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-list@drzeus.cx>,
       ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Biris Ilias (EXT-INdT/Manaus)" <Ilias.Biris@indt.org.br>
Subject: Re: [patch 1/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V6
References: <455DB297.1040009@indt.org.br> <20061117160414.GA28514@flint.arm.linux.org.uk>
In-Reply-To: <20061117160414.GA28514@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Nov 2006 23:00:42.0388 (UTC) FILETIME=[35027D40:01C70A9C]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel and Pierre,

Thanks for all comments, I'm fixing the series and will send another version asap.

ext Russell King wrote:
> On Fri, Nov 17, 2006 at 09:01:11AM -0400, Anderson Briglia wrote:
>> Index: linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c
>> ===================================================================
>> --- linux-omap-2.6.git.orig/drivers/mmc/mmc_sysfs.c	2006-11-14 
>> 08:46:54.000000000 -0400
>> +++ linux-omap-2.6.git/drivers/mmc/mmc_sysfs.c	2006-11-14 
>> 09:06:39.000000000 -0400
>> @@ -17,6 +17,7 @@
>>
>>  #include <linux/mmc/card.h>
>>  #include <linux/mmc/host.h>
>> +#include <linux/mmc/protocol.h>
> 
> Why does this file need mmc/protocol.h?  I don't see anything added
> which would require this include.

We need this here because mmc_card_lockable function uses "CCC_LOCK_CARD" macro defined on 
linux/mmc/protocol.h

> 
>> @@ -73,10 +74,19 @@ static void mmc_release_card(struct devi
>>   * This currently matches any MMC driver to any MMC card - drivers
>>   * themselves make the decision whether to drive this card in their
>>   * probe method.  However, we force "bad" cards to fail.
>> + *
>> + * We also fail for all locked cards; drivers expect to be able to do block
>> + * I/O still on probe(), which is not possible while the card is locked.
>> + * Device probing must be triggered sometime later to make the card 
>> available
> 
> Your mailer wrapped the patch...  Also it would be nice to have this manually
> wrapped so it's viewable sanely on a standard 80 column display.
> 
>> @@ -75,12 +76,19 @@ struct mmc_card {
>>  #define mmc_card_bad(c)		((c)->state & MMC_STATE_BAD)
>>  #define mmc_card_sd(c)		((c)->state & MMC_STATE_SDCARD)
>>  #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
>> +#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
>> +#define mmc_card_clear_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)
> 
> Since we separate out the "mmc_card_set_xxx" macros, please do the same
> with the "mmc_card_clear_xxx" for consistency sake.
> 



