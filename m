Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760312AbWLFIvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760312AbWLFIvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760318AbWLFIvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:51:21 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63224 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760312AbWLFIvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:51:21 -0500
Date: Wed, 6 Dec 2006 09:51:07 +0100 (MET)
Message-Id: <200612060851.kB68p7Dp024603@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: htejun@gmail.com, mikpe@it.uu.se
Subject: Re: [PATCH 2.6.19 3/3] sata_promise: cleanups
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2006 22:05:51 +0900, Tejun Heo wrote:
>Mikael Pettersson wrote:
>> This patch performs two simple cleanups of sata_promise.
>> 
>> * Remove board_20771 and map device id 0x3577 to board_2057x.
>>   After the recent corrections for SATAII chips, board_20771 and
>>   board_2057x were equivalent in the driver.
>
>Ack.
>
>> * Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
>>   to compute hotplug_offset in pdc_host_init().
>
>Please explain why.

hp->hotplug_offset was used to allow pdc_host_init() to work for both
1st and 2nd generation chips. However, more tests were needed to
properly handle other aspects of 2nd generation chips, so hp->flags
and PDC_FLAG_GEN_II were introduced. Now hp->hotplug_offset is redundant
since its value is derivable from hp->flags & PDC_FLAG_GEN_II.

>
>> @@ -704,7 +684,7 @@ static void pdc_host_init(unsigned int c
>>  {
>>  	void __iomem *mmio = pe->mmio_base;
>>  	struct pdc_host_priv *hp = pe->private_data;
>> -	int hotplug_offset = hp->hotplug_offset;
>> +	int hotplug_offset = (hp->flags & PDC_FLAG_GEN_II) ? PDC2_SATA_PLUG_CSR : PDC_SATA_PLUG_CSR;
>
>People tend to prefer explicit if () over ?: and dislike lines much
>longer than 80 column, well, at least in libata.

OK, I'll replace the ?: with an if-statement.

/Mikael
