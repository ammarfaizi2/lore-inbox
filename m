Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754079AbWKGPvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbWKGPvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbWKGPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:51:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:19559 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1754072AbWKGPvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:51:24 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,396,1157353200"; 
   d="scan'208"; a="12723947:sNHT19458054"
Message-ID: <4550AB7A.10508@intel.com>
Date: Tue, 07 Nov 2006 07:51:22 -0800
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: e1000/ICH8LAN weirdness - no ethtool link until initially forced
 up
References: <20061106013153.GN15897@curie-int.orbis-terrarum.net> <20061107071449.GB21655@elf.ucw.cz>
In-Reply-To: <20061107071449.GB21655@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2006 15:51:22.0321 (UTC) FILETIME=[92AEB410:01C70284]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> [Please CC me on responses].
>>
>> A spot of weirdness I ran into on my e1000 card.
>> It's the 82566DC model [8086:104b] (rev 02) x1 PCIe.
>>
>> After modprobe e1000, ethtool reports that there is no link, despite the
>> correct link lights on the port. This breaks booting during a boot process that
>> checks for actual link status before using a device.
> ...
>> This behavior differs from every other network card, and is also present in the
>> 7.3* version of the driver from sourceforge.
>>
>> I think the e1000 should try to raise the link during the probe, so that it
>> works properly, without having to set ifconfig ethX up first.
> 
> I think you should cc e1000 maintainers, and perhaps provide a patch....

I've read it and not come up with an answer due to some other issues at hand. E1000 
hardware works differently and this has been asked before, but the cards itself are in 
low power state when down. Changing this to bring up the link would make the card start 
to consume lots more power, which would automatically suck enormously for anyone using a 
laptop.

Unfortunately, we have no way to distinguish directly between mobile and non-mobile 
adapters, since they are usually the same.

Your application should really `ifconfig up` the device before checking for link.

Cheers,

Auke
