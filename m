Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVAFHvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVAFHvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 02:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVAFHvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 02:51:38 -0500
Received: from fmr19.intel.com ([134.134.136.18]:54474 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262763AbVAFHvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 02:51:35 -0500
Subject: Re: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
From: Li Shaohua <shaohua.li@intel.com>
To: Len Brown <len.brown@intel.com>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@suse.cz>, Adam Belay <ambx1@neo.rr.com>
In-Reply-To: <1104984055.18173.239.camel@d845pe>
References: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
	 <1104984055.18173.239.camel@d845pe>
Content-Type: text/plain
Message-Id: <1104997834.22886.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 15:50:34 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 12:00, Len Brown wrote:
> I think we'll save some significant power when ACPI D-states
> are invoked for the devices that supply them.  While many
> PCI devices support PCI power management and thus don't need/use
> ACPI D-states, I think it will be even more important to add
> this functionality to the legacy devices which never have
> PCI power management and thus always depend on ACPI for D-states.
It's easy to link the PNP devices with the ACPI devices with the ACPIPNP
driver. But the PNP driver core hasn't similar routines as
'pnp_set_power_state'. Unclear if the PNP drivers support
suspend/resume.

> It looks like some device drivers scribble on dev->platform_data;
> and we need to fix those drivers before deploying this patch.
> Alternatively, we could add a new field to struct device,
> but then we'd probably never get rid of it...
Yep, this is a big problem. According to the comments in the source
file, it's designed for firmware such as ACPI, but some drivers misused
it. A search shows there are many such drivers. Fixing the drivers is a
pain for me.

> I'm a little unformforable with platform_notify
> and platform_notify_remove available as globals.
> We should probably BUG_ON if we
> find them set before ACPI writes on them.
I will fix it.

> We'll need to update this patch to handle erroneous
> but real platforms that don't have _BBN
> by using _CRS to get PCI bus number.
That's ok.

> Unclear to me if/how this association of ACPI capability
> should be reflected in the sysfs device tree.
Possibly both the physical devices and ACPI devices have a link in sysfs
to pointer partners.

Thanks,
Shaohua

