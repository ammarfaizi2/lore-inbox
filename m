Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTEIByZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 21:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTEIByZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 21:54:25 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:17672 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262271AbTEIByY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 21:54:24 -0400
Message-ID: <1052446008.3ebb0d382f6af@webmail.jordet.nu>
Date: Fri,  9 May 2003 04:06:48 +0200
From: Stian Jordet <liste@jordet.nu>
To: David van Hoose <davidvh@cox.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: ACPI conflict with USB
References: <3EBADF3C.1040609@cox.net> <20030509002240.GA4328@kroah.com> <1052444521.3ebb076946267@webmail.jordet.nu> <3EBB0A95.20902@cox.net>
In-Reply-To: <3EBB0A95.20902@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sitat David van Hoose <davidvh@cox.net>:

> Stian Jordet wrote:
> > Sitat Greg KH <greg@kroah.com>:
> > 
> > 
> >>On Thu, May 08, 2003 at 05:50:36PM -0500, David van Hoose wrote:
> >>
> >>>I'm wondering if there is any work towards correcting the ACPI conflict 
> >>>with USB. On my system, I cannot use any USB devices due to a timeout 
> >>>anytime I use ACPI with my kernel. Other people have noticed this 
> >>>happening on their systems as well, so I am assuming it isn't just on my
> 
> >>>system.
> >>
> >>Have you tried the latest 2.5 kernels?  I think this is fixed in 2.5.69
> >>for the majority of people.  Also, does booting with "noapic" work for
> >>you?
> > 
> > 
> > If it is supposed to have been fixed in 2.5.69, that must be the reason
> usb
> > stopped working with acpi on 2.5.69 for me. Worked fine with 2.5.68.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=105216850332081&w=2
> > 
> > Only three days since I reported it, and you say it is fixed? Gee.
> > 
> > David: The consensus on acpi-devel is to report it in bugzilla, and see
> what
> > happens.
> 
> I'm using kernel 2.5.69-bk3 with this recent test. Booted with noapic, 
> and I get thousands of lines of APIC errors. I still get the 'bulk_msg: 
> timeout' with USB though.
> This hasn't ever worked for me. First tried with 2.5.54. I don't think I 
> tried 2.5.68. Should I and see if it was something in a patch to 2.5.69?

Originally I never got usb to work with acpi, until one day I found out that
irq12 needed to be in use (!). If I booted with a ps/2 mouse, it worked perfect.
After some investigation, I found out that my BIOS had a setting for PS/2 mouse,
which were disabled, enabled and auto. Auto were the default. The irq 12 was
only reserved when there was a mouse at boot. If I set it at enabled, it always
reserved irq 12. After I found this out, usb worked perfect untill 2.5.69.

My motherboard is a Asus CUV266-DLS, Dual P3. Why irq12 has to be enabled, I
have never understood. 

As a curiosity, I might tell you that when I boot my motherboard with MPS1.4
enabled, I have to disable the secondary ide port to get it to boot Linux. BUT,
when I do that, usb doesn't work (without acpi). So I have to use MPS1.1 and
have the secondary ide port enabled to get usb working without acpi. It was
better with 2.5.68 :( I guess this is just my motherboard being fscked up, but
other OS' boot fine, regardless of PS/2 mouse and/or secondary IDE port enabled.

Best regards,
Stian
