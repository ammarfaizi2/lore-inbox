Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWEDT0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWEDT0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWEDT0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:26:43 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:62132 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030298AbWEDT0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:26:42 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Thu, 4 May 2006 13:26:36 -0600
User-Agent: KMail/1.8.3
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, pjones@redhat.com
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <200605041309.53910.bjorn.helgaas@hp.com> <445A51F1.9040500@linux.intel.com>
In-Reply-To: <445A51F1.9040500@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605041326.36518.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 May 2006 13:11, Arjan van de Ven wrote:
> Bjorn Helgaas wrote:
> > On Saturday 29 April 2006 03:04, Dave Airlie wrote:
> >>> This patch adds an "enable" sysfs attribute to each PCI device. When read it
> >>> shows the "enabled-ness" of the device, but you can write a "0" into it to
> >>> disable a device, and a "1" to enable it.
> >>>
> >>> This later is needed for X and other cases where userspace wants to enable
> >>> the BARs on a device (typical example: to run the video bios on a secundary
> >>> head). Right now X does all this "by hand" via bitbanging, that's just evil.
> >>> This allows X to no longer do that but to just let the kernel do this.
> > 
> > I'm all in favor of cleaning up X.  But making the X code prettier without
> > changing the underlying issues of claiming and sharing resources doesn't
> > help much.  In fact, I suspect the ultimate plan for X does not involve
> > an "enable" attribute in sysfs, so this may just introduce ABI cruft that
> > will be difficult to remove later.
> 
> it goes well beyond X. Things like vbetool need this too to get to the content
> of the rom for example. There are several other such cases...

There's already a "rom" file in sysfs.  Could vbetool and friends
use that?

How do vbetool and X coordinate their usage of "enable"?  What if we
throw an in-kernel VGA driver into the mix?  But I guess Jon has asked
all these questions before; I just didn't get warm fuzzies that there
were safe, maintainable answers.
