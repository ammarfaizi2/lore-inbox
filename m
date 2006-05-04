Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWEDVGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWEDVGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWEDVGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:06:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750752AbWEDVF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:05:59 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Peter Jones <pjones@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <200605041309.53910.bjorn.helgaas@hp.com>
	 <445A51F1.9040500@linux.intel.com>
	 <200605041326.36518.bjorn.helgaas@hp.com>
	 <E1FbjiL-0001B9-00@chiark.greenend.org.uk>
	 <9e4733910605041340r65d47209h2da079d9cf8fceae@mail.gmail.com>
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Thu, 04 May 2006 17:05:36 -0400
Message-Id: <1146776736.27727.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-04 at 16:40 -0400, Jon Smirl wrote:
> On 5/4/06, Matthew Garrett <mgarrett@chiark.greenend.org.uk> wrote:
> > Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> >
> > > There's already a "rom" file in sysfs.  Could vbetool and friends
> > > use that?
> >
> > Not if you have multiple graphics cards.
> 
> Not true, the rom attribute maps the ROM into PCI space where ever the
> kernel tells it to and reads it from there. It is the PCI VGA
> emulation feature that forces the ROM to appear at C000:0. You can
> have the ROM mapped and VGA emulation turned off.

It doesn't matter -- you can accomplish the same thing with e.g.
libx86emu and simply mapping the option rom to 0xc0000.  But you want to
do that in userland, not in the kernel.

> This brings up another major point. X changes the PCI VGA emulation
> routing from user space, another thing that it should not be doing. I
> have posted patches before providing a sysfs VGA attribute on class
> VGA devices. By setting the attribute to 1 you can control the active
> VGA emulation device.
> 
> This is yet another way that user space can mess up the kernel. If VGA
> routing is changes under fbdev (my attribute notifies fbdev, the fbdev
> code for processing the notification did get checked in) then the
> console will screw up.

And this change allows userland to avoid doing that.

> The usual screw up is that the console goes
> blank because hardware fonts are not setup correctly on the new
> console.

And that's completely unrelated to this problem.

-- 
  Peter

