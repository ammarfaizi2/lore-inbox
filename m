Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbUKPG0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUKPG0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUKPG0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:26:49 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:30119 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261917AbUKPG0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:26:47 -0500
Date: Tue, 16 Nov 2004 01:24:33 -0500
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       matthieu castet <castet.matthieu@free.fr>, bjorn.helgaas@hp.com,
       vojtech@suse.cz, "Brown, Len" <len.brown@intel.com>, greg@kroah.com
Subject: Re: [PATCH] PNP support for i8042 driver
Message-ID: <20041116062433.GH29574@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
	matthieu castet <castet.matthieu@free.fr>, bjorn.helgaas@hp.com,
	vojtech@suse.cz, "Brown, Len" <len.brown@intel.com>, greg@kroah.com
References: <41960AE9.8090409@free.fr> <200411140148.02811.dtor_core@ameritech.net> <20041116053741.GD29574@neo.rr.com> <200411160106.46673.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411160106.46673.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 01:06:46AM -0500, Dmitry Torokhov wrote:
> Adam,
> 
> I agree with your point that every device in the system should have a
> driver attached. And i8042 does have one bound to it. It is i8042 platform
> driver that does power management and ensures proper integration into driver
> model.
> 
> There is no need to keep secondary "drivers" around, their sole purpose is
> to provide information about avalilable resources. It would be ok if the
> code was shared among several devices on a bus but for most (all?) legacy
> devices it has to be programmed explicitely and will not be reused.

Platform drivers are secondary drivers.  They're crude hacks used to get a
minimal device into the driver model.  They're necessary because ISA devices
cannot be detected like other types of devices.  Why not use a system with
actual complete bus functionality like ACPI?  If ACPI is available, then there
should be no need to create a platform device.

> 
> Also i8042 should not rely on either ACPI or PNP simply because the driver/
> chip works on boxes other than x86/ia64 so we can't make ACPI or PNP drivers
> "main" ones. 

No, but they should take priority when they are available.  Don't forget that
there is also Open Firmware, which has similar functionalility to ACPI if I
understand correctly.

> 
> As far as binding/rebinding goes I guess sysdevs and platform devices will
> just disable this functionality.

Exactly, they have limits because they are not real devices.  ACPI devices are
real devices.  They have resource management capabilities, power dependencies,
physical parents, and other features found in buses like PCI.

Thanks,
Adam
