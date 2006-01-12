Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWALPhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWALPhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWALPhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:37:41 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:9453 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751397AbWALPhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:37:40 -0500
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Dave Hansen <haveblue@us.ibm.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, xen-devel@lists.xensource.com,
       "Mike D. Day" <ncmike@us.ibm.com>, Greg KH <greg@kroah.com>
In-Reply-To: <5ae8261aff3d780b6594683c1d118bbd@cl.cam.ac.uk>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
	 <43C5A199.1080708@us.ibm.com>
	 <1137029574.11331.11.camel@localhost.localdomain>
	 <00466d4b0eb7fe1603cd7f54448d37ff@cl.cam.ac.uk>
	 <1137078863.5397.15.camel@localhost.localdomain>
	 <5ae8261aff3d780b6594683c1d118bbd@cl.cam.ac.uk>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 07:37:22 -0800
Message-Id: <1137080242.5397.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 15:26 +0000, Keir Fraser wrote:
> On 12 Jan 2006, at 15:14, Dave Hansen wrote:
> 
> >> This is a good set of questions. We have about half dozen files in
> >> /proc/xen right now. One is an obvious canididate to stick in /dev, as
> >> it has primarily an ioctl() interface.
> >
> > Actually, anything with an ioctl interface is probably a good cantidate
> > for a writable sysfs file.  The basic idea is that we prefer something
> > in sysfs with a discrete, unique name.  It also makes it a lot easier 
> > to
> > develop with because you can look at the values from scripts, and you
> > don't have to worry about synchronizing any headers.
> >
> > So, what kind of ioctls are we talking about?
> 
> They are pretty low level. e.g., pass-thru a raw hypercall direct to 
> xen, map another VM's pages into my address space (given a list of page 
> frames), etc. very strongly binary, and unlikely to be useful for 
> scripting.

The ppc64 hypervisor does something like this today in a couple of
places.  It is kinda a mess.  I think that putting a generic, binary
firmware interface leads to having a bit of a crutch.  It basically lets
the userspace software stack bypass Linux and talk directly to the
hypervisor.  It also means that you have to have a very specialized
software stack for each hypervisor or virtualization type, which is very
bad.

This pushes things out to userspace, which is generally good.  But, it
is pushing behavior and "hardware" knowledge out there, too.  The
hardware knowledge, especially, is something that we usually try to
encapsulate.

Also things like inter-partition page sharing, and partition migration
are used in other hypervisors.  I think it is essential to get common
interfaces to those things.

One last thing...  When you say "very strongly binary" do you mean, "are
implemented now as very strongly binary", or "absolutely 100% have to be
horribly strongly binary"?  They are two quite different things. :)

-- Dave

