Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWABTyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWABTyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWABTyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:54:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31682 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750994AbWABTy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:54:27 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
In-Reply-To: <m34q4mpfz9.fsf@defiant.localdomain>
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
	 <m34q4mpfz9.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 20:54:16 +0100
Message-Id: <1136231656.2936.57.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 20:49 +0100, Krzysztof Halasa wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > you know what? gcc inlines those automatic even without you typing
> > "inline". (esp if you have unit-at-a-time enabled)
> 
> And if it's not or if it's an older gcc?

older than 3.0? that's not possible much longer

> > well.. gcc is not stupid, especially if you give it visibility by
> > enabling unit-at-a-time.
> 
> A *.c author can't do that. Who knows what flags will be used?
> 

the author should assume sane flags ;)

> > you save about 1 cycle by inlining unless there is a trick for the
> > optimizer.
> 
> There probably is but even without further optimizations I still save
> at least that 1 cycle (and probably it caches better and have less stack
> impact etc).

actually that's no so sure. especially with the current regparm
callingconvention. Inlining will cause more spills, which causes more
stack usage. It's doubtful the extra space you use with "call" will
outweigh that.

> > Especially in the case you mention where gcc will dtrt...
> > it's not worth typing "inline", what if you change the code later to use
> > the function twice... most people at least forget to remove the
> > redundant inline, turning it into a bloater...
> 
> I'd probably not forget that. BTW: most people don't write Linux.
> Still, in cases where there are only gains and nothing to lose, why
> not use some form of "inline"?

it's by far not only gains. And maintenance costs too.


