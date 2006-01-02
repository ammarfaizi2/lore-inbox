Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWABSvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWABSvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWABSvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:51:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18374 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750952AbWABSvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:51:46 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
In-Reply-To: <m3ek3qcvwt.fsf@defiant.localdomain>
References: <20051229224839.GA12247@elte.hu>
	 <1135897092.2935.81.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	 <20060102103721.GA8701@elte.hu>
	 <1136198902.2936.20.camel@laptopd505.fenrus.org>
	 <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
	 <m3ek3qcvwt.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 19:51:32 +0100
Message-Id: <1136227893.2936.51.camel@laptopd505.fenrus.org>
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

On Mon, 2006-01-02 at 19:44 +0100, Krzysztof Halasa wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > what is the 'deeper problem'? I believe it is a combination of two 
> > (well-known) things:
> >
> >   1) people add 'inline' too easily
> >   2) we default to 'always inline'
> 
> For example, I add "inline" for static functions which are only called
> from one place.

you know what? gcc inlines those automatic even without you typing
"inline". (esp if you have unit-at-a-time enabled)

> 
> If I'm able to say "this is static function which is called from one
> place" I'd do so instead of saying "inline". But omitting the "inline"
> with hope that some new gcc probably will inline it anyway (on some
> platform?) doesn't seem like a best idea.

well.. gcc is not stupid, especially if you give it visibility by
enabling unit-at-a-time. It *WILL* inline static-used-once functions
unless there is a technical reason not to (say variable sized arrays)
> 
> But what _is_ the best idea?

you save about 1 cycle by inlining unless there is a trick for the
optimizer. Especially in the case you mention where gcc will dtrt...
it's not worth typing "inline", what if you change the code later to use
the function twice... most people at least forget to remove the
redundant inline, turning it into a bloater...


