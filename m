Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVCXLzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVCXLzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263094AbVCXLzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:55:02 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:3746 "HELO
	mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id S262790AbVCXLyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:54:54 -0500
Date: Thu, 24 Mar 2005 12:54:52 +0100
From: Peter Baumann <waste.manager@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug] invalid mac address after rebooting (kernel 2.6.11.5)
Message-ID: <20050324115452.GA5561@xp.machine.de>
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <20050323185225.11097185.akpm@osdl.org> <20050324110102.GA30711@faui00u.informatik.uni-erlangen.de> <20050324030751.6e150376.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324030751.6e150376.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 03:07:51AM -0800, Andrew Morton wrote:
> Peter Baumann <waste.manager@gmx.de> wrote:
> >
> > > 
> > > The only PCI change I see is
> > > 
> > > --- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
> > > +++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
> > > @@ -268,7 +268,7 @@
> > >                 return -EIO; 
> > >  
> > >         pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
> > > -       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
> > > +       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
> > >                 printk(KERN_DEBUG
> > >                        "PCI: %s has unsupported PM cap regs version (%u)\n",
> > >                        dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
> > > 
> > > and you're not getting that message (are you?)
> > > 
> > 
> > Reverting the above patch solved it. But _now_ I get the message.
> > (dmesg output with above patch reverted at the end of the mail)
> 
> Greg, help!
> 
> > > Nothing much in arch/i386..
> > > 
> > > There were some ACPI changes, which is always a worry ;) Does that machine
> > > run OK without ACPI support?  If so, could you determine whether disabling
> > > ACPI fixes things up?
> > >
> > Hm. I tried it with 2.6.11.5 by appending  acpi=off  at the cmdline but
> > as I remember it hasn't changed anything. Or do I have to specify
> > someting else at the commandline to deactivate acpi?
> 
> We like to change these things so people send us more email.
> 
> According to Documentation/kernel-parameters.txt, acpi=off should still work.
> 

Yes. That's were I was looking for :-)
Sorry for my bad english but I meant that switching acpi off did not
change anything releated to the bug. Of course it deactivates acpi.

Peter
