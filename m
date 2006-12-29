Return-Path: <linux-kernel-owner+w=401wt.eu-S965134AbWL2USZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWL2USZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 15:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWL2USZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 15:18:25 -0500
Received: from iabervon.org ([66.92.72.58]:1198 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965134AbWL2USZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 15:18:25 -0500
Date: Fri, 29 Dec 2006 15:18:23 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: 2.6.20-rc2: known unfixed regressions
In-Reply-To: <20061229192205.GT20714@stusta.de>
Message-ID: <Pine.LNX.4.64.0612291445470.20138@iabervon.org>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
 <20061228223909.GK20714@stusta.de> <Pine.LNX.4.64.0612291234400.20138@iabervon.org>
 <20061229192205.GT20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006, Adrian Bunk wrote:

> On Fri, Dec 29, 2006 at 01:14:13PM -0500, Daniel Barkalow wrote:
> 
> > There's also http://lkml.org/lkml/2006/12/21/47; the included patch break 
> > my nVidia devices and probably all PCIX devices, so it's not right, but 
> > something has to be done to fix ATI. My guess is a quirk to say that 
> > pci_intx doesn't work on certain devices and should just be skipped, but 
> > I'm not sure if it's just in combination with MSI or not.
> 
> This:
> - does not seem to be a regression and
> - missing MSI support is not such a big problem.
> 
> Considering how many problems patches in this area tend to cause on 
> different hardware, I'm even inclined to say that such patches should 
> only be added during the 2 weeks merge window before -rc1.

(I was only talking about the first issue/patch as being a regression, 
obviously, and forgot that there was more to the email I cited.)

Ah, okay. I somehow missed that all of the devices that were reported 
to break with the MSI change in mainline doesn't support MSI in mainline. 
Actually, I wouldn't be surprised if this issue applied to audio on ATI 
SB450 and later, which (I think) use the hda_intel driver, which supports 
MSI (although I guess it's still defaulting to disabled). If this is true, 
it would be a regression since 2.6.19.

The addition of a quirk to not use pci_intx with MSI on ATI PCI devices 
should be safe (until 2.6.20-rc1, this was the usual kernel behavior), but 
is clearly not critical if mainline doesn't use MSI with any such devices 
anyway.

	-Daniel
*This .sig left intentionally blank*
