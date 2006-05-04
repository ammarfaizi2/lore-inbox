Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWEDTM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWEDTM0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWEDTM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:12:26 -0400
Received: from fmr20.intel.com ([134.134.136.19]:16849 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750826AbWEDTMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:12:25 -0400
Message-ID: <445A51F1.9040500@linux.intel.com>
Date: Thu, 04 May 2006 21:11:45 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, pjones@redhat.com
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace
 (Xorg) to enable devices without doing foul direct access
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <1146301148.3125.7.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0604291001490.2080@skynet.skynet.ie> <200605041309.53910.bjorn.helgaas@hp.com>
In-Reply-To: <200605041309.53910.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> On Saturday 29 April 2006 03:04, Dave Airlie wrote:
>>> This patch adds an "enable" sysfs attribute to each PCI device. When read it
>>> shows the "enabled-ness" of the device, but you can write a "0" into it to
>>> disable a device, and a "1" to enable it.
>>>
>>> This later is needed for X and other cases where userspace wants to enable
>>> the BARs on a device (typical example: to run the video bios on a secundary
>>> head). Right now X does all this "by hand" via bitbanging, that's just evil.
>>> This allows X to no longer do that but to just let the kernel do this.
> 
> I'm all in favor of cleaning up X.  But making the X code prettier without
> changing the underlying issues of claiming and sharing resources doesn't
> help much.  In fact, I suspect the ultimate plan for X does not involve
> an "enable" attribute in sysfs, so this may just introduce ABI cruft that
> will be difficult to remove later.

it goes well beyond X. Things like vbetool need this too to get to the content
of the rom for example. There are several other such cases...
