Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWAIShn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWAIShn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWAIShn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:37:43 -0500
Received: from server5.web4a.de ([82.149.231.244]:25229 "EHLO server5.web4a.de")
	by vger.kernel.org with ESMTP id S1030239AbWAIShm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:37:42 -0500
Date: Mon, 9 Jan 2006 19:36:31 +0100
From: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       <linux-usb-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>,
       Leonid <nouser@lpetrov.net>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <Pine.LNX.4.44L0.0601091026200.5734-100000@iolanthe.rowland.org>
References: <200601090126.56831.dtor_core@ameritech.net>
	<Pine.LNX.4.44L0.0601091026200.5734-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.8.8; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E1Ew1sd-0000k3-00@mars.bretschneidernet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:

Hi Alan,

> On Mon, 9 Jan 2006, Dmitry Torokhov wrote:
> 
> > On Sunday 08 January 2006 16:23, Martin Bretschneider wrote:
> > > Hello,
> > > 
> > > Jens Nödler who has got the same motheboard (Gigabyte GA-K8NF-9
> > > with nforce4 chipset) can confirm my problem. But he found out
> > > that the keyboard connected to the ps/2 port does work with
> > > kernel 2.6.15 if "USB keyboard support" is disabled in the BIOS.
> > >
> > 
> > Ok, I an getting enough reports to conclude that the new
> > usb-handoff code does not seem to be working. Let's try CCing USB
> > list and other parties involved :)
> > 
> > Greg, Alan, any ideas?
> 
> It would be nice to know which part of the usb-handoff code causes
> the problem.  In the 2.6.15 source file
> drivers/usb/host/pci-quirks.c, at the end of the file is this
> routine:
> 
> static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
> {
> 	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> 		quirk_usb_handoff_uhci(pdev);
> 	else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
> 		quirk_usb_handoff_ohci(pdev);
> 	else if (pdev->class == PCI_CLASS_SERIAL_USB_EHCI)
> 		quirk_usb_disable_ehci(pdev);
> }
> 
> If you comment out the call to quirk_usb_handoff_uhci and rename
> the /lib/modules/2.6.15/kernel/drivers/usb/host/uhci-hcd.ko file so
> that it doesn't get loaded automatically, does that fix things?
> 
> Similarly, if you comment out the call to quirk_usb_disable_ehci
> and rename /lib/modules/.../ehci-hcd.ko so that it doesn't get
> loaded, does that help?
> 
> Leonid's system log showed that he doesn't have an OHCI controller,
> but if Martin does then he should do the same test with
> quirk_usb_handoff_ohci.

Yes, I also use the OHCI controller (I guessed that this is
necessary for low speed USB devices...), I commented the calls of
quirk_usb_disable_?hci and renamed the compiled modules so that they
cannot be loaded. Thus, the PS/2 keyboard *does* work with "USB
keyboard support" enabled in the BIOS with kernel 2.6.15. But - of
cource - no USB device does work.

Kind regards, Martin
-- 
http://www.bretschneidernet.de        OpenPGP-key: 0x4EA52583
             (o_                    Ernest Hemingway:
 (o_ (o_ (o_ //\      I like to listen. I have learned a great deal
 (\)_(\)_(\)_V_/_  from listening carefully. Most people never listen.
