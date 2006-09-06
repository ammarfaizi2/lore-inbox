Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWIFQnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWIFQnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWIFQnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:43:46 -0400
Received: from fremont.jonmasters.org ([64.71.152.22]:47371 "EHLO
	fremont.jonmasters.org") by vger.kernel.org with ESMTP
	id S1751659AbWIFQnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:43:45 -0400
From: Jon Masters <jonathan@jonmasters.org>
To: Victor Hugo <victor@vhugo.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       Victor Castro <victorhugo83@yahoo.com>
In-Reply-To: <508B6A67-CA5B-4A81-B868-BF8A03D78888@vhugo.net>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
	 <1157441620.24916.5.camel@localhost>
	 <508B6A67-CA5B-4A81-B868-BF8A03D78888@vhugo.net>
Content-Type: text/plain
Organization: World Organi[sz]ation Of Broken Dreams
Date: Wed, 06 Sep 2006 17:42:51 +0100
Message-Id: <1157560971.5265.94.camel@perihelion>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 212.18.227.82
X-SA-Exim-Mail-From: jonathan@jonmasters.org
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
X-SA-Exim-Version: 4.2 (built Thu, 14 Apr 2005 16:52:54 +0000)
X-SA-Exim-Scanned: Yes (on fremont.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 11:26 -0700, Victor Hugo wrote:

> On Sep 5, 2006, at 12:33 AM, Marcel Holtmann wrote:
> >
> > actually it has never been really a filename. It was a simple pattern
> > that the initial hotplug script and later the udev script mapped  
> > 1:1 to a filename on your filesystem. If you check the mailing list  
> > archives of LKML and linux-hotplug you will see that I always resisted
> > in allowing drivers to include a directory path in that call. A couple
> > of people tried this and it is not what it was meant to be.

That's fine. I agree with the idea - *but* it strikes me that we don't
really have a co-ordinated database of what module "patterns" map to
what on-disk firmware, aside from hotplug/udev scripts. We need to
co-ordinate this stuff a lot more. Or am I missing something? I'm happy
to setup a database on the kerneltools.org wiki if that's useful...

[ I've got a plan to extend some of the stuff I've been looking at in
the Fedora space - and some of you won't like me for it :P Basically I
want to put a GUI in front of DKMS/kmods/other module packaging/firmware
update utilities and automatically locate/build/install third-party GPL
(but not yet upstream) drivers on non-moving target distros. Evil stuff
like that also would find knowing about external firmware useful. ]

> Or like Jon Masters suggested have specific version numbers in the  
> pattern and have them map to specific versions in /lib/firmware and  
> make them all visible through MODULE_FIRMWARE.  I believe the  
> reasoning behind this was to make packaging drivers easier.

The reasoning behind MODULE_FIRMWARE is because firmware names can be
dynamically generated in the module so we can't know what it's going to
need ahead of time. I'd like to hook this up with the PCI ID/etc. of the
hardware that needs that firmware - so we really only package the
mimimum, but I think that's overkill.

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

I'm trying to avoid the need to have lots of different places in
userland needing to track firmware versioning. But on some level, I just
need to know that a given driver is going to ask for 1 firmware with the
ID of "foo" - and a way to extrapolate where it is on disk to package.

Jon.


