Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVCAQss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVCAQss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVCAQsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:48:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261970AbVCAQsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:48:42 -0500
Date: Tue, 1 Mar 2005 08:49:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
In-Reply-To: <42249A44.4020507@pobox.com>
Message-ID: <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Mar 2005, Jeff Garzik wrote:
> 
> A new API handles none of this.

Ehh? 

The new API is what _allows_ a driver to care. It doesn't handle DMA, but
I think that's because nobody knows how to handle it (ie it's probably
hw-dependent and all existign implementations would thus be
driver-specific anyway).

And in the sense of "any general new api handles none of it", your 
argument doesn't make sense. The _old_ IO API's clearly don't handle it. 
So if you seem to say that "A new API" can't handle it either, then that 
translates to "no API can ever handle it". Fair enough, if you think it's 
impossible, but clearly you can handle some things.

And yes, CLEARLY drivers will have to do all the heavy lifting. 

I don't expect most drivers to care. In fact, I expect about five to ten
drivers to be converted to really care, and then for some forseeable time
you'll have to be very picky about your hardware if you care about PCI 
parity errors etc. Most people don't, and most drivers won't be written in 
environments where they can be reasonably tested.

That's just a fact. Anybody who expects all drivers to suddenly start 
doing IO checks is just living in a dream world.

		Linus
