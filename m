Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVDFWsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVDFWsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVDFWsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:48:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:26834 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262352AbVDFWs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:48:28 -0400
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jeoecr1qk8.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston>  <jeoecr1qk8.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 08:47:35 +1000
Message-Id: <1112827655.9518.194.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 00:35 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Hrm... it should only add a few ms, maybe about 20 ms to the mode
> > switching... If you remove the radeon_msleep(5) call from the
> > radeon_pll_errata_after_data() routine in radeonfb.h, does it make a
> > difference ?
> 
> Yes, it does.  Without the sleep, switching is as fast as before.

It is weird tho. Could you try adding a printk or something to figure
out how much this is called during a typical swich ? It will seriously
spam your console though ... I would expect only 5 or 6 calls during a
normal switch (since the PLL value shouldn't change for a flat panel),
that is no more than maybe 50ms, while it seems you are having a much
bigger delay.

Ben.

