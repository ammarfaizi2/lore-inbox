Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWCNGV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWCNGV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWCNGV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:21:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:7172 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750736AbWCNGVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:21:55 -0500
Date: Tue, 14 Mar 2006 07:21:44 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: gcoady@gmail.com, j4K3xBl4sT3r <jakexblaster@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
Message-ID: <20060314062144.GC21493@w.ods.org>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com> <1142273212.3023.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142273212.3023.35.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 07:06:52PM +0100, Arjan van de Ven wrote:
> On Tue, 2006-03-14 at 05:03 +1100, Grant Coady wrote:
> > On Mon, 13 Mar 2006 09:17:47 +0100, Arjan van de Ven <arjan@infradead.org> wrote:
> > 
> > >2.6 is actively maintained and will be for quite some time :)
> > 
> > 2.6 is an experimental, unstable and non-trustworthy file muncher.

Uhh? Grant, you are feeling brave to say this in front of so many
kernel developpers ! :-)

> that's tripple fud that sounds like a troll ;)
> Sorry but it does.
> 
> 2.6 is very stable for a LOT of people, more so than 2.4 in fact.

It depends a lot on what people do with it in fact. For instance, it
works better in memory-constrained systems, probably thanks to rmap.
I have one 2.6 running reliably on my web server (hppa) where 2.4
regularly oopsed because of low memory.

I would also recommend it for very small systems with limited
features, thanks to Matt Mackall's tiny patches, mostly merged
in 2.6.16. I've been building boot managers with it which fit
in less than 800 kB including kernel + full initramfs, and
that works amazingly well.

However, network performance has significantly dropped, and the
scheduler is still a big problem. Not only we occasionally see
people complaining about unfair CPU distribution across processes
(may be fixed now), but the scheduler still gives a huge boost to
I/O intensive tasks which do lots of select() with small time-outs,
which makes it practically unusable in network-intensive environments.
I've observed systems on which it was nearly impossible to log in via
SSH because of this, and I could reproduce the problem locally to
create a local DoS where a single user could prevent anybody from
logging in. 2.6.15 has improved a lot on this (pauses have reduced
from 35 seconds to 4 seconds) but it's still not very good.

It's still the major reason why I haven't switched, and why several
people I know regularly jump back to 2.4 when they realize that it's
not their hardware which is slow. On the other side, block I/O seems
to have improved a lot. Slocate takes far less time in 2.6 than in
2.4 and runs smoother.

The last stability concern is about code stability. It's moving
very fast, and whatever version you choose, you'll have a hard
time trying to backport fixes in 1 year. Even for Greg and Chris
it has been a huge work to maintain fixes for both 2.6.14 and
2.6.15. I hope things will stabilize. The only real solution right
now would be to use commercial distros who pay developpers to do
this painful work.

Regards,
Willy

