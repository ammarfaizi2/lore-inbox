Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbTGJWzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269673AbTGJWzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:55:17 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:52306 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S269672AbTGJWzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:55:03 -0400
Message-ID: <3F0DF118.3080806@rackable.com>
Date: Thu, 10 Jul 2003 16:04:56 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Chad Kitching <CKitching@powerlandcomputers.com>,
       Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached
 to fix
References: <Pine.SOL.4.30.0307110011320.6781-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307110011320.6781-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2003 23:09:43.0921 (UTC) FILETIME=[59585E10:01C34738]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>On Thu, 10 Jul 2003, Chad Kitching wrote:
>
>  
>
>>I don't know.  That seemed to have changed the option from merely
>>mystifying to down right confusing.  By that wording, does that feature
>>override it into being a plain IDE controller, or an IDE RAID controller?
>>The new name seems to imply the former, while the mentions
>>of ataraid suggest the latter.
>>    
>>
>
>Hmmm... you are right. Comment is still misleading in respect to RAID.
>
>ataraid driver is a _software_ RAID, just like Promise's binary driver.
>
>FastTracks have software RAID. There are few true hardware FastTrak
>RAID controllers with I2O interface but we probe for them properly in
>pdc202xx_new.c driver and don't use IDE driver for them.
>
>  
>
>>Despite the grammatical errors, pdc202xx.c's comments perhaps describe it
>>better.
>>* Linux kernel will misunderstand FastTrak ATA-RAID series as Ultra
>>* IDE Controller, UNLESS you enable "CONFIG_PDC202XX_FORCE"
>>* That's you can use FastTrak ATA-RAID controllers as IDE controllers.
>>    
>>
>
>It is quite opposite.
>
>  
>
>>If this is true, may I suggest something more along the lines of:
>>
>>Ignore FastTrak BIOS and configure controller for RAID
>>CONFIG_PDC202XX_FORCE
>>  Forces the driver to use the ATA-RAID capabilities, overriding the
>>  BIOS configuration of the controller. Do not enable if you are
>>  using Promise's binary module.  This option is compatible with the
>>  ataraid driver.
>>    
>>
>
>What about this:
>

Much better, but

>
>Ignore FastTrak BIOS
>CONFIG_PDC202XX_FORCE
>  Forces the driver to use FastTrak controller even if it was disabled
>  by BIOS for Promise software RAID driver.
>
This one might confuse people thinking we mean the ataraid driver, and 
not the binary only driver. 

Maybe:
Forces the driver to use FastTrak controller even if it was disabled
 by BIOS for Promise's binary only software RAID driver.

>
>  Say Y if you do not use Promise's software RAID or
>        if you want to use ataraid driver.
>
>
>  Say N if you want to use Promise's binary module.
>
>  
>
>>If the Linux driver has the same limitation in regards to using CD-ROM
>>drives on the controller while it's in RAID mode as the Windows drivers
>>do, it may be useful to mention the fact that the option is incompatible
>>with CD-ROM drives attached to the controller.
>>    
>>
>
>It has. According to Andre it is doable but big pain,
>also Promise gives docs under NDA which makes it even harder.
>
>Please search lkml archive if you want know technical details.
>
>  
>
>>Of course, maybe it means the complete opposite, and I'm reading everything
>>wrong, in which case, there are some comments you may want to fix, too.
>>    
>>
>
>Comments in Promise driver need fixing.
>
>  
>


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


