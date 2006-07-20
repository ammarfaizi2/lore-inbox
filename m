Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWGTRiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWGTRiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWGTRiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:38:13 -0400
Received: from mga03.intel.com ([143.182.124.21]:6324 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750789AbWGTRiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:38:12 -0400
X-IronPort-AV: i="4.07,163,1151910000"; 
   d="scan'208"; a="68950202:sNHT5234051746"
Message-ID: <44BFBE9F.7070600@intel.com>
Date: Thu, 20 Jul 2006 10:34:23 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Auke Kok <auke-jan.h.kok@intel.com>, cramerj@intel.com,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, kernel list <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: e1000: "fix" it on thinkpad x60 / eeprom checksum read fails
References: <20060721005832.GA1889@elf.ucw.cz> <44BFADA6.6090909@intel.com> <20060720170758.GA9938@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060720170758.GA9938@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jul 2006 17:35:17.0622 (UTC) FILETIME=[DDC5A160:01C6AC22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> e1000 in thinkpad x60 fails without this dirty hack. What to do with
>>> it?
>>>
>>> Signed-off-by: Pavel Machek <pavel@suse.cz>
>> NAK, certainly this should never be merged in any tree...
>>
>> this is a known issue that we're tracking here:
>>
>> http://sourceforge.net/tracker/index.php?func=detail&aid=1474679&group_id=42302&atid=447449
>>
>> Summary of the issue:
>>
>> Lenovo has used certain BIOS versions where ASPD/DSPD was turned on which 
>> turns the PHY off when no cable is inserted to save power. The e1000 driver 
>> already turns off this feature but can't do this until the driver is 
>> loaded. It seems that turning this feature on causes the MAC to give read 
>> errors.
>>
>> Lenovo seems to have the feature turned off in their latest BIOS versions, 
>> we encourage all people to upgrade their BIOS with the latest version from 
>> Lenovo (available from their website). It seems that for at least 2 people, 
>> this has fixed the problem.
>>
>> Inserting a cable obviously might also work :)
> 
> Hehe.
> 
>> We did reproduce the problem initially with the old BIOS (1.01-1.03) on a 
>> T60 system, but unfortunately the bug disappeared into nothingness.
>>
>> Bypassing the checksum leaves the NIC in an uncertain state and is not 
>> recommended.
> 
> Okay, perhaps this should be inserted as a comment into the driver,
> and printk should be fixed to point at this explanation?
> 
> Can't we enable the driver with the bad checksum, then read the _real_
> data?

no.

We're working on a solution where we make sure that the PHY is physically 
turned on properly before we read the EEPROM, which would be the proper fix. 
It's completely not acceptable to run when the EEPROM checksum fails - you 
might even be running with the wrong MAC address, or worse. Lets fix this the 
right way instead.

Auke

PS: adding netdev to the CC...
