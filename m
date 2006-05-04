Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWEDVaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWEDVaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWEDVaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:30:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751408AbWEDVaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:30:12 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Peter Jones <pjones@redhat.com>
To: Martin Mares <mj@ucw.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <mj+md-20060504.211425.25445.atrey@ucw.cz>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
	 <1146776736.27727.11.camel@localhost.localdomain>
	 <mj+md-20060504.211425.25445.atrey@ucw.cz>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Thu, 04 May 2006 17:29:57 -0400
Message-Id: <1146778197.27727.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 23:17 +0200, Martin Mares wrote:
> Hello!
> 
> > > This is yet another way that user space can mess up the kernel. If VGA
> > > routing is changes under fbdev (my attribute notifies fbdev, the fbdev
> > > code for processing the notification did get checked in) then the
> > > console will screw up.
> > 
> > And this change allows userland to avoid doing that.
> 
> Could you explain how?  I don't see how adding a "enable" attribute
> to sysfs can solve these problems.

By allowing tools to read the rom from the pci device itself, instead of
whichever device's rom happens to be at 0xC0000.  libx86emul allows you
to define routines that it uses for memory access, so you can copy the
ROM out to normal memory, and map that memory to the appropriate address
that way.  X and vbetool both already have to do this, but without
copying the firmware image, to do DDC probing on x86_64.

> I agree with Arjan that the attribute could be useful for some special
> tools, but using it in X is likely to be utterly wrong.

I'm actually talking about vbetool here, though X could use these
methods.  Indeed, libx86emul comes from X itself.

-- 
  Peter

