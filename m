Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162216AbWKPC0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162216AbWKPC0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162219AbWKPC0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:26:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:9100 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162216AbWKPC0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:26:21 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <20061114.202814.70218466.davem@davemloft.net>
References: <455A938A.4060002@garzik.org>
	 <20061114.201549.69019823.davem@davemloft.net> <455A9664.50404@garzik.org>
	 <20061114.202814.70218466.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 13:25:37 +1100
Message-Id: <1163643937.5940.342.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 20:28 -0800, David Miller wrote:
> From: Jeff Garzik <jeff@garzik.org>
> Date: Tue, 14 Nov 2006 23:24:04 -0500
> 
> > I can't answer for the spec, but at least two independent device vendors 
> > recommended to write an MSI driver that way (disable intx, enable msi).
> 
> Ok.
> 
> > Completely independent of MSI though, a PCI 2.2 compliant driver should 
> > be nice and disable intx on exit, just to avoid any potential interrupt 
> > hassles after driver unload.  And of course be aware that it might need 
> > to enable intx upon entry.
> 
> This also sounds like it should occur in the generic PCI layer when a
> PCI driver is unregistered.

Is this disable_intx() thingy something x86 specific ? I mean, you can't
just call disable_irq() for LSIs since you can be sharing it. If you
aren't sharing, free_irq() will mask for you.

Ben.


