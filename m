Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVIKIaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVIKIaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 04:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVIKIaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 04:30:15 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:60304 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751058AbVIKIaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 04:30:14 -0400
Date: Sun, 11 Sep 2005 10:31:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050911083153.GA24176@mars.ravnborg.org>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911023203.GH25261@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> BTW, early build stages on uml with O= are still broken, even with that
> patch.  The following fixes them, but first chunk is a bad kludge.
> 
> What happens:
> 	a) silentconfig expects to have include/linux in build tree already
> created.  Normally that happens earlier, but only by accident.  We need to
> force that somehow and the way I'd done it is almost certainly wrong - it
> should be in top-level makefile, to start with.  Suggestions?

We could stick a `mkdir -p include/linux` command just before executing
$(Q)$(MAKE) $(build)=scripts/kconfig silentoldconfig

It should do the trick - no?

> 	b) kernel-offsets.h needs symlinks already in place.  prepare1 does
> everything we need, so that dependency is probably the right thing (the second
> chunk).

I will try to take a closer look at this tonight.
As always my head starts spinning when I look at the arch/um/Makefile
but I will see what I can do.
If I can simplify it and introduce full dependency checks it would be
really nice. 
It may add a Kbuild file to arch/um with the rules
for generating the header files.

	Sam
