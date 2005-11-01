Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVKADJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVKADJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVKADJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:09:38 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:61017 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964797AbVKADJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:09:37 -0500
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Date: Mon, 31 Oct 2005 19:09:32 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com> <200510311741.56638.david-b@pacbell.net> <1130812903.29054.408.camel@gaston>
In-Reply-To: <1130812903.29054.408.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311909.32694.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 6:41 pm, Benjamin Herrenschmidt wrote:
> 
> > No PCI quirk code has ever called pci_enable_device() AFAICT.
> 
> Most PCI quirks only do config space accesses

Some do I/O space access.  Few do memory space access (ioremap_nocache).


> > Of course the _need_ to do such a thing might be another PPC-specific
> > (or OpenFirmware-specific?) PCI thing ... we've hit other cases where
> > PPC breaks things that work on other PCI systems (and vice versa).
> 
> "ppc" doens't do anything fancy that other archs don't do too, please
> stop with your "ppc specific" thing all over the place.

When the only problem reports come from PPC hardware, it sure looks
PPC-specific to me.  If such issues get reported on non-PPC hardware
(with those unique-to-ppc changes to PCI enumeration) then I'll stop
thinking of it as PPC-specific.  Until then ... ;)


> It is illegal, whatever the platform is, to tap a PCI device MMIO like
> that without calling pci_enable_device(), requesting resources etc... or
> at the very least, testing if MMIO decoding is enabled on the chip.
> Period. It has nothing to do with PPC and all to do with correctness.

I could easily believe that all that quirk code has been buggy since
day one, yes.  Certainly it's always had bugs in how it dealt with the
USB functionality; so why shouldn't it have bugs in how it deals with
the PCI functionality too?  Even if it was being maintained by the
PCI maintainers!


> > > I'm not sure it's legal to do pci_enable_device() from within a pci
> > > quirk anyway. I really wonder what that code is doing in the quirks, I
> > > don't think it's the right place, but I may be wrong.
> > 
> > Erm, what "code is doing" what, that you mean ??
> 
> What _That_ code is doing in the quirks... shouldn't it be in the
> {U,O,E}HCI drivers instead ?

Not for PCI.  Vojtech, this is your cue to explain some of how late handoff
borks the input layer, as observed by SuSE on way too many BIOS/hardware combos
for me to remember ... :)


> > > What is the logic supposed to be there ?
> > 
> > Which logic?  The fundamental thing those USB handoff functions do
> > is make sure that BIOS code lets go of the host controllers.  The
> > main reason it'd be using a controller is because of USB keyboards,
> > mice, or maybe boot disks.  Secondarily, that code needs to make
> > sure the controller is really quiesced before Linux starts using it.
> 
> So you rant about "ppc specific" whatever while the entire point of this
> code is to workaround x86 specific BIOS junk ...

Actually any "sophisticated" boot loader nowadays will know something
about USB, to handle keyboards, mice, or maybe boot disks.  (Didn't I
just write that?)  On some platforms, u-Boot understands OHCI ... so that's
not just x86 BIOS or other closed-source firmware.  (Though to be sure,
that u-Boot code acts more like Linux 2.4 than anything else; it doesn't
follow the standard firmare-uses-USB rules.)  And I sure thought some of
the OpenFirmware systems had USB support too.  (Written in FORTH?)

- Dave

