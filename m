Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755259AbWKNLYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbWKNLYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430AbWKNLYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:24:16 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:43026 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1755259AbWKNLYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:24:15 -0500
Date: Tue, 14 Nov 2006 11:24:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: device_del() and references
Message-ID: <20061114112409.GB15340@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <455972D0.1030407@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455972D0.1030407@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 08:40:00AM +0100, Pierre Ossman wrote:
> When a card driver has obtained a reference to a card, what makes sure
> we do not destroy that card from under its feet?

Essentially, the driver model.  (see the answer to your paragraph below.)

> I suspect that device_del() doesn't return until remove() has been
> called and that our requirement is that the card driver must have
> released all references to the card before its remove routine exits.

Your sentence is confusing - which "remove()" are you talking about
here?  If you're talking about mmc_blk_remove() then that's correct.

> If so, then there is the risk of a race in mmc_block. What guarantees
> that the request handler isn't running in parallel with the remove
> function? Again, I suspect that del_gendisk() might grab the queue lock,
> but as there might be stuff left in the queue, this seems insufficient.

Hmm, not sure here.  I think you might be right, but the block layer is
*extremely* finaky when it comes to removing stuff.

In short, I don't know - I've forgotten quite a bit about the low level
block interface with MMC since it's something I did once and only once.

Maybe Jens has some ideas?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
