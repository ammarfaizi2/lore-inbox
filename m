Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWACJBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWACJBC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 04:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWACJBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 04:01:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37642 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750727AbWACJBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 04:01:01 -0500
Date: Tue, 3 Jan 2006 09:00:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060103090046.GC31511@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
	Adrian Bunk <bunk@stusta.de>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	mpm@selenic.com
References: <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <1136227893.2936.51.camel@laptopd505.fenrus.org> <20060102222335.GB5412@flint.arm.linux.org.uk> <20060103035904.GB31798@nevyn.them.org> <20060103085335.GB31511@flint.arm.linux.org.uk> <1136278587.2942.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136278587.2942.3.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 09:56:26AM +0100, Arjan van de Ven wrote:
> On Tue, 2006-01-03 at 08:53 +0000, Russell King wrote:
> > On Mon, Jan 02, 2006 at 10:59:04PM -0500, Daniel Jacobowitz wrote:
> > > On Mon, Jan 02, 2006 at 10:23:35PM +0000, Russell King wrote:
> > > > static void fn1(void *f)
> > > > {
> > > > }
> > > > 
> > > > void fn2(void *f)
> > > > {
> > > >         fn1(f);
> > > > }
> > > > 
> > > > on ARM produces:
> > > 
> > > On 3.4, 4.0, and 4.1 you only need -O for this (I just checked both x86
> > > and ARM compilers).  I believe this came in with unit-at-a-time, as
> > > Arjan said - which was GCC 3.4.
> > 
> > Well, as demonstrated, it doesn't work with gcc 3.3.  Since we aren't
> > about to increase the minimum gcc version to 3.4, this isn't acceptable.
> 
> s/isn't acceptable/is suboptimal/

No - it's a case of going overboard with this inline removal idea.
If we would prefer a function to be inlined because it is only used
once, we should specify it as such rather than relying on some quirky
idea that it _might_ do the right thing if we don't specify it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
