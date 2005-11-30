Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbVK3EnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbVK3EnI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVK3EnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:43:08 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5298 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750986AbVK3EnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:43:07 -0500
Message-ID: <438D2DCC.4010805@pobox.com>
Date: Tue, 29 Nov 2005 23:42:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com>
In-Reply-To: <438D2792.9050105@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > [CC'ing Jeff, Carlos & linux-ide] >
	> Ethan Chen wrote: > >> I've got a dual Opteron 242 machine here with
	2x Seagate ST3200822AS >> SATA drives attached to a Silicon Image
	SI3114 controller, and after >> upgrading to 2.6.14 from 2.6.13, it
	seems the SIL_QUIRK_MOD15WRITE >> workaround for the sata_sil driver
	isn't being applied anymore. This >> caused me trouble in the past
	before my drive was added to the >> blacklist, and this message that
	comes up when writing (~4GBfiles to >> test) files, right before the
	computer locks up, is the same as before: >> kernel: ata1: command 0x35
	timeout, stat 0xd8 host_stat 0x61 >> In the dmesg, the 'Applying
	Seagate errata fix' message doesn't appear >> anymore as well. >>
	Finally, without the fix, write speeds are much higher as well, before
	>> it locks up. > > > Hello, Ethan. > > Sometime ago, Silicon Image has
	confirmed that 3114's and 3512's are not > affected by the m15w problem
	- only 3112's are affected. So, a patch > has made into the tree before
	2.6.14 to apply the m15w quirk selectively. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> [CC'ing Jeff, Carlos & linux-ide]
> 
> Ethan Chen wrote:
> 
>> I've got a dual Opteron 242 machine here with 2x Seagate ST3200822AS 
>> SATA drives attached to a Silicon Image SI3114 controller, and after 
>> upgrading to 2.6.14 from 2.6.13, it seems the SIL_QUIRK_MOD15WRITE 
>> workaround for the sata_sil driver isn't being applied anymore. This 
>> caused me trouble in the past before my drive was added to the 
>> blacklist, and this message that comes up when writing (~4GBfiles to 
>> test) files, right before the computer locks up, is the same as before:
>> kernel: ata1: command 0x35 timeout, stat 0xd8 host_stat 0x61
>> In the dmesg, the 'Applying Seagate errata fix' message doesn't appear 
>> anymore as well.
>> Finally, without the fix, write speeds are much higher as well, before 
>> it locks up.
> 
> 
> Hello, Ethan.
> 
> Sometime ago, Silicon Image has confirmed that 3114's and 3512's are not 
> affected by the m15w problem - only 3112's are affected.  So, a patch 
> has made into the tree before 2.6.14 to apply the m15w quirk selectively.

Most likely, mod15write quirk was just hiding an unrelated problem. 
mod15write often hid BIOS problems in the past which led to corruption.

Until sata_sil properly handles SATA phy / DMA errors by resetting the 
controller and retrying the command, we won't know if its a driver 
problem or not.

	Jeff



