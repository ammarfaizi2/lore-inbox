Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVCCQ64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVCCQ64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVCCQ45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:56:57 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:46250
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262174AbVCCQ4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:56:03 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
References: <42265A6F.8030609@pobox.com>
	 <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com>
	 <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 17:55:59 +0100
Message-Id: <1109868959.4032.30.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 08:23 -0800, Linus Torvalds wrote:
> But look at how to solve it. The _logical_ solution is to have a third
> line of defense: we have the -mm trees (wild and wacky patches), and we
> have my tree (hopefully not wacky any more), and it would be good to have
> a third level tree (which I'm just not interested in, because that one
> doesn't do any development any more) which only takes the "so totally not
> wild that it's really boring" patches.
> 
> In fact, if somebody maintained that kind of tree, especially in BK, it 
> would be trivial for me to just pull from it every once in a while (like 
> ever _day_ if necessary). But for that to work, then that tree would have 
> to be about so _obviously_ not wild patches that it's a no-brainer.
> 
> So what's the problem with this approach? It would seem to make everybody
> happy: it would reduce my load, it would give people the alternate "2.6.x
> base kernel plus fixes only" parallell track, and it would _not_ have the 
> testability issue (because I think a lot of people would be happy to test 
> that tree, and if it was always based on the last 2.6.x release, there 
> would be no issues.

This way you have a fixup tree for the latest 2.6.x release, but does
not resolve the problem of the release quality itself.

It makes more sense to do

2.6.x-pre1 .. preX in your tree until you feel comfortable to move it
into the release tree, where it starts from

2.6.x-rc1 .. rcX bugfix only up to the final release.

>From the release to the next -preX to -rc1 move this tree only handles
the real trivial and urgent fixes and produces 2.6.x.y updates. When the
next -rc1 appears the previous 2.6.x.y is frozen and never touched
again.

This way you have ongoing development in your tree and the -rcX releases
might find more testers than now.

> I'll tell you what the problem is: I don't think you'll find anybody to do
> the parallell "only trivial patches" tree. They'll go crazy in a couple of
> weeks. Why? Because it's a _damn_ hard problem. Where do you draw the
> line? What's an acceptable patch? And if you get it wrong, people will
> complain _very_ loudly, since by now you've "promised" them a kernel that
> is better than the mainline. In other words: there's almost zero glory,
> there are no interesting problems, and there will absolutely be people who 
> claim that you're a dick-head and worse, probably on a weekly basis.

I think when the rules are clear and some gratification would be
available you might find somebody to jump on this train. 

tglx


