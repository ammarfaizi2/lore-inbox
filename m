Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266238AbTGDXvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 19:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbTGDXvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 19:51:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52162
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266238AbTGDXvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 19:51:19 -0400
Date: Sat, 5 Jul 2003 02:05:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Status of the IO scheduler fixes for 2.4
Message-ID: <20030705000544.GC23578@dualathlon.random>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva> <Pine.LNX.4.55L.0307021927370.12077@freak.distro.conectiva> <1057197726.20903.1011.camel@tiny.suse.com> <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva> <1057354654.20903.1280.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057354654.20903.1280.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 05:37:35PM -0400, Chris Mason wrote:
> I've also attached a patch I've been working on to solve the latencies a
> different way.  bdflush-progress.diff changes balance_dirty to wait on
> bdflush instead of trying to start io.  It helps a lot here (both
> throughput and latency) but hasn't yet been tested on a box with tons of
> drives.

that's orthogonal, it changes the write throttling, it doesn't touch the
blkdev layer like the other patches does. So if it helps it solves a
different kind of latencies.

However the implementation in theory can run the box oom, since it won't
limit the dirty buffers anymore. To be safe you need to wait 2
generations. I doubt in practice it would be easily reproducible though ;).

Andrea
