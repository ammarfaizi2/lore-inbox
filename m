Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWIETQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWIETQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWIETQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:16:34 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:44001 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030259AbWIETQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:16:32 -0400
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
From: Marcel Holtmann <marcel@holtmann.org>
To: Victor Hugo <victor@vhugo.net>
Cc: linux-kernel@vger.kernel.org, Victor Castro <victorhugo83@yahoo.com>,
       Jon Masters <jonathan@jonmasters.org>
In-Reply-To: <508B6A67-CA5B-4A81-B868-BF8A03D78888@vhugo.net>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
	 <1157441620.24916.5.camel@localhost>
	 <508B6A67-CA5B-4A81-B868-BF8A03D78888@vhugo.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 21:16:20 +0200
Message-Id: <1157483780.5963.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

> > actually it has never been really a filename. It was a simple pattern
> > that the initial hotplug script and later the udev script mapped  
> > 1:1 to
> > a filename on your filesystem. If you check the mailing list  
> > archives of
> > LKML and linux-hotplug you will see that I always resisted in allowing
> > drivers to include a directory path in that call. A couple of people
> > tried this and it is not what it was meant to be.
> >
> > The MODULE_FIRMWARE approach simply makes this pattern visible via
> > modinfo, because otherwise you would have to scan the source code to
> > find this pattern. And to make it use you have to apply the same  
> > policy
> > the firmware script is applying when choosing the file. Currently this
> > is a 1:1 mapping.
> 
> You're right, I should have been more specific when I said  
> "filename", I really meant a 1:1 mapping to a file in /lib/firmware.
> 
> My question is, should we have a generic 1:1 mapping and make it  
> visible through MODULE_FIRMWARE.

please re-read my email and the initial thread about MODULE_FIRMWARE.
The MODULE_FIRMWARE extension only export the pattern used by
request_firmware(), because otherwise some tools don't know what a
kernel driver actually expects.

It happens to be a 1:1 mapping, but that is pure coincidence and a
little bit of laziness from the early users (mainly me) when providing
the first firmware script for the hotplug package. For all my drivers, I
don't need any fancy mapping.

>   Or like Jon Masters suggested have specific version numbers in the  
> pattern and have them map to specific versions in /lib/firmware and  
> make them all visible through MODULE_FIRMWARE.  I believe the  
> reasoning behind this was to make packaging drivers easier.

No. We need to make the actual file for loading the firmware appear
under the device in sysfs. So the userspace can read extra information
from the driver or device and then make its decision on which firmware
to load.

> I believe that we should have a generic mapping in the driver (i.e,  
> "firmware.bin") and let the admin or the userspace hotplug scripts  
> take care of filename policy with a link to the correct firmware  
> version.
> 
> example :
> 
> firmware.bin -> firmware-xyz.bin
> 
> The main reason for not including speciic mapping in the driver is  
> that everytime a new firmware version is released the driver has to  
> be updated and recompiled.  Its much easier to change a hotplug script.

I say, leave this up to the driver. For a couple of drivers this works
perfectly fine and I don't see any need to change my drivers and make
them more complex if it is not needed.

>From my point I don't see any advantage to make firmware loading more
complex from the kernel perspective. All this weird stuff needs to be
done in userspace. Our current way works quite good for a number devices
that need binary firmware.

I think it is better to first collect the needs of the driver authors
and make sure they understand their own needs. This is not always true.
And then we can discuss any extensions to change something. And I prefer
to have actual hardware and their drivers as an example.

The MODULE_FIRMWARE() extension is an easy and simple extension that
goes along with the current idea of request_firmware().

Regards

Marcel


