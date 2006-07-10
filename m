Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWGJRV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWGJRV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWGJRV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:21:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:20008 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422715AbWGJRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:21:29 -0400
X-IronPort-AV: i="4.06,225,1149490800"; 
   d="scan'208"; a="95761205:sNHT43030365"
Message-ID: <44B28C5A.5090605@intel.com>
Date: Mon, 10 Jul 2006 10:20:26 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug] e100 bug: checksum mismatch on 82551ER rev10
References: <62b0912f0607090434q735e36b7pd9ab35baf0914e7a@mail.gmail.com>	 <44B2716A.3030009@intel.com> <62b0912f0607100945o574dcce8w8f734e5828bdcaa8@mail.gmail.com>
In-Reply-To: <62b0912f0607100945o574dcce8w8f734e5828bdcaa8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2006 17:21:13.0734 (UTC) FILETIME=[3EA50A60:01C6A445]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> Auke Kok wrote:
>> If you have received a motherboard or card with a broken EEPROM then 
>> your card
>> is in a limbo state - it might work but results are unreliable and may 
>> cause
>> your entire system to break (and even data corruption).
>>
>> You should contact the hardware vendor and have the board replaced or 
>> upgraded
>> with a proper EEPROM. Continuing to work with the corrupted EEPROM 
>> image that
>> you have now can seriously hurt you later on.
> 
> Every single IP130 I've had my hands on has had an EEPROM that the
> Linux driver declared bad.

that means that whoever is selling you the IP130's is consistently putting on 
bad EEPROMs, which is *very* bad. Which vendor is that? They can fix this 
problem for you and for *everyone* else they have sold and will sell IP130's 
to in the future.

> I'm afraid that it's not the board that's at fault, it's the driver.

No it is not. The NIC is supported (you can even call Intel for first line 
support) but if your vendor put a bad EEPROM image on it then all bets are 
off.  Intel provides the vendors with the proper tools to make valid EEPROMs, 
the driver checks them for a very good reason.

> The NICs are working perfectly.

How can you tell? Do you know if jumbo frames work correctly?  Is the device 
properly checksumming? is flow control working properly?  These and many, many 
more settings are determined by the EEPROM.  Seemingly it may work correctly, 
but there is no guarantee whatsoever that it will work correctly at all if the 
checksum is bad.  Again, you can lose data, or worse, you could corrupt memory 
in the system causing massive failure (DMA timings, etc). Unlikely? sure, but 
not impossible.

> (Also, it seems mighty odd to refuse to drive the hardware based on an
> EEPROM checksum failure, when the e100 driver will happily load for a
> device where for example IRQ routing is broken.  Just another
> indication that erroring out in this situation is overkill.)

That is another discussion.  All wifi drivers bail out if the firmware is 
corrupted, why shouldn't e1000 be allowed to do so either? Are you willing to 
risk your data?

Cheers,

Auke
