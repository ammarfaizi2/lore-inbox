Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVKABl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVKABl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVKABl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:41:59 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:15247 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932554AbVKABl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:41:58 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Date: Mon, 31 Oct 2005 17:41:56 -0800
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com> <1130804214.29054.390.camel@gaston>
In-Reply-To: <1130804214.29054.390.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311741.56638.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 4:16 pm, Benjamin Herrenschmidt wrote:
> On Mon, 2005-10-31 at 16:23 +1100, Paul Mackerras wrote:
> > My G4 powerbook gets a machine check on boot as a result of commit
> > 478a3bab8c87a9ba4a4ba338314e32bb0c378e62.  Putting a return at the
> > start of quirk_usb_early_handoff fixes it.
> > 
> > The code in quirk_usb_handoff_ohci looks rather bogus in that it
> > doesn't do pci_enable_device before trying to access the device.

No PCI quirk code has ever called pci_enable_device() AFAICT.

Of course the _need_ to do such a thing might be another PPC-specific
(or OpenFirmware-specific?) PCI thing ... we've hit other cases where
PPC breaks things that work on other PCI systems (and vice versa).


> That and it doesn't test if the BARs are assigned at all, doesn't
> request the resources, etc... 

If quirk code can't rely on BARs, then the PCI system needs some
basic overhauls ... yes?  I mean, how could quirk code ever work
if it can't access the relevant chip registers??


> I'm not sure it's legal to do pci_enable_device() from within a pci
> quirk anyway. I really wonder what that code is doing in the quirks, I
> don't think it's the right place, but I may be wrong.

Erm, what "code is doing" what, that you mean ??


> What is the logic supposed to be there ?

Which logic?  The fundamental thing those USB handoff functions do
is make sure that BIOS code lets go of the host controllers.  The
main reason it'd be using a controller is because of USB keyboards,
mice, or maybe boot disks.  Secondarily, that code needs to make
sure the controller is really quiesced before Linux starts using it.

- Dave

