Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWDXRIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWDXRIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWDXRIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:08:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbWDXRIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:08:00 -0400
Date: Mon, 24 Apr 2006 10:07:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, Matthew Reppert <arashi@sacredchao.net>,
       linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
In-Reply-To: <Pine.LNX.4.64.0604240652380.31142@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0604241002460.3701@g5.osdl.org>
References: <1145851361.3375.20.camel@minerva> <20060423222122.498a3dd2.akpm@osdl.org>
 <Pine.LNX.4.64.0604240652380.31142@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, Dave Airlie wrote:
> 
> however not doing pci_enable_device causes interrupts to not work on the cards
> in a lot of circumstances..

Well, you could use "pci_enable_device_bars(0)" instead.

That will set up interrupt routing _without_ enabling any BAR's, however, 
that's probably crazy too, since that means that if an interrupt happens, 
you're really really screwed and can't do anything about it. So that's 
probably even more broken than what you do now.

How about delaying the "pci_enable_device()" until when you actually need 
it, ie do it in drm_irq_install() instead?

Of course, I wonder how you could POST the device without having the BAR's 
enabled, and I sure as hell wouldn't want the POST sequence to decide 
where to put them, since it has no clue what is allocated..

Sounds like X is being really bogus again.

			Linus
