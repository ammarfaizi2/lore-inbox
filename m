Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUBEArB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUBEAqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:46:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:11758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265137AbUBEAj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:39:29 -0500
Date: Wed, 4 Feb 2004 16:39:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
In-Reply-To: <1075939994.4371.58.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402041634440.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston>  <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
  <20040204231324.GA5078@kroah.com>  <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
  <1075938633.4029.53.camel@gaston>  <Pine.LNX.4.58.0402041601080.2086@home.osdl.org>
 <1075939994.4371.58.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Feb 2004, Benjamin Herrenschmidt wrote:

> > Would that suit your needs?
> 
> What about adding a pcibios_add_platform_entries(device) called by
> pci_sysfs then ? By default an empty inline on asm/* and on PPC,
> I can add my devspec without having OF-aware code in drivers/pci

Yes.

> Also, if you prefer a different name for "devspec", speak up now ;)

I have to admit that "devspec" doesn't seem to do much for me, but I don't 
think we should call it "firmware", since that would (to me) be more about 
the firmware of the _device_ rather than the platform.

Maybe just "platform-data" or something. But if "devspec" has magic 
meaning on a Mac, and since this would be inherently platform-specific 
_anyway_, I don't actually see any reason to not use "devspec".

On some platforms, we might have multiple different entries (eg on a PC we 
might have pointers to ACPI data, to PnP data and to EFI data, all at the 
same time. I hope we never will, but maybe there would be reason for it). 
That would argue _against_ a "generic" name like "platform", and for 
something that is actually very much specific to the kind of data it 
points to (eg "of-data" rather than "platform-data").

End result: I don't think we much care about the name. Whatever makes you
happy. As long as the source code is clean and something like
"pcibios_add_platform_entries()" at least makes that come true.

		Linus
