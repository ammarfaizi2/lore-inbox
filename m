Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUGLTIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUGLTIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUGLTIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:08:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7142 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261763AbUGLTIP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:08:15 -0400
Date: Mon, 12 Jul 2004 11:03:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Subject: Re: parport - interrupt sharing possible?
Message-ID: <20040712140309.GA3755@logos.cnet>
References: <20040712035119.GA1865@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712035119.GA1865@dbz.icequake.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jul 11, 2004 at 10:51:19PM -0500, Ryan Underwood wrote:
> 
> Hi,
> 
> Does anyone know if the generic parport interrupt handler is okay (or not)
> for sharing interrupts?  The reason I ask is that I have a PCI parallel
> card with two ports on it.  Without a IRQ sharing capability, it is not
> possible for both of them to operate in interrupt-driven mode.  I tested
> a quick hack to enable IRQ sharing:
> http://home.icequake.net/~nemesis/parport.diff
> 
> and it seems to work okay with both ports in use.  I'm hoping someone
> more knowledgeable on the parallel port subject (Tim Waugh?) can shed
> some light on whether this is acceptable or not.  The interrupt handler
> eventually ends up in parport_ieee1284_interrupt which really doesn't do
> much besides wake up sleepers.
> 
> Thanks!
> 
> PS: Heh, the power just went out and back on as I wrote this.  Giving thanks
> for having multiple UPS units around!

Hi Ryan,

Quoting Tim Waugh:

> 2) Allows PCI parallel port to share an IRQ if possible.  In limited testing
> this seems to be ok, but maybe the interrupt handler was not written for
> sharing.  Someone else will need to ok this.
                                                                                
This seems dangerous to me.  There are some issues with IRQs in
parport, although I think they are known and there is a fix around:
http://lists.infradead.org/pipermail/linux-parport/2004-March/000048.html
                                                                                
Incidentally, I have asked if there is anyone with more time than me
who would like to maintain the paride/parport bits, but no-one has
stepped forward.  I see that Al Viro has fixed a lot of problems while
I've been busy with other things.
