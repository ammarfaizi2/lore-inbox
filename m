Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268019AbTBWVOZ>; Sun, 23 Feb 2003 16:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268548AbTBWVOZ>; Sun, 23 Feb 2003 16:14:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39175 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268019AbTBWVOY>; Sun, 23 Feb 2003 16:14:24 -0500
Date: Sun, 23 Feb 2003 21:24:32 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Scott Murray <scottm@somanetworks.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
Message-ID: <20030223212432.J20405@flint.arm.linux.org.uk>
Mail-Followup-To: Scott Murray <scottm@somanetworks.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com> <Pine.LNX.4.44.0302231531450.2559-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302231531450.2559-100000@rancor.yyz.somanetworks.com>; from scottm@somanetworks.com on Sun, Feb 23, 2003 at 04:01:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 04:01:10PM -0500, Scott Murray wrote:
> Having beaten out something roughly similiar for the cPCI hotplug code, 
> I have a couple of comments:
> 1) The description of pci_remove_bus_device says "informing the drivers 
>    that the device has been removed", yet unless I'm missing some sysfs
>    wrinkle, no call will be made to an attached driver's remove callback.

pci_remove_all_bus_devices => pci_remove_bus_device =>
 pci_remove_device => device_unregister => device_del =>
  bus_remove_device => device_release_driver => driver->remove

> 2) The recursive bus handling in pci_remove_bus_device should probably 
>    call pci_proc_detach_bus

Good catch - I'll create a new patch for Monday.

>    and potentially should also update the parent bridge's subordinate
>    field.

Yes - I think this is something we may consider when sorting out the
insertion.

However, whether x86 PCs will survive bus renumbering or not remains to
be seen.  We currently try to leave as much of the configuration intact
from the BIOS.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

