Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWEDTJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWEDTJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWEDTJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:09:59 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:63712 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750825AbWEDTJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:09:58 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Thu, 4 May 2006 13:09:53 -0600
User-Agent: KMail/1.8.3
Cc: Dave Airlie <airlied@linux.ie>, Arjan van de Ven <arjan@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, pjones@redhat.com
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> <1146301148.3125.7.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0604291001490.2080@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0604291001490.2080@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605041309.53910.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 03:04, Dave Airlie wrote:
> > This patch adds an "enable" sysfs attribute to each PCI device. When read it
> > shows the "enabled-ness" of the device, but you can write a "0" into it to
> > disable a device, and a "1" to enable it.
> >
> > This later is needed for X and other cases where userspace wants to enable
> > the BARs on a device (typical example: to run the video bios on a secundary
> > head). Right now X does all this "by hand" via bitbanging, that's just evil.
> > This allows X to no longer do that but to just let the kernel do this.

I'm all in favor of cleaning up X.  But making the X code prettier without
changing the underlying issues of claiming and sharing resources doesn't
help much.  In fact, I suspect the ultimate plan for X does not involve
an "enable" attribute in sysfs, so this may just introduce ABI cruft that
will be difficult to remove later.

> This would allow me to remove the issue in X where loading the DRM at X 
> startup acts differently than loading the DRM before X runs, due to Xs PCI 
> probe running in-between... with this I can just enable all VGA devices 
> and no worry whether they have a DRM or not..

This seems to be the main justification for the patch.  But I don't know
enough about X and DRM to understand it, or why this patch is the best
way to solve it.

I think Jon has a pretty convincing argument, which I *do* understand.
Can you expand on this justification?  Do you envision long-term usage
of the sysfs "enable" attribute?

Bjorn
