Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWALPTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWALPTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWALPTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:19:19 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:56987 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030445AbWALPTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:19:18 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
To: xen-devel@lists.xensource.com
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
Date: Thu, 12 Jan 2006 15:06:33 +0000
User-Agent: KMail/1.9.1
Cc: Dave Hansen <haveblue@us.ibm.com>, Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       "Mike D. Day" <ncmike@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com> <00466d4b0eb7fe1603cd7f54448d37ff@cl.cam.ac.uk> <1137078863.5397.15.camel@localhost.localdomain>
In-Reply-To: <1137078863.5397.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121506.34029.mark.williamson@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a good set of questions. We have about half dozen files in
> > /proc/xen right now. One is an obvious canididate to stick in /dev, as
> > it has primarily an ioctl() interface.
>
> Actually, anything with an ioctl interface is probably a good cantidate
> for a writable sysfs file.  The basic idea is that we prefer something
> in sysfs with a discrete, unique name.  It also makes it a lot easier to
> develop with because you can look at the values from scripts, and you
> don't have to worry about synchronizing any headers.
>
> So, what kind of ioctls are we talking about?

The privcmd ioctl()s are used for userspace to invoke the Xen hypercalls for 
management operations, they generally pass through an mlock'ed struct 
describing the operation, for inspection by the hypervisor's management code.  
I'd describe it as more like a "hypercall device" than anything else.

Cheers,
Mark

> > The remainder are static, are
> > read-only or read-write with ascii text, and we don't want hotplug
> > events and other baggage.
>
> There really isn't much "baggage" that a static file carries around.
> All you have to do is omit filling in a function pointer.  Hotplug
> events are one of those "for free" things that you get.
>
> > Maybe making these attributes of a Xen system device makes sense. Are
> > there examples in the kernel of other subsystems/modules with a similar
> > miscellaneous set of files?
>
> drivers/base/memory.c has a couple of little things.  A writable probe
> file, and a somewhat miscellaneous file for representing the units that
> are being dealt with.  Might be a place to start.  I can certainly
> answer questions about it.  I would also suggest just doing a "find" or
> "tree" on a few of your systems and looking for people that do similar
> things to what you want.
>
> I know I struggled to get the memory hotplug sysfs code to work at
> first, but the code has been very, very low maintenance.
>
> -- Dave
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel

-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
