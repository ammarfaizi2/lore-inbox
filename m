Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUKOTwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUKOTwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 14:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUKOTwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 14:52:24 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:9115 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261669AbUKOTvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:51:25 -0500
Message-ID: <419908B8.10202@free.fr>
Date: Mon, 15 Nov 2004 20:51:20 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, vojtech@suse.cz
Subject: Re: [PATCH] PNP support for i8042 driver
References: <41960AE9.8090409@free.fr>	 <200411140148.02811.dtor_core@ameritech.net>	 <41974DFD.5070603@free.fr> <d120d50004111506416237ff1b@mail.gmail.com>
In-Reply-To: <d120d50004111506416237ff1b@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Sun, 14 Nov 2004 13:22:21 +0100, matthieu castet
> <castet.matthieu@free.fr> wrote:
> 
>>Dmitry Torokhov wrote:
>>
>>
>>
>>>On Saturday 13 November 2004 08:23 am, matthieu castet wrote:
>>>
>>>
>>>>Hi,
>>>>this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi
>>>>is try before the pnp driver so if you don't disable ACPI or apply
>>>>others pnpacpi patches, it won't change anything.
>>>>
>>>>Please review it and apply if possible
>>>>
>>>>thanks,
>>>>
>>>>Matthieu CASTET
>>>>
>>>>Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>
>>>>
>>>Hi,
>>>
>>
>>Hi,
>>
>>>Do we really need to keep those drivers loaded - i8042 will not
>>>be hotplugged and ports are reserved anyway. We are only interested
>>>in presence of the keyboard and mouse ports. Can we unregister
>>>the drivers (both ACPI and PNP) right after registering and mark
>>>all that stuff as __init/__initdata as in the patch below?
>>
>>It is better to keep pnp driver loaded because when it unload, the
>>resources will be disabled, so for the motherboards that allow it the
>>irq won't work anymore, and so the keyboard and mouse won't work...
> 
> 
> Is it possible to leave the device in enabled state or enable device
> after unloading the driver with PNP? 
Yes you could do a very ugly hack : set pnp_can_disable(dev) to 0 before 
  unregister. With that the device won't be disabled (no resource 
desalocation), but the device will be mark as not active in pnp layer.

> All we need from PNP layer
> for i8042 is to verify presence of the KBC, we don't need resource
> management.The ports range is already marked as reserved, IRQ
> will be requested if needed...
> 
I don't agree at all :
- the pci layer allow you to find the device like pnp layer, then you 
register resource with request_region or equivalent. Do we need to do 
the same for all pci driver ?
- actually the resources are registered in the kernel, but not in the 
bios, why some strange bios can allow to use irq 12 to an other device 
if it isn't used ?
- Do you save lot's of memory with __init/__initdata ? The pnp code is 
quite small.

Matthieu
