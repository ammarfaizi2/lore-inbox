Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVCCDzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVCCDzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVCCDuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:50:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261194AbVCCDrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:47:16 -0500
Date: Wed, 2 Mar 2005 22:47:04 -0500
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303034704.GA15771@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <42268037.3040300@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42268037.3040300@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 07:10:47PM -0800, Randy.Dunlap wrote:

 > >For it to truly be a stable kernel, the only patches I'd expect to
 > >drivers would be ones fixing blindingly obvious bugs. No cleanups.
 > >No new functionality. I'd even question new hardware support if it
 > >wasn't just a PCI ID addition.
 > 
 > Maybe I don't understand?  Is someone expecting distro
 > quality/stability from kernel.org kernels?

My complaint is the charade of calling it 'stable' when it clearly
wouldn't be anything of the sort, given that a majority of the bugs our
users experienced on rebasing were driver related.
The core itself may be rock-solid, but if we're continually pulling
in random driver updates of questionable quality with limited
testing, the result as a whole isn't stable.

 > I don't, but maybe I'm one of those minorities.

Putting the onus on distributions to make things stable is no
excuse for the ever-increasing number of regressions each release.

This might sound over-dramatic, but it's the current state as far
as I'm concerned.  The 2.6.8->2.6.9 update for Fedora users brought
a bunch of carnage that took time to shake out. 2.6.9->2.6.10 I'm
still picking up the pieces of.  If the 2.6.10->2.6.11 update that
I'll do for Fedora in a week or two turns out to have less regressions
than the previous releases, I'll be stunned. Really.

Already I'm wondering how many userspace packages are going to randomly
stop working as they have done in previous releases.  With the
clear delineation of stable/development, we were able to say things
like "we won't change a user visible interface in a stable series"
Now, we don't have that. So we find things ranging from slabtop to
alsa-lib completely break unless you update the userspace too.

regressions like this is what I'm bitching about. There's nothing
a vendor can do to make such things stable (other than dropping
the various patches that introduce the breakage, but at ~4000 csets
per release right now, there will be stuff that gets missed).
Whilst the slabinfo example was a non-driver related regression,
it's a good example of how little care we're taking these days
to make sure existing userspace continues to work correctly.

Some may suggest the close tracking of mainline is the problem.
Maybe they're right. Maybe we should have stuck with a 2.6.5 kernel
until Fedora Core 2 reached end of life, and gone with the old
'have hundreds and hundreds of patches piling up' approach.

But, as someone who has maintained vendor kernels that have tried
both methods, the sticking close to mainline approach wins hands down.
If something is broken, more often than not, I can bug the upstream
developer and ask "hey, this is a wierd problem our fedora users hit,
we don't have any patches against this code, can you take a look?"
and developers have been very responsive, and helpful on many occasions,
ultimatly leading bugs being fixed both in our kernel, and upstream.

If I asked most upstream developers about a problem we've been facing
with our 2.6.5 kernels, I'd get a much less helpful response.
And rightly so. In their position I'd do exactly the same thing.

		Dave

