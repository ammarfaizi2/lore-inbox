Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUAFKsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 05:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUAFKsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 05:48:12 -0500
Received: from colin2.muc.de ([193.149.48.15]:271 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261837AbUAFKsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 05:48:11 -0500
Date: 6 Jan 2004 11:49:04 +0100
Date: Tue, 6 Jan 2004 11:49:04 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040106104904.GA87428@colin2.muc.de>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <3FFA8AEE.5090007@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFA8AEE.5090007@kolumbus.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 12:16:14PM +0200, Mika Penttil? wrote:
> But AGP aperture is controlled with the standard APBASE pci base 
> register, so you always know where it is, can relocate it and reserve 
> address space for it. Of course there may exist other uncontrollable hw, 
> which may cause problems.

Actually not. There are quite a lot of chipsets that require special
programming for the AGP aperture (why do you think drivers/char/agp/*.c
is so big?). And not even everything AGPv2 compliant. 

And as Linus points out you would likely need to do some Northbridge
specific magic to make that area usable for PCI then.

Also you would need to put it over RAM because again there is no 
reliable way to find a hole.

-Andi

