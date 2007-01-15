Return-Path: <linux-kernel-owner+w=401wt.eu-S1751781AbXAOCVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbXAOCVl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 21:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbXAOCVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 21:21:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:53868 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbXAOCVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 21:21:40 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=m010chkt4Y6wOj8b6N/jzmz3myIVycFVtR2G8OMaKm5McpPm7SQ63QY6QsRZMnpLlNgPKjT9pmDm/TJAqefE1S0O3zyMvBH0wqW4ijCAmA2CV8AhjkwUG9MAuY46PpWNlJSrnM7pC4r5AkNoE+2O2/W4iViy+G4wS21nQxsJ9TQ=
Message-ID: <45AAE52B.2070705@gmail.com>
Date: Mon, 15 Jan 2007 11:21:31 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Jeff Garzik <jeff@garzik.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA hotplug from the user side ?
References: <1168588629.5403.7.camel@localhost>	 <45A7BFB0.9090308@garzik.org> <1168639639.3707.6.camel@localhost>	 <45A83C22.6050409@gmail.com> <1168672966.3707.24.camel@localhost>
In-Reply-To: <1168672966.3707.24.camel@localhost>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:
> Jeff & Tejun thanks *a lot* for clarifying this. I am quite happy to see
> that this is working very reliably!

You're welcome.  :-)

>>> These messages sound eval - so now the question is should I care ?
>>> ( On the other hand it did not crash the machine )
>> So, no, you don't really have to care.  Just make sure the device is
>> unmounted prior to unplugging.
> 
> OK, but then this really should be in the SATA hotplug FAQ (or can one
> fix this somehow?)... No user will ignore messages like this. What is

Yeah, probably.  Care to submit patch to FAQ to Jeff?

> especially annoying is that udev on the first remove/insert cycle
> created a new device node so the disk became /dev/sde (was /dev/sdd):
> dmesg output of reinserting the disk 2 times follows:

That's because something is still holding onto /dev/sdd.  The device
remains dangled until all references to it are gone.  /dev/sdd is still
lingering when the drive is hotplugged; thus, it gets assigned the next
device.

I think this is best solved by udev.  Think of /dev/sdX as kernel
internal name which may change from time to time.  Mount devices with
LABEL's and use udev-provided persistent names to access removable
devices.  Also, libata can be improved to tell udev that certain ports
are external, I think.

Thanks.

-- 
tejun
