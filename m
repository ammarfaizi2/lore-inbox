Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUBDXy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUBDXyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:54:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:13957 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265059AbUBDXvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:51:20 -0500
Subject: Re: [PATCH] PCI / OF linkage in sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston>
	 <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
	 <20040204231324.GA5078@kroah.com>
	 <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
Content-Type: text/plain
Message-Id: <1075938633.4029.53.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 10:50:33 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Where does this stop? Do we start doing the same for all different kinds 
> of buses, and all kinds of firmware? 
> 
> In other words, instead of having <n> different buses all know about <m>
> different kinds of firmware information that they really have nothing else
> to do with, it's much better to just have the <m> different kinds of 
> firmware information export their own information.
> 
> It just sounds _wrong_ to have the PCI layer have knowledge of OF. It has 
> nothing to do with OF. For OF information, you should go to the /sys/of 
> tree, which has the information that OF knows about (which may, of course, 
> then include the information about PCI devices).

I don't quite agree... There are cases for example (USB, Firewire) where
we could construct an OF path to be used by the bootloader setup without
having the OF information in the first place (for devices that weren't
plugged during boot typically). I do no intend to go that way for 2.6
though.

In both cases, we don't "have" the information.

OF doesn't have informations about the linux PCI layout (bus numbering can
be different between OF and linux for example) and PCI doesn't have information
about OF (except that on ppc64, pci_dev->arch_data points to the OF node).

However, the arch code provides a routine that can provide that mapping
PCI -> OF (and in _that_ direction, there is one to go the other way around,
but I hate it, it's not very reliable at the moment, though I could rewrite
it..., and on ppc64, this is the most efficient way too).

It's just about providing a pointer to OF node, not actual informations out
of the device-tree...

Ben.


 

