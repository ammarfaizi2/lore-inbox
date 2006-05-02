Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWEBQOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWEBQOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWEBQOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:14:52 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:11430 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964910AbWEBQOv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:14:51 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Date: Tue, 2 May 2006 10:14:45 -0600
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
Message-Id: <200605021014.45684.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 April 2006 03:04, Dave Airlie wrote:
> 
> > This patch adds an "enable" sysfs attribute to each PCI device. When read it
> > shows the "enabled-ness" of the device, but you can write a "0" into it to
> > disable a device, and a "1" to enable it.
> >
> > This later is needed for X and other cases where userspace wants to enable
> > the BARs on a device (typical example: to run the video bios on a secundary
> > head). Right now X does all this "by hand" via bitbanging, that's just evil.
> > This allows X to no longer do that but to just let the kernel do this.
> >
> > Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> > CC: Peter Jones <pjones@redhat.com>
> > CC: Dave Airlie <airlied@linux.ie>
> 
> ACK
> 
> This would allow me to remove the issue in X where loading the DRM at X 
> startup acts differently than loading the DRM before X runs, due to Xs PCI 
> probe running in-between... with this I can just enable all VGA devices 
> and no worry whether they have a DRM or not..

This sysfs "enable" patch seems like goodness.

But I hope that when X uses this, it only enables & disables VGA
devices it's actually using.  In the past, it seems like X has
blindly disabled *all* VGA devices in the system, even though
they might be in use by another X server.  I'm sure that's all
well-understood and cleaned up now; just wanted to make sure
this nightmare didn't recur.
