Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbUJ0C0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbUJ0C0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUJ0C0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:26:55 -0400
Received: from jpnmailout02.yamato.ibm.com ([203.141.80.82]:7150 "EHLO
	jpnmailout02.yamato.ibm.com") by vger.kernel.org with ESMTP
	id S261560AbUJ0C0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:26:53 -0400
In-Reply-To: <1098842129.12477.2.camel@sli10-desk.sh.intel.com>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space	for
 suspend/resume
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, greg@kroah.com,
       Len Brown <len.brown@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
X-Mailer: Lotus Notes Release 6.0.2CF2 July 23, 2003
Message-ID: <OF96A27AFE.EC89615C-ON49256F3A.000B5394-49256F3A.000CB5DB@jp.ibm.com>
From: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Date: Wed, 27 Oct 2004 11:26:40 +0900
X-MIMETrack: Serialize by Router on D19ML115/19/M/IBM(Release 6.51HF338 | June 21, 2004) at
 2004/10/27 11:26:40
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> >
> > I think a basic problem of current Linux device model is that there is
no
> > effective message path from sibling devices to their root device.
> > Although the message direction from a root device to sibling devices is
> > natural from the viewpoint of device enumeration, the direction from
> > sibling devices to a root device is required for effective arbitration
for
> > device configuration and power management.
> >
> > The Windows driver model uses the direction from sibling drivers to a
root
> > bus driver mainly, i.e. sibling drivers are layered on a root bus
driver.
> > While we need a kind of callback mechanism from PCI (sibling) devices
to
> > PCI bus (root) device instead because their normal call interface is
from a
> > root device to sibling devices.
> Hiro-san,
> I don't really understand why this is related with suspend/resume. Could
> you please explain it more clearly?
>
Hi,

What I mean is that:

There are some bridge devices to be supported by a driver for various
device types and vendors. In the long run PCI drivers will have power
dependency one another in the long run. It is natual that PCI bridge driver
reports its child devices and their dependency to PCI core because PCI core
driver needs to know power up/down sequence at suspend/resume time. So I
think callbacks from bridge-to-core is useful. Especially it is more useful
for the core to get exact timing to power up the next driver if some
devices have certain latency to power up.

- Hiro.

