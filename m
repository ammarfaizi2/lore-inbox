Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754294AbWKHF3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbWKHF3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 00:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbWKHF3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 00:29:37 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42195
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1754293AbWKHF3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 00:29:36 -0500
Date: Tue, 07 Nov 2006 21:29:37 -0800 (PST)
Message-Id: <20061107.212937.70218368.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
Subject: Re: DMA APIs gumble grumble
From: David Miller <davem@davemloft.net>
In-Reply-To: <1162963420.28571.700.camel@localhost.localdomain>
References: <1162950877.28571.623.camel@localhost.localdomain>
	<20061107.204653.44098205.davem@davemloft.net>
	<1162963420.28571.700.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 08 Nov 2006 16:23:40 +1100

> Then, maybe 6 month, maybe 1 year later, we can change archs that use
> the "alternate" semantic like sparc64 to no longer fail
> pci_set_dma_mask(64bits).
> 
> In fact, the only breakage here would be for those archs to have some
> drivers start going slowly, though we could expect drivers to have been
> fixed by then.... (And we can delay that second part of the change as
> long as deemed necessary).

The arch implementations of pci_map_*() et al. might start
failing since they were written assuming that DAC never got
enabled.

> Yup, but you didn't fix sparc32 :-) I suppose I can try to do it and ask
> Anton for help if things go wrong, though I can't be bothered building a
> cross toolchain or getting a box on ebay so I'll rely on your for
> testing :-)

I only do sparc32 build testing, which you can do on a sparc64
box and Al Viro has great recipies for cross tool building and
usage.

> Thus, that is 3 pointers gone for archs who don't use these, and the ability
> to put things like your dma ops in every struct device.

How exactly does your device struct extension work?  I ask because
struct device is embedded into other structs, such as pci_dev,
so it has to be fixed in size unless you have some clever trick. :)

