Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUJ0BdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUJ0BdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 21:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUJ0BdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 21:33:08 -0400
Received: from jpnmailout02.yamato.ibm.com ([203.141.80.82]:7645 "EHLO
	jpnmailout02.yamato.ibm.com") by vger.kernel.org with ESMTP
	id S261531AbUJ0BdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 21:33:02 -0400
In-Reply-To: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Subject: Re: [ACPI] [Proposal]Another way to save/restore PCI config space for
 suspend/resume
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, greg@kroah.com,
       Len Brown <len.brown@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
X-Mailer: Lotus Notes Release 6.0.2CF2 July 23, 2003
Message-ID: <OF7E38C2D0.FC23B846-ON49256F3A.000672D1-49256F3A.0007BB88@jp.ibm.com>
From: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Date: Wed, 27 Oct 2004 10:32:18 +0900
X-MIMETrack: Serialize by Router on D19ML115/19/M/IBM(Release 6.51HF338 | June 21, 2004) at
 2004/10/27 10:32:19
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi,

acpi-devel-admin@lists.sourceforge.net wrote on 2004/10/26 13:50:57:

> Hi,
> We suffer from PCI config space issue for a long time, which causes many
> system can't correctly resume. Current Linux mechanism isn't sufficient.
> Here is a another idea:
> Record all PCI writes in Linux kernel, and redo all the write after
> resume in order. The idea assumes Firmware will restore all PCI config
> space to the boot time state, which is true at least for IA32.
>

I think a basic problem of current Linux device model is that there is no
effective message path from sibling devices to their root device.
Although the message direction from a root device to sibling devices is
natural from the viewpoint of device enumeration, the direction from
sibling devices to a root device is required for effective arbitration for
device configuration and power management.

The Windows driver model uses the direction from sibling drivers to a root
bus driver mainly, i.e. sibling drivers are layered on a root bus driver.
While we need a kind of callback mechanism from PCI (sibling) devices to
PCI bus (root) device instead because their normal call interface is from a
root device to sibling devices.

- Hiro.

