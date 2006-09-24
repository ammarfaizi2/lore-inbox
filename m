Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWIXHsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWIXHsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 03:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWIXHsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 03:48:40 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:55170 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S1751008AbWIXHsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 03:48:40 -0400
Date: Sun, 24 Sep 2006 09:48:37 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, davidsen@tmr.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060924074837.GB13487@xi.wantstofly.org>
References: <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org> <20060921.145208.26283973.davem@davemloft.net> <20060921220539.GL26683@redhat.com> <20060922083542.GA4246@flint.arm.linux.org.uk> <20060922154816.GA15032@redhat.com> <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609220901040.4388@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 09:21:32AM -0700, Linus Torvalds wrote:

> > Hmm. Some trees do seem to get pulled more often than others.
> > Linus, is there a upper limit on the number of times you want
> > to see pull requests? It strikes me as odd, so I'm wondering
> > if there are some crossed wires here.
> 
> I personally prefer to not see _too_ many pull requests, since that
> to me indicates that people don't take advantage of the distributed
> nature of git, and don't let things "simmer" in their own tree for
> a while.

ARM has many sub-architectures, and patches for each of the sub-archs
typically (not always) come from the same person in ARM land, which
typically means that the total set of ARM changes doesn't really need
much integration testing as a whole.

Changes that span sub-architectures (such as genirq) are usually
discussed on the mailing list first, and tested before they get
committed to any tree.  I.e. on the few occasions that we do need
to test ARM-wide changes, we just email patches around rather than
asking folks "whether 2.6.30-rmk42 works."

Due to this, by the time a patch gets sent to rmk it's Obviously
Perfect, and the remaining testing work is 99% integration testing
with concurrent changes to other subsystems -- mtd, netdev, usb, etc.

In fact, I'd argue that there are more patches that span arch/arm plus
some other part of the tree (inter-related mtd bits, netdev bits, usb
bits, framebuffer bits), than there are patches that span different ARM
sub-architectures.

For example, a driver for the ethernet MAC in the ARM cpu that I have
here was recently applied by jgarzik, but I cannot submit the arch/arm
hooks to make use of this driver until jgarzik's tree is merged upstream
_and_ rmk rebases the half a megabyte of pending ARM changes on this
tree.  If I submit the hooks to rmk when the driver goes upstream, rmk's
private tree (probably still based on 2.6.18 when that happens, so won't
have the relevant netdev changes) will break.

To make making these kinds of changes easier without sending stuff
upstream so regularly, rmk would have to either pull from upstream
regularly or rebase his tree on upstream regularly, both of which
don't seem like desirable options.

Also, I do want to track upstream git, as every now and then changes
are made upstream that break ARM, and we want to be able to detect that
quickly.

Due to the nature of ARM work, rmk maintaining a long-lived tree for
stuff to 'simmer in' would probably reduce the burden on Linus but
would not have much of an advantage otherwise, IMHO.


cheers,
Lennert
