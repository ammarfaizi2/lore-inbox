Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWBFNQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWBFNQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWBFNQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:16:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59098 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932080AbWBFNQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:16:07 -0500
Date: Mon, 6 Feb 2006 14:15:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Carlson Accardi <kristenc@cs.pdx.edu>
Cc: pcihpd-discuss@lists.sourceforge.net, greg@kroah.com, len.brown@intel.com,
       linux-kernel@vger.kernel.org, muneda.takahiro@jp.fujitsu.com,
       linux-acpi@vger.kernel.org
Subject: Re: [patch] acpiphp: handle dock stations
Message-ID: <20060206131550.GA1538@elf.ucw.cz>
References: <20060201233005.GA4999@nerpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201233005.GA4999@nerpa>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: kristen.c.accardi@intel.com
> 
> This patch will add hot add/remove of docking stations to acpiphp.  Because
> some docking stations will have a _DCK method that is not associated with
> a dock bridge, we use the _EJD method to determine which devices are 
> dependent on the dock device, then try to find which of these dependent
> devices are pci devices.  We register a separate event handler with acpi
> to handle dock notifications, but if we have discovered any pci devices
> dependent on the dock station, we notify the acpiphp driver to rescan
> the correct bus.  If no pci devices are found, but there is still a _DCK method
> present, the driver will stay loaded to deal with the dock notifications.

It still registers my docking bridge as -1:

acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
acpiphp: Slot [4294967295] registered
acpiphp_ibm: ibm_find_acpi_device:  Failed to get device
information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device
information<3>acpiphp_ibm: ibm_find_acpi_device:  Failed to get device
information<3>acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace
failed
radeonfb: Retrieved PLL infos from BIOS

...which is still better than not registering it at all :-).

This one actually does not oops at insertion into dock. Good!

It detects insertion into dock:

Feb  6 14:13:00 amd kernel: acpi_bus-0073 [62] bus_get_device        :
No context for object [c1d2c408]
Feb  6 14:13:01 amd kernel: PCI: Bus 3, cardbus bridge: 0000:02:00.0
Feb  6 14:13:01 amd kernel:   IO window: 00004000-000040ff
Feb  6 14:13:01 amd kernel:   IO window: 00004400-000044ff
Feb  6 14:13:01 amd kernel:   PREFETCH window: e8000000-e9ffffff
Feb  6 14:13:01 amd kernel:   MEM window: c2000000-c3ffffff
Feb  6 14:13:01 amd kernel: PCI: Bus 7, cardbus bridge: 0000:02:00.1
Feb  6 14:13:01 amd kernel:   IO window: 00004800-000048ff
Feb  6 14:13:01 amd kernel:   IO window: 00004c00-00004cff
Feb  6 14:13:01 amd kernel:   PREFETCH window: ea000000-ebffffff
Feb  6 14:13:01 amd kernel:   MEM window: c4000000-c5ffffff

When I press eject button, I get

Feb  6 14:13:27 amd kernel: acpi_bus-0073 [72] bus_get_device        :
No context for object [c1d2c408]

and dock fan stops (but machine is not unlocked):

root@amd:/sys/bus/pci/slots/4294967295# cat *
0
0000:02:03
cat: attention: Invalid argument
0
0

...but I can't remove machine.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
