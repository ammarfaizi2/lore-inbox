Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbUBEA1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUBEA0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:26:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:29829 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264442AbUBEAOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:14:05 -0500
Subject: Re: [PATCH] PCI / OF linkage in sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402041601080.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston>
	 <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
	 <20040204231324.GA5078@kroah.com>
	 <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
	 <1075938633.4029.53.camel@gaston>
	 <Pine.LNX.4.58.0402041601080.2086@home.osdl.org>
Content-Type: text/plain
Message-Id: <1075939994.4371.58.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 11:13:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-05 at 11:04, Linus Torvalds wrote:

> I think that I personally would be a lot happier with the situation if it 
> wasn't that PCI had magic knowledge about OF in particular.  In other 
> words, you'd likely be able to sell me on an idea where the PCI layer just 
> knows about "let the firmware install a few files here", but is totally 
> firmware-agnostic per se.
> 
> In other words, you migth just rename the "OF" functionality as "platform" 
> functionality, and add dummy (empty) platform handlers for the other 
> platforms (eg BIOS/EFI whatever). Maybe some day EFI will want to have a 
> similar pointer..
> 
> So while I'd hate to have the PCI layer start having to learn details of 
> all the platforms out there, I don't think it's necessarily wrong that the 
> PCI layer knows about the _concept_ of a platform, as long as it doesn't 
> get too specific.
> 
> Would that suit your needs?

What about adding a pcibios_add_platform_entries(device) called by
pci_sysfs then ? By default an empty inline on asm/* and on PPC,
I can add my devspec without having OF-aware code in drivers/pci

Also, if you prefer a different name for "devspec", speak up now ;)

I can still change the name in the macio devices too, nothing uses
them right now and I expect things that will be fixed to use them
to rely on 2.6.3 minimum.

Ben.



