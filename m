Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265957AbUFTWHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265957AbUFTWHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUFTWHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:07:16 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:52547 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265957AbUFTWHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:07:11 -0400
Date: Mon, 21 Jun 2004 00:18:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040620221824.GA10586@mars.ravnborg.org>
Mail-Followup-To: Martin Schlemmer <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org> <1087767034.14794.42.camel@nosferatu.lan> <20040620220319.GA10407@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620220319.GA10407@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 12:03:19AM +0200, Sam Ravnborg wrote:
> If I get just one good example I will go for the object directory, but
> what I have seen so far is whining - no examples.

Now I recall why I did not like the object directory.
I will break all modules using the kbuild infrastructure!

Why, because there is no way the to find the output directory except
specifying both directories.
One could do:
make -C /lib/modules/`uname -r`/source O=/lib/modules/`uname -r`/build M=`pwd`

So the currect choice is:
1) Break modules that actually dive into the src, grepping, including or whatever
2) Break all modules using kbuild infrastructure, including the above ones

I go for 1), introducing minimal breakage.

And please keep in mind. The breakage wil _only_ be visible when kernels are
shipped with separate output directory.
If kernels are shipped with no output files at all then one can just
compile the kernel. Seems to be the Fedora way. No breakage happens.

If kernels are shipped with mixed source and output then no breakage happens.

If kernels are shipped with separate source and output then we better break
as few modules as possible. And the introduced change actually minimize breakage.

So the patch will not change.

	Sam
