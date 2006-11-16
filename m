Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162225AbWKPC3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162225AbWKPC3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162229AbWKPC3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:29:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:46043 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162225AbWKPC3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:29:37 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: jeff@garzik.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <1163643937.5940.342.camel@localhost.localdomain>
References: <455A938A.4060002@garzik.org>
	 <20061114.201549.69019823.davem@davemloft.net> <455A9664.50404@garzik.org>
	 <20061114.202814.70218466.davem@davemloft.net>
	 <1163643937.5940.342.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 13:28:35 +1100
Message-Id: <1163644115.5940.346.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Is this disable_intx() thingy something x86 specific ? I mean, you can't
> just call disable_irq() for LSIs since you can be sharing it. If you
> aren't sharing, free_irq() will mask for you.

Oops .. my bad, forgot about that new command register bit. When was it
added ? pci 2.3 ?

Also, it should probably be done by pci_disable_device() ... in fact, to
be safe, the driver should disable that before free_irq().

Ben.


