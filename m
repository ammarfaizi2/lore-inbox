Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269553AbUJLJ1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269553AbUJLJ1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269557AbUJLJ1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:27:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269553AbUJLJ1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:27:35 -0400
Date: Tue, 12 Oct 2004 10:27:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041012102723.B31597@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Brownell <david-b@pacbell.net>,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com> <200410110947.38730.david-b@pacbell.net> <1097533687.13642.30.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1097533687.13642.30.camel@gaston>; from benh@kernel.crashing.org on Tue, Oct 12, 2004 at 08:28:07AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 08:28:07AM +1000, Benjamin Herrenschmidt wrote:
> Definitely. One thing is: how to do it instead ? I've been thinking
> about it for a while and am still wondering... do we want a list
> mecanism with add/remove notifiers so the PM walk can keep in sync
> with devices added/removed ? or should addition/removal be simply
> postponed until the end of the sleep/wakeup process (I tend to vote
> for that).

What about the case where you're walking the tree for a resume, and
you've hotplugged a whole tree of devices which have a similar bus
setup to the original.

Yes, I'm thinking of the case of Cardbus with hotpluggable PCI buses.
If we detect that the "bridge" at the top of the chain has changed,
we _really_ don't want to try to restore the state of the child
devices - they may have the same bus IDs, but they could well object
to being inappropriately setup.

Sure, we can say "don't do that then" but I suspect the exact same
problem is present with USB, and USB is far more liable to have this
type of abuse than PCI.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
