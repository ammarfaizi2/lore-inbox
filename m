Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUBEAHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUBEAFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:05:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:43223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264411AbUBEAFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:05:03 -0500
Date: Wed, 4 Feb 2004 16:04:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
In-Reply-To: <1075938633.4029.53.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402041601080.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston>  <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
  <20040204231324.GA5078@kroah.com>  <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
 <1075938633.4029.53.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> I don't quite agree... There are cases for example (USB, Firewire) where
> we could construct an OF path to be used by the bootloader setup without
> having the OF information in the first place (for devices that weren't
> plugged during boot typically). I do no intend to go that way for 2.6
> though.

Ok. Fair enough.

I think that I personally would be a lot happier with the situation if it 
wasn't that PCI had magic knowledge about OF in particular.  In other 
words, you'd likely be able to sell me on an idea where the PCI layer just 
knows about "let the firmware install a few files here", but is totally 
firmware-agnostic per se.

In other words, you migth just rename the "OF" functionality as "platform" 
functionality, and add dummy (empty) platform handlers for the other 
platforms (eg BIOS/EFI whatever). Maybe some day EFI will want to have a 
similar pointer..

So while I'd hate to have the PCI layer start having to learn details of 
all the platforms out there, I don't think it's necessarily wrong that the 
PCI layer knows about the _concept_ of a platform, as long as it doesn't 
get too specific.

Would that suit your needs?

		Linus
