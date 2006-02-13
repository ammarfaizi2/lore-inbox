Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWBMSyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWBMSyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWBMSyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:54:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964797AbWBMSyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:54:46 -0500
Date: Mon, 13 Feb 2006 10:50:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc3: more regressions
In-Reply-To: <20060213183445.GA3588@stusta.de>
Message-ID: <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
 <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
 <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org> <20060213183445.GA3588@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Adrian Bunk wrote:
> 
> Dave's patch removes the entry for the card with the 0x5b60.
> 
> According to his bug report, Mauro has a Radeon X300SE that should 
> have the 0x5b70 according to pci.ids from pciutils

No. Look closer:

  04:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc. Extreme AX300SE-X

That's the 5b60 chip too (yeah, the lspci doesn't show numbers when it has 
an ascii string, but in this case the ascii string happily has at least 
that part of the number in it: ".. RV370 5B60 ..", where the 5B60 is just 
the PCI ID number).

So it _is_ the same chip.

I just worry whether (a) the other added PCI ID's are any good for that 
core and (b) whether the bug was really introduced with some of the other 
changes. I admit that (b) is pretty unlikely, but it would be good to 
test.

> and that doesn't seem to be claimed by the DRM driver (and the dmesg 
> from the bug report confirms that the radeon DRM driver didn't claim to 
> be responsible for this card).

Sadly, that module loading is done by X. So the bootup dmesg stuff 
wouldn't have had the message.

It might be interesting to see if the hang can be reproduced without 
starting X at all, by just going a "modprobe radeon" or something. 
Unlikely, though - while loading the drm modules does _some_ things to the 
card, it's usually only when X actually starts sending commands to them 
that things really go downhill..

			Linus
