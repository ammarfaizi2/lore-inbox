Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWABTtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWABTtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbWABTtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:49:50 -0500
Received: from khc.piap.pl ([195.187.100.11]:14596 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750986AbWABTtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:49:50 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
References: <20051229224839.GA12247@elte.hu>
	<1135897092.2935.81.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	<20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	<20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	<20060102103721.GA8701@elte.hu>
	<1136198902.2936.20.camel@laptopd505.fenrus.org>
	<20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
	<m3ek3qcvwt.fsf@defiant.localdomain>
	<1136227893.2936.51.camel@laptopd505.fenrus.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 02 Jan 2006 20:49:46 +0100
In-Reply-To: <1136227893.2936.51.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon, 02 Jan 2006 19:51:32 +0100")
Message-ID: <m34q4mpfz9.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> you know what? gcc inlines those automatic even without you typing
> "inline". (esp if you have unit-at-a-time enabled)

And if it's not or if it's an older gcc?
Such functions should always be inlined, except maybe while debugging.

> well.. gcc is not stupid, especially if you give it visibility by
> enabling unit-at-a-time.

A *.c author can't do that. Who knows what flags will be used?

> you save about 1 cycle by inlining unless there is a trick for the
> optimizer.

There probably is but even without further optimizations I still save
at least that 1 cycle (and probably it caches better and have less stack
impact etc).

> Especially in the case you mention where gcc will dtrt...
> it's not worth typing "inline", what if you change the code later to use
> the function twice... most people at least forget to remove the
> redundant inline, turning it into a bloater...

I'd probably not forget that. BTW: most people don't write Linux.
Still, in cases where there are only gains and nothing to lose, why
not use some form of "inline"?

We could be more descriptive, though. An average reader should probably
be able to _read_ why is a particular function inlined, without guessing.
That would also help WRT different gcc options and versions, and it would
help checking if the "inline" is indeed correct (a public function with
callers all over the place marked as "one caller static" would be
obviously incorrect).
-- 
Krzysztof Halasa
