Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVCDKoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVCDKoY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVCDKlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:41:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53514 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262633AbVCDKke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:40:34 -0500
Date: Fri, 4 Mar 2005 10:40:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304104025.A3932@flint.arm.linux.org.uk>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <42268037.3040300@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42268037.3040300@osdl.org>; from rddunlap@osdl.org on Wed, Mar 02, 2005 at 07:10:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 07:10:47PM -0800, Randy.Dunlap wrote:
> Dave Jones wrote:
> > For it to truly be a stable kernel, the only patches I'd expect to
> > drivers would be ones fixing blindingly obvious bugs. No cleanups.
> > No new functionality. I'd even question new hardware support if it
> > wasn't just a PCI ID addition.
> 
> Maybe I don't understand?  Is someone expecting distro
> quality/stability from kernel.org kernels?
> I don't, but maybe I'm one of those minorities.

Don't say that too loudly or else the embedded people will use it as
another excuse not to move on to 2.6 kernels.

But yes, _I_ do expect a certain amount of quality and stability from
kernel.org kernels mainly because there _isn't_ a distro to do that
for us on ARM.  It's fine in x86 land where there are such things and
you have One Single Platform(tm), but in ARM land where there's
numerious platforms, there's very little sense in having a "distro"
maintained kernel.

For instance, I'd like to upgrade the kernel on the main ARM server
here from 2.4 to 2.6, but since it requires a number of subsystems to
work properly (MD, Promise IDE, Ext3, NFS server) which you normally
wouldn't see on ARM embedded systems, I'm not entirely happy to throw
a 2.6 kernel on it just yet.

However, coupled with the requirement for quality, some in the ARM
community expect a certain amount of development to be going on, since
ARM is a relatively fast moving community [*].  Freezing stuff for 6
months isn't really practical when you have support for new platforms
or new drivers wanting to be merged all the time.  Ignoring these
things for 6 months causes someone to spawn a new tree and that's
usually the last you see of any contribution from that direction.

So, what I think we need is for core system, subsystem and "service"
development to slow down a little while still allowing peripheral
low-impact "new stuff" to be added during a "stablisation" period.
We also need to qualify what we mean by "stable in relation to the
resulting kernel - eg, I don't think we should call the "new stuff"
merged during that time "stable".

This actually brings up an interesting point - if new machine support
is stablised external to the "stable" tree, and then merged into that
tree, should it be marked as "experimental"?  Given the previous
paragraph, I think the answer is "yes" since this will allow people
to distinguish the recently merged stuff.



[*] - depends how you understand "fast".  My method of working new
features into the ARM code in Linus' kernel is via a series of small
steps (or a series of smaller series of steps) spread out over a
period of time.

An example of this is the ARM SMP merging, where the low level entry
code has had to be rewritten.  However, rather than just replace the
file, it's getting a series of clean ups first which are aimed in the
direction we want to go.  We're getting towards the state where the
_major_ difference between todays implementation and the SMP version
is the code in a small number of macros, rather than virtually every
line in the file.  However, I do feel like I'm going against the grain
when Linus says "slow down" and I'm seen to be doing cleanup after
cleanup with no obvious effect or point.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
