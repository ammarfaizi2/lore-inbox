Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVBYWEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVBYWEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVBYWE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:04:29 -0500
Received: from nevyn.them.org ([66.93.172.17]:30352 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262321AbVBYWDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:03:17 -0500
Date: Fri, 25 Feb 2005 17:03:00 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>, Paulo Marques <pmarques@grupopie.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050225220259.GA4797@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Paulo Marques <pmarques@grupopie.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk> <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk> <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org> <20050225202349.C27842@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225202349.C27842@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 08:23:49PM +0000, Russell King wrote:
> On Fri, Feb 25, 2005 at 11:59:01AM -0800, Linus Torvalds wrote:
> > On Fri, 25 Feb 2005, Russell King wrote:
> > > So, what's happening about this?
> > 
> > Btw, is there any real reason why the ARM _tools_ can't just be fixed? I 
> > don't see why this isn't a tools bug?
> 
> It is a tools bug.  But the issue is that *all* versions of binutils
> currently available which are kernel-capable (since the inclusion of
> the kbuild .incbin requirement on binutils) have this bug, with the
> exception of maybe CVS versions.
> 
> We can't say "you must use the current CVS binutils to build the
> kernel" because that's not a sane toolchain base to build products
> on.
> 
> I've been wanting to see a version of binutils released pretty damn
> quick so I can say "kernel only builds with latest toolchain" but
> I suspect even that's going to be seen as being unreasonable.

Not sure who you asked, but since I run the binutils releases...

I am fairly positive that this bug has been fixed in the binutils CVS:

2004-07-02  Nick Clifton  <nickc@redhat.com>

        * config/tc-arm.c (md_apply_fix3:BFD_RELOC_ARM_IMMEDIATE): Do not
        allow values which have come from undefined symbols.
        Always consider this fixup to have been processed as a reloc
        cannot be generated for it.

I know several ARM kernel developers who are using tools with this
patch applied already.  Also, I anticipate the release of binutils 2.16
including the fix in about a month.

> And yes, the toolchain peoples point of view is "fix the kernel".

Huh?  Obviously the kernel isn't broken, unless you're talking about
the kallsyms checks now.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
