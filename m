Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVGOM04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVGOM04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVGOM04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:26:56 -0400
Received: from [85.8.12.41] ([85.8.12.41]:57731 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261194AbVGOM0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:26:55 -0400
Message-ID: <42D7AB91.7040508@drzeus.cx>
Date: Fri, 15 Jul 2005 14:26:57 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC host class
References: <42D538D4.7050803@drzeus.cx> <20050715093114.B25428@flint.arm.linux.org.uk>
In-Reply-To: <20050715093114.B25428@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>No no no no no.  Repeat after me ten times.  Empty or non-existant release
>functions are bad and cause oopsen.  I will not create code which does
>this.
>  
>

Sorry. I thought it was a generic cleanup function and since nothing was
allocated in the register function I didn't think it needed to do
anything. I tried to find some documentation about how classes were
handled but eventually had to resort to looking at other code. Perhaps I
should look at the documentation about kernel objects instead?

>What this means is that mmc_host itself becomes a refcounted sysfs
>object which needs to follow the lifetime rules associated therewith.
>
>Luckily, I thought about this earlier on, so there's a core mmc function
>to allocate the beast, register it, unregister it, and finally free it.
>
>The allocation function should initialise class_dev as much as possible.
>  
>

The name field cannot be initialised since it isn't generated until
registration. And I avoided filling in the other stuff at allocation so
that I could keep knowledge of mmc_host_class in mmc_sysfs.c.

>The registration function should add the class device with the class
>model.  The unregistration should remove the class device from the class
>model, but _not_ free it.  The free function should drop the last
>reference to the class device, which results in the remove function
>(eventually) being called.  Finally, the remove function can free the
>mmc_host.
>  
>

With the remove function you mean the .release in the class struct?

>Also note that since we have a class_dev, the mmc_host 'dev' field can
>be removed.  However, we'll probably have to update the host drivers
>to do this, so it should be a separate patch.
>
>  
>

I'll read up on kernel objects and sysfs and put together a new patch then.

Rgds
Pierre

