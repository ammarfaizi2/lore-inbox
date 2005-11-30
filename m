Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVK3Fhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVK3Fhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 00:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVK3Fhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 00:37:55 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:19689 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751062AbVK3Fhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 00:37:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sHj14We9Ql6vNOGRNk62xCdAJy92dtgD56oVbCLSGOA/NXMapRXVNxAHZvILdIAqRPel1JdHy39HiZ+US8emmzcgSgYtmyR6hNaeYoh9H5DP+rc2ISz+drQ/fcihUQIsHTiYw/AnRWJ8RM2V5sr5cdbfKTNqvu5We9VmFP0mFPI=
Message-ID: <438D3AA8.9030504@gmail.com>
Date: Wed, 30 Nov 2005 14:37:44 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com> <438D2DCC.4010805@pobox.com>
In-Reply-To: <438D2DCC.4010805@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> [CC'ing Jeff, Carlos & linux-ide]
>>
>> Ethan Chen wrote:
>>
>>> I've got a dual Opteron 242 machine here with 2x Seagate ST3200822AS 
>>> SATA drives attached to a Silicon Image SI3114 controller, and after 
>>> upgrading to 2.6.14 from 2.6.13, it seems the SIL_QUIRK_MOD15WRITE 
>>> workaround for the sata_sil driver isn't being applied anymore. This 
>>> caused me trouble in the past before my drive was added to the 
>>> blacklist, and this message that comes up when writing (~4GBfiles to 
>>> test) files, right before the computer locks up, is the same as before:
>>> kernel: ata1: command 0x35 timeout, stat 0xd8 host_stat 0x61
>>> In the dmesg, the 'Applying Seagate errata fix' message doesn't 
>>> appear anymore as well.
>>> Finally, without the fix, write speeds are much higher as well, 
>>> before it locks up.
>>
>>
>>
>> Hello, Ethan.
>>
>> Sometime ago, Silicon Image has confirmed that 3114's and 3512's are 
>> not affected by the m15w problem - only 3112's are affected.  So, a 
>> patch has made into the tree before 2.6.14 to apply the m15w quirk 
>> selectively.
> 
> 
> Most likely, mod15write quirk was just hiding an unrelated problem. 
> mod15write often hid BIOS problems in the past which led to corruption.
> 
> Until sata_sil properly handles SATA phy / DMA errors by resetting the 
> controller and retrying the command, we won't know if its a driver 
> problem or not.
> 

Ethan confirmed that it's 1095:3114.  Arghhh....  Maybe we should keep 
m15w quirk for 3114's for the time being?  Better be slow than hang. 
Whatever bug the m15w quirk was hiding.

Carlos, can you double check that 3114's don't have the m15w issue?  It 
just seems too similar to the usual m15w lockup.

-- 
tejun
