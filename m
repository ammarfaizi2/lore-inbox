Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbUKNMW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUKNMW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 07:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUKNMW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 07:22:27 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:6124 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261293AbUKNMWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 07:22:22 -0500
Message-ID: <41974DFD.5070603@free.fr>
Date: Sun, 14 Nov 2004 13:22:21 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, vojtech@suse.cz
Subject: Re: [PATCH] PNP support for i8042 driver
References: <41960AE9.8090409@free.fr> <200411140148.02811.dtor_core@ameritech.net>
In-Reply-To: <200411140148.02811.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Saturday 13 November 2004 08:23 am, matthieu castet wrote:
> 
>>Hi,
>>this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
>>is try before the pnp driver so if you don't disable ACPI or apply 
>>others pnpacpi patches, it won't change anything.
>>
>>Please review it and apply if possible
>>
>>thanks,
>>
>>Matthieu CASTET
>>
>>Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>
>>
> 
> Hi,
> 
Hi,
> Do we really need to keep those drivers loaded - i8042 will not
> be hotplugged and ports are reserved anyway. We are only interested
> in presence of the keyboard and mouse ports. Can we unregister
> the drivers (both ACPI and PNP) right after registering and mark
> all that stuff as __init/__initdata as in the patch below?
It is better to keep pnp driver loaded because when it unload, the 
resources will be disabled, so for the motherboards that allow it the 
irq won't work anymore, and so the keyboard and mouse won't work...
Also it avoid the user to do
"echo disable > /sys/bus/pnp/xx\:xx/resources". Actually, it disables 
the resources for the mouse even if the driver is using the resource...

> I also adjusted init logic so ACPI/PNP can be enabled/disabled
> independently of each other.
> 
No problem as long as :
-if there is no acpi support, pnp can be used
-if acpi driver detect nothing, and there is pnp support, pnp driver 
will be tried before returning an error (it is important because, in the 
future pnpacpi will "lock" the acpi device, so the acpi driver will find 
nothing even if there are devices)


Regards,

Matthieu
