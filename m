Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWACD7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWACD7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 22:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWACD7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 22:59:23 -0500
Received: from nevyn.them.org ([66.93.172.17]:15564 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750980AbWACD7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 22:59:22 -0500
Date: Mon, 2 Jan 2006 22:59:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Arjan van de Ven <arjan@infradead.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060103035904.GB31798@nevyn.them.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Krzysztof Halasa <khc@pm.waw.pl>, Ingo Molnar <mingo@elte.hu>,
	Adrian Bunk <bunk@stusta.de>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	mpm@selenic.com
References: <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <1136227893.2936.51.camel@laptopd505.fenrus.org> <20060102222335.GB5412@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102222335.GB5412@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 10:23:35PM +0000, Russell King wrote:
> On Mon, Jan 02, 2006 at 07:51:32PM +0100, Arjan van de Ven wrote:
> > On Mon, 2006-01-02 at 19:44 +0100, Krzysztof Halasa wrote:
> > > Ingo Molnar <mingo@elte.hu> writes:
> > > 
> > > > what is the 'deeper problem'? I believe it is a combination of two 
> > > > (well-known) things:
> > > >
> > > >   1) people add 'inline' too easily
> > > >   2) we default to 'always inline'
> > > 
> > > For example, I add "inline" for static functions which are only called
> > > from one place.
> > 
> > you know what? gcc inlines those automatic even without you typing
> > "inline". (esp if you have unit-at-a-time enabled)
> 
> Rubbish it will.
> 
> static void fn1(void *f)
> {
> }
> 
> void fn2(void *f)
> {
>         fn1(f);
> }
> 
> on ARM produces:

On 3.4, 4.0, and 4.1 you only need -O for this (I just checked both x86
and ARM compilers).  I believe this came in with unit-at-a-time, as
Arjan said - which was GCC 3.4.

-- 
Daniel Jacobowitz
CodeSourcery
