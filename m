Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVASOQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVASOQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVASOQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:16:20 -0500
Received: from mail.suse.de ([195.135.220.2]:6343 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261730AbVASOQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:16:09 -0500
Message-ID: <41EE6BA8.6020705@suse.de>
Date: Wed, 19 Jan 2005 15:16:08 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
References: <41ED2457.1030109@suse.de>	 <d120d50005011807566ee35b2b@mail.gmail.com> <41EE2F82.3080401@suse.de> <d120d500050119060530b57cd7@mail.gmail.com>
In-Reply-To: <d120d500050119060530b57cd7@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Hannes, 
> 
> On Wed, 19 Jan 2005 10:59:30 +0100, Hannes Reinecke <hare@suse.de> wrote:
> 
>>Dmitry Torokhov wrote:
>>
>>>But the real question is whether we really need class devices have
>>>unique names or we could do with inputX thus leaving individual
>>>drivers intact and only modifying the input core. As far as I
>>>understand userspace should be concerned only with device
>>>capabilities, not particular name, besides, it gets PRODUCT string
>>>which has all needed data encoded.
>>>
>>
>>Indeed. What about using 'phys' (with all '/' replaced by '-') as the
>>class_id? This way we'll retain compability with /proc/bus/input/devices
>>and do not have to touch every single driver.
>>
> 
> 
> I want to kill phys at some point - we have topology information
> already present in sysfs in much better form. Can we have a new
> hotplug variable HWDEV= which is kobject_path(input_dev->dev). If
> input_dev is not set then we can just dump phys in it. And the class
> id will still be inputX. Will this work?
>  
Sure. And we don't need a special HWDEV variable, as there is already a 
PHYSDEVPATH variable providing exactly this information.
I'm not too happy about this 'inputX' thing (as this doesn't carry any 
information, whereas 'phys' gives you at least a rough guess what this 
device's about), but if phys is to go it would be the logical choice.

> Btw, I really doubt that topology information is important here as the
> only thing that one needs to do when new "input_device" appears is to
> load one or more input handler modules based on device's capability
> bits. The decision whether a device is "good enough" to create a
> device node should be done by hotplug handler for the other "input"
> class.
> 
Yes, topology is not an issue when loading modules.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
