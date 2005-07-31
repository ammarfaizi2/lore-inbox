Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVGaEuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVGaEuj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 00:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbVGaEuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 00:50:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbVGaEui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 00:50:38 -0400
Date: Sat, 30 Jul 2005 21:49:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <200507310028.20699.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.58.0507302144290.29650@g5.osdl.org>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <20050730215403.J26592@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>
 <200507310028.20699.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Rafael J. Wysocki wrote:
> 
> Well, they have _already_ been screwed by the following patch that went
> to your tree with the ACPI update.  If you drop it, all problems related to
> freeing/requesting IRQs on suspend/resume will be gone.

Yes. I really think we need to revert that patch, we just can't fix this 
any other way in the short run - the "request_irq/free_irq()" thing has 
broken too many setups. And we _need_ an answer for the short run, since I 
want to be able to release 2.6.13 without having lots of peoples laptop 
suspends be broken.

Yes, I realize that it fixed suspend for some people, but the thing is,
anything that expects lots of drivers to change just is fundamentally
broken. In a perfect world we might be able to get all drivers to do the
right thing, but dammit, in a perfect world we wouldn't have ACPI in the
first place.

So I guess I'll just have to revert the ACPI change that caused drivers to
do request_irq/free_irq. I'd prefer it if the ACPI people did that revert 
themselves, though.

		Linus
