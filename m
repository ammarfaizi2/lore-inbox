Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVG0SdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVG0SdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVG0Sa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:30:28 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:48507 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262447AbVG0S3k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:29:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H5Yv/uEICjJ9oeeiIZ7p4nIAoHldrW/PUQYJ9vEDUE8y6jcWxY1mVo3DTTg0YjCeRx6N1RBRADOLMhl7IVLU3gqishZ5lvzHot7tLpKJiwlWObfg7T8LVAId+4VXwv9mEGbf08D+j9l9MdphZ10fDE8f3TiE4yDhMjdZRB90jnA=
Message-ID: <512afbf905072711295f87ad24@mail.gmail.com>
Date: Wed, 27 Jul 2005 11:29:39 -0700
From: Kristen Accardi <kristen.kml@gmail.com>
Reply-To: Kristen Accardi <kristen.kml@gmail.com>
To: Rajat Jain <rajat.noida.india@gmail.com>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
In-Reply-To: <b115cb5f0507241949da02aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/05, Rajat Jain <rajat.noida.india@gmail.com> wrote:
> > On Tue, Jul 12, 2005 at 06:01:22PM +0900, Rajat Jain
> > wrote:
> >
> > > Hi,
> > >
> > > I'm trying to use the PCI Express Hot-Plug Controller driver
> > > (pciehp.ko) with Kernel 2.6 so that I can get hot-plug events
> > > whenever I add a card to my PCI Express slot.
> > >
> > > I built the driver as a module, and am trying to load it
> > > manually using modprobe. However, when trying to insert,
> > > I'm getting the following error:
> > >
> > > pciehp: acpi_pciehprm:\_SB.PCI0 _OSC fails=0x5
> > > pciehp: Both _OSC and OSHP methods do not exist
> > > FATAL: Error inserting pciehp
> > >
> > > (/lib/modules/2.6.9-5.18AXcustom-hotplug/kernel/drivers/pci/hotplug/pciehp.ko):
> > > No such device
> > >
> 
> > --- Greg KH <greg@kroah.com> wrote:
> > Your bios does not support pci express hotplug.  Are
> > you sure you have pci express hotplug hardware in your
> > system?  If so, contact your bios vendor to get an
> > updated version.
> >
> > Good luck,
> >
> >  greg k-h
> 
> Thanks for replying Greg. I checked again, I have the hardware in my
> system. I asked the vendor for bios update, but he says mine is the
> latest version.
> 
> I downloaded the Intel "iasl" compiler
> (http://developer.intel.com/technology/iapc/acpi/downloads.htm),  and
> used it to decompile "/proc/acpi/dsdt" file (in AML) to its equivalent
> ACPI source code. I could not find the _OSC and OSHP control methods
> there. Is this information sufficient enough to deduce that I need a
> BIOS update? And the hardware is OK but the problem is with the bios?
> 
> Just out of curosity, I would appreciate if you could provide me
> pointers to OSHP and _OSC methods. What exactly do they mean? Does
> every hardware containing a hot-plug controller necessarily has to
> implement them both? I checked with ACPI Specs but it contains no
> refrence to "OSHP" method.
> 
> Any pointers are more than appreciated,
> 
> TIA,
> 
> Rajat

Hi Rajat, you can learn more about the OSHP method by reading the PCI
express spec.  It is used to tell an ACPI bios that the OS will be
handling the hotplug events natively.  It may be that your BIOS does
not allow native hotplug for pcie, in which case you need to be using
the acpiphp driver instead of the pciehp driver.  You could just try
modprobing acpiphp and see if this will handle the hotplug events.  A
recent version of lspci (which understands pcie) will tell you as well
if pcie hotplug capability is supported (lspci -vv).

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
