Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVAXTHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVAXTHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAXTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:07:10 -0500
Received: from fmr19.intel.com ([134.134.136.18]:36069 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261571AbVAXTEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:04:22 -0500
Date: Mon, 24 Jan 2005 12:10:25 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200501242010.j0OKAPIr003363@snoqualmie.dp.intel.com>
To: greg@kroah.com
Subject: Re:[PATCH] PCI: add PCI Express Port Bus Driver subsystem
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 18, 2005 5:03 PM Greg KH wrote:
>> >
>> >That would be great, but it doesn't show up that way on my box.  All
>> >of
>> >the portX devices are in /sys/devices/ which is what I don't think
>> >you
>> >want.  I would love for them to have the parent of the pci_dev
>> >structure
>> >:)
>> 
>> Agree. Thanks for your inputs. The patch below include the changes
>> based on your previous post.
>
>Hm, that seems like a pretty big patch just to add a pointer to a parent
>device :)
>
>What really does this patch do?  What does the sysfs tree now look like?

Before changes:

The patch makes the parent of the device pointing to the pci_dev
structure. The parents portX devices are in /sys/devices which
should be removed based on your suggestions. Below is /sys/devices
before any changes made.

/sys/devices
	|
	__ ide0 
	|
	__ pci0000:00
	|
	__ pnp0
	|
	__ port1
	|	|
	|  	__ port1.00
	|	|
	|	__ port1.01
	|	.
	|	.
	|	.
	|
	__ port2
	|
 	__ port3
	|
	__ system

After changes:

The parents portX devices are no longer necessary because port1.00
and port1.01 devices shoud have the parent of the pci_dev structure
(based on your suggestion). The patch does the following changes:

- remove code creating and handling the parent portX devices.
- rename portX.YZ to pcieYZ (for example port1.00 renamed to pcie00)
  since portX is no longer needed.
- make pcieYZ have the parent of the pci_dev structure.

Below is /sys/devices after changes made to the patch.

/sys/devices
	|
	__ ide0 
	|
	__ pci0000:00
	|	|
	|	__ 0000:00:00.0
	|	|
	|	__ 0000:00:04.0
	|	|	|
	|	.	__ class
	|	.	|
	|	.	__ pcie00
	|		|
	|		__ pcie01
	|		.
	|		.	
	|		.
	|
	__ platform
	|
	__ pnp0
	|
	__ system


Please let me know what you think of the changes.

Thanks,
Long
