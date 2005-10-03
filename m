Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVJCTr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVJCTr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVJCTr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:47:57 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39690 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932332AbVJCTr4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:47:56 -0400
To: Al Viro <viro@ftp.linux.org.uk>
Cc: jonathan@jonmasters.org, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>
	<35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>
	<87oe66r62s.fsf@amaterasu.srvr.nix>
	<20051003153515.GW7992@ftp.linux.org.uk>
From: Nix <nix@esperi.org.uk>
X-Emacs: a learning curve that you can use as a plumb line.
Date: Mon, 03 Oct 2005 20:47:47 +0100
In-Reply-To: <20051003153515.GW7992@ftp.linux.org.uk> (Al Viro's message of
 "Mon, 3 Oct 2005 16:35:15 +0100")
Message-ID: <87zmpqbcws.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Al Viro moaned:
> Another fun consideration in that area is that XML (or s-exp, or trees,
> whatever representation you prefer) has nothing to help with dynamic data
> structures.  Exporting snapshots does not work since the real state
> includes the information about locks being held - without that you
> can't tell which invariants hold at the moment, since the real ones
> include lock state.

Oh yes; the only practical way to get the system into a consistent state
would be to take out the BKL (the old, non-preemptible variant),
generate all that XML (for all of /proc and all of /sys!) and then
release it again.

Efficient this is *not*.

(at least, not the loony everything-in-one-big-file variant. Keeping the
current smaller files but making them XML is possible, but pointless:
the filesystem already provides the hierarchical structure in /sys, and
nothing can make /proc regular, so what's the point of adding an extra
layer of hierarchy that serves only to complicate parsing and make it
hard for *humans* to use?)

>                      And forcing all locks involved into known state
> is nowhere near feasible, of course.  OTOH, exporting dynamic state
> including locks and walking the damn thing is
> 	a) not feasible with XML

It's feasible, if you don't mind ps(1) becoming a DoS attack, and one
running instance of top(1) damn-nearly freezing the system.

It's just not *sane*.

> 	b) would require giving userland way too much access to locking,
> creating a nightmare wrt deadlock potential.

Indeed.

(Current rant: DRM churn, forcing one of abandonment of decent 3D
support, or upgrading of the X server to the bleeding-edge, or using an
old kernel with known security holes, or becoming enough of a DRI
developer to backport the changes, or using nothing but distro kernels
<=2.6.11. Most of these are not terribly feasible for me right now. Ah
well, my 3D card is total crap anyway. It's just a shame the X server
crashes whenever asked to do in-software 3D rendering...  time to
debug. I thought I might actually get some work done this evening. Fat
chance.)

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
