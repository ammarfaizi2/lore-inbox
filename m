Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWAKOaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWAKOaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWAKOaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:30:20 -0500
Received: from mgw-ext03.nokia.com ([131.228.20.95]:25575 "EHLO
	mgw-ext03.nokia.com") by vger.kernel.org with ESMTP id S932392AbWAKOaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:30:18 -0500
Message-ID: <43C50EEB.9060501@indt.org.br>
Date: Wed, 11 Jan 2006 09:58:03 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       ext David Brownell <david-b@PACBELL.NET>, linux@arm.linux.org.uk,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       drzeus-list@drzeus.cx,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] Add MMC password protection (lock/unlock) support
 V3
References: <43C2E0A2.3090701@indt.org.br>	<20060109224204.GH19131@flint.arm.linux.org.uk> <43C42B00.60206@indt.org.br>
In-Reply-To: <43C42B00.60206@indt.org.br>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2006 13:56:20.0482 (UTC) FILETIME=[CCF0A620:01C616B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> Russell King wrote:
> 
> 
>>On Mon, Jan 09, 2006 at 06:16:02PM -0400, Anderson Briglia wrote:
>> 
>>
>>
>>>+	dev = bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
>>>+	if (!dev)
>>>+		goto error;
>>>+	card = dev_to_mmc_card(dev);
>>>+	
>>>+	if (operation == KEY_OP_INSTANTIATE) { /* KEY_OP_INSTANTIATE */
>>>+               if (mmc_card_locked(card)) {
>>>+                       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
>>>+                       mmc_remove_card(card);
>>>+                       mmc_register_card(card);
>>>+               }
>>>+	       else
>>>+		       ret = mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
>>>   
> 
>>Also, removing and re-registering a card is an offence.  These
>>things are ref-counted, and mmc_remove_card() will drop the last
>>reference - so the memory associated with it will be freed.  Then
>>you re-register it.  Whoops.
>>
>>If you merely want to try to attach a driver, use device_attach()
>>instead.
>>
We changed the mmc_remove_card() and mmc_register_card() by device_release_driver() and
device_attach(), supposedly avoiding ref-counts issues.

Regards,

Anderson Briglia
INdT - Manaus
