Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWACJLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWACJLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 04:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWACJK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 04:10:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37848 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750750AbWACJK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 04:10:59 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
In-Reply-To: <20060103090046.GC31511@flint.arm.linux.org.uk>
References: <20060102103721.GA8701@elte.hu>
	 <1136198902.2936.20.camel@laptopd505.fenrus.org>
	 <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu>
	 <m3ek3qcvwt.fsf@defiant.localdomain>
	 <1136227893.2936.51.camel@laptopd505.fenrus.org>
	 <20060102222335.GB5412@flint.arm.linux.org.uk>
	 <20060103035904.GB31798@nevyn.them.org>
	 <20060103085335.GB31511@flint.arm.linux.org.uk>
	 <1136278587.2942.3.camel@laptopd505.fenrus.org>
	 <20060103090046.GC31511@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 10:10:51 +0100
Message-Id: <1136279451.2942.8.camel@laptopd505.fenrus.org>
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

On Tue, 2006-01-03 at 09:00 +0000, Russell King wrote:
> On Tue, Jan 03, 2006 at 09:56:26AM +0100, Arjan van de Ven wrote:
> > On Tue, 2006-01-03 at 08:53 +0000, Russell King wrote:
> > > On Mon, Jan 02, 2006 at 10:59:04PM -0500, Daniel Jacobowitz wrote:
> > > > On Mon, Jan 02, 2006 at 10:23:35PM +0000, Russell King wrote:
> > > > > static void fn1(void *f)
> > > > > {
> > > > > }
> > > > > 
> > > > > void fn2(void *f)
> > > > > {
> > > > >         fn1(f);
> > > > > }
> > > > > 
> > > > > on ARM produces:
> > > > 
> > > > On 3.4, 4.0, and 4.1 you only need -O for this (I just checked both x86
> > > > and ARM compilers).  I believe this came in with unit-at-a-time, as
> > > > Arjan said - which was GCC 3.4.
> > > 
> > > Well, as demonstrated, it doesn't work with gcc 3.3.  Since we aren't
> > > about to increase the minimum gcc version to 3.4, this isn't acceptable.
> > 
> > s/isn't acceptable/is suboptimal/
> 
> No - it's a case of going overboard with this inline removal idea.
> If we would prefer a function to be inlined because it is only used
> once, we should specify it as such rather than relying on some quirky
> idea that it _might_ do the right thing if we don't specify it

so for those gcc's one passes -finline-functions ....
(or -finline-functions-called-once if it's supported, which newer gccs
have again :)


