Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUALVvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUALVvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:51:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:53660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266513AbUALVvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:51:07 -0500
Date: Mon, 12 Jan 2004 13:24:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel Alder IOAPIC fix
In-Reply-To: <1073876117.2549.65.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jan 2004, James Bottomley wrote:
>
> The intel alder motherboard really dislikes the way the current kernel
> reassigns all PCI resources.  It exports 6 memory bars from its Extended
> Express System Support Controller, but if the system touches any of
> them, it disables the secondary IO-APIC.
> 
> The system is bootable if you disable all IO-APICs apart from the
> primary, but it does become a bit crowded in interrupt space.  The patch
> fixes the problem by adding a quirk to clear the first six memory bars.

What are the BAR contents? In particular, maybe the right fix is to add a 
flag to say "don't touch" - but leave the BAR contents there, so that 
the resource manager can actually see what the resources actually are..

		Linus
