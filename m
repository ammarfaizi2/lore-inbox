Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUKOFkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUKOFkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 00:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbUKOFkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 00:40:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57350 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261454AbUKOFkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 00:40:17 -0500
Date: Mon, 15 Nov 2004 06:29:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc2 doesn't boot
Message-ID: <20041115052920.GB7510@stusta.de>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org> <20041115040710.GA2235@stusta.de> <Pine.LNX.4.58.0411142040470.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411142040470.2222@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 08:48:22PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 15 Nov 2004, Adrian Bunk wrote:
> > io scheduler deadline registered
> > io scheduler cfq registered
> > 
> > ---->  2.6.10-rc2 stops here
> > 
> > loop: loaded (max 8 devices)
> 
> Strange. There is not a lot in between those two registrations. The "cfq 
> registered" comes from cfq_init(), and the "loop: loaded" thing comes from 
> loop_init(), and in between them in the link there is just floppy.o.
> 
> And I don't see that _any_ of those three has changed. Yes, cfq got an 
> __exit added to its exit function, and floppy got __initdata added, but 
> neither of those should make any difference what-so-ever.
> 
> Just for interest, what happens if you disable floppy support? It doesn't 
> look like you have a floppy on that system..

Bingo.

I don't have a floppy and floppy support is disabled in the BIOS.

And thinking about it, I had exactly the same problem in -mm three 
months ago (the thread subject was "2.6.8-rc4-mm1 doesn't boot").
(I didn't think it might be the same problem again since this was so
 long ago...).

It seems Bjorns "PCI: remove unconditional PCI ACPI IRQ routing" was 
merged now into your tree, but his patch to fix floppy.c wasn't 
merged...

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

