Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUFORzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUFORzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUFORzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:55:19 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43169 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S265795AbUFORyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:54:54 -0400
Date: Tue, 15 Jun 2004 10:54:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
Message-ID: <20040615175453.GD14528@smtp.west.cox.net>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040615154136.GD11113@smtp.west.cox.net> <20040615174929.GB2310@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615174929.GB2310@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 07:49:29PM +0200, Sam Ravnborg wrote:

> On Tue, Jun 15, 2004 at 08:41:36AM -0700, Tom Rini wrote:
> > On Mon, Jun 14, 2004 at 10:40:29PM +0200, Sam Ravnborg wrote:
> > 
> > > Hi Andrew. Here follows a number of kbuild patches.
> > > 
> > > The first replaces kbuild-specify-default-target-during-configuration.patch
> > > 
> > > They have seen ligiht testing here, but on the other hand the do not touch
> > > any critical part of kbuild.
> > > 
> > > Patches:
> > > 
> > > default kernel image:		Specify default target at config
> > > 				time rather then hardcode it.
> > > 				Only enabled for i386 for now.
> > 
> > While I'd guess this is better than the patch it's replacing, given that
> > most i386 kernels are 'bzImage', what's wrong with the current logic
> > that picks out what to do for the all target now?
> 
> Compared to the original behaviour where the all: target picked the default
> target for a given architecture, this patch adds the following:
> 
> - One has to select the default kernel image only once
>   when configuring the kernel.

in the case where 'all' wasn't correct to start with.  And i386 isn't
the convincing case here.

> - There exist a possibility to add more than half a line of text
>   describing individual targets. All relevant information can be
>   specified in the help section in the Kconfig file

Honestly, I'm indifferent to this.  This problem is equally, if not
better solved by documenting in the board-specific help "and use 'make
fooImage for foo firmware"

> - Other programs now have access to what kernel image has been built.
>   This is needed when creating kernel packages like rpm.

I suppose this can clean up some of the globbing that might otherwise be
done, but I know for a fact that there's been kernel rpms before this :)

> Where I see this really pay off is for architectures like MIPS with
> at least four different targets, depending on selected config.
> When one has selected to build a certain kernel, including a specific
> bootloader only the make command is needed.
> No need to remember the 'make rom.bin' or whatever target.

This is where I see it blowing up, quite badly.  As Russell noted,
you're going to have a horrible, unmaintainable list of boards and
firmware supported, or not, on each.  Even on PPC32 where we really only
have "needs vmlinux, raw", "needs vmlinux, for U-Boot" and "can use
arch/ppc/boot/", it'll still get ugly noting which boards can use
U-Boot, which can use arch/ppc/boot/ and which can use both.

> But this trigger the discussion how much should actually be
> part of the kernel.

Yes, there's that another discussion, which at least I'm not talking
about right now.  What I, and I think Russell as well, are noting is
that doing this is will make what we have in the kernel much uglier /
less maintainable.

-- 
Tom Rini
http://gate.crashing.org/~trini/
