Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937259AbWLDSoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937259AbWLDSoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937260AbWLDSoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:44:19 -0500
Received: from smtp.nokia.com ([131.228.20.170]:17608 "EHLO
	mgw-ext11.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937259AbWLDSoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:44:18 -0500
Message-ID: <45746CD3.1000604@indt.org.br>
Date: Mon, 04 Dec 2006 14:45:39 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx>
In-Reply-To: <45680308.4040809@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 18:41:27.0437 (UTC) FILETIME=[CE8F13D0:01C717D3]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061204204333-40027BB0-04A26986/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson Briglia wrote:
>> @@ -244,5 +244,13 @@ struct _mmc_csd {
>>  #define SD_BUS_WIDTH_1      0
>>  #define SD_BUS_WIDTH_4      2
>>
>> +/*
>> + * MMC_LOCK_UNLOCK modes
>> + */
>> +#define MMC_LOCK_MODE_ERASE    (1<<3)
>> +#define MMC_LOCK_MODE_UNLOCK    (0<<2)
>> +#define MMC_LOCK_MODE_CLR_PWD    (1<<1)
>> +#define MMC_LOCK_MODE_SET_PWD    (1<<0)
>> +
>>  #endif  /* MMC_MMC_PROTOCOL_H */
>>
> 
> This definition makes them look like bits, which is not how they are used.

Actually they represent the bits regarding the modes and it is used when we
have to send the LOCK/UNLOCK mode on the command data block, according to the MMC Spec.
If you take a look at mmc_lock_unlock function, we use those modes to set the right bit
when composing the command data block.
This definition makes the code more legible and simple.

Regards,

Anderson Briglia
