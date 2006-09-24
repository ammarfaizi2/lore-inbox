Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWIXUr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWIXUr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWIXUr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:47:29 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:60371 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932086AbWIXUr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:47:29 -0400
Date: Sun, 24 Sep 2006 22:52:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060924205244.GA26774@uranus.ravnborg.org>
References: <20060923154416.GH29920@ftp.linux.org.uk> <20060923202912.GA22293@uranus.ravnborg.org> <20060923203605.GN29920@ftp.linux.org.uk> <20060924064446.GA13320@uranus.ravnborg.org> <20060924191917.GQ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924191917.GQ29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 08:19:17PM +0100, Al Viro wrote:
> 
> > Looking through asm-i386/io.h at fist look there is zero use of
> > linux/vmalloc.h so the include has no business there.
> 
> There are obvious asm/page.h uses, so just ripping it out won't be enough.
> Even for that particular case.  And we have shitloads of places were
> asm-foo/bar.h genuinely needs linux/baz.h for e.g. implementation of
> an inlined helper.  With other targets not needing it at all.  Would you
> mandate including it from every user of asm/foo.h?  And maintain such
> rules afterwards ("asm/foo.h needs linux/baz.h included before it since
> on $WEIRD_TARGET we include asm/unique_turd.h that won't compile unless
> linux/baz.h will be aready there").

The only thing I like to see is minimal suprise. And minimal suprise in
this case is to be considered as "works on almost all archs if not all".
In practical terms it could be that users of asm/* had to include
baz.h before bar.h. Or we could stick to current mess where one has
to have a shitload of crosscompiles and CPU power to check even trivial
changes to a few include files.

Partly this could be fixed by making header files in asm-$(ARCH)
second class citizen - that always got included via their linux/
counterpart.

Take a look at uaccess.h for example.
A grep shows that most architectures include almost the same header files
with a few that require string.h.
So it would be so simple to move the include of string.h to the
linux/uaccess.h counter part and no arch specific dependencies.

Grepping the tree I only find one user of linux/uaccess.h : filemap.*
But even though my point holds that there are easy way to deal with this
without the maintenace nightmare you try to picture up.

That said this would maybe work in two third of the cases and is no
bullet proof solution. But each time we can decrease the arch differences
we are one step in the right direction.

	Sam
