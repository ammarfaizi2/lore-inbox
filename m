Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVBPECN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVBPECN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 23:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVBPECN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 23:02:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:14993 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261975AbVBPEB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 23:01:59 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391050215170874051b29@mail.gmail.com>
References: <200502151557.06049.jbarnes@sgi.com>
	 <9e473391050215163621dafa65@mail.gmail.com>
	 <200502151645.27774.jbarnes@sgi.com> <1108515632.13394.59.camel@gaston>
	 <9e473391050215170874051b29@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 15:00:51 +1100
Message-Id: <1108526452.13394.90.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 20:08 -0500, Jon Smirl wrote:
> There is a new io resource flag as part of the pci rom code,
> IORESOURCE_ROM_SHADOW, that is used on x86. If IORESOURCE_ROM_SHADOW
> is set, you should ignore the physical ROM and use the copy at C000:0.
> Can we build an equivalent flag for PPC? On x86 arch specific code
> determines the boot video device and sets the flag.
> 
> Acutally, if radeon and rage fb drivers were using the PCI ROM support
> (drivers/pci/rom.c) would they be having this problem? The 55AA check
> is in the PCI ROM support too.

No, such a flag wouldn't make sense as it's not really a ROM shadow. In
fact, the driver is just part of the main open firmware, there are no
tables we can get to like x86 etc... however, we can access properties
in the open firmware device-tree that have been set by the OF driver. So
it's a completely different mecanism. A ROM shadow bit wouldn't make
sense.

Ben.


