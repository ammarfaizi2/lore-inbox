Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVATH4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVATH4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 02:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVATH4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 02:56:05 -0500
Received: from news.suse.de ([195.135.220.2]:31461 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262069AbVATHz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 02:55:58 -0500
Message-ID: <41EF640D.60102@suse.de>
Date: Thu, 20 Jan 2005 08:55:57 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: dtor_core@ameritech.net, Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] remove input_call_hotplug (Take#2)
References: <41EE651E.1060201@suse.de> <20050119214249.GC4151@kroah.com>
In-Reply-To: <20050119214249.GC4151@kroah.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jan 19, 2005 at 02:48:14PM +0100, Hannes Reinecke wrote:
> 
>>Hi Dmitry,
>>
>>attached is the reworked patch for removing the call to 
>>call_usermodehelper from input.c
>>I've used the 'phys' attribute to generate the device names, this way we 
>>don't need to touch all drivers and the patch itself is nice and small.
> 
> 
> The main problem of this is the input_dev structures are created
> statically, right?  Because of this, the release function really doesn't
> work out correctly I think....
> 
That depends on the driver. input_dev is in general a static entry in 
the driver-dependend structure, which in turn may be statically or 
dynamically allocated (depending on whether the driver allows for more 
than one instance of the device to be connected).
Would dynamic allocation be of any help here?

I must admit that reference counting in sysfs is still a somewhat 
darkish grey box to me.

> Other than that this looks a lot better.
> 
kewl.

> Hm, you're still generating hotplug events with this patch of the
> "input_device" type, right?
> 
Of course. I didn't see another way, as already stated the originial 
input events were something of a misnomer.
So either I had to change the existing sysfs layout by renaming the 
current 'input' class and retain compability with the events
or change the event types and retain compability with the sysfs layout.
I opted for the latter, as AFAIK more userland tools might be reading 
from sysfs than processing hotplug events.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
