Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266487AbUFUWCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266487AbUFUWCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUFUWCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:02:40 -0400
Received: from zeus.kernel.org ([204.152.189.113]:1994 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266487AbUFUWC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:02:27 -0400
Date: Mon, 21 Jun 2004 23:57:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 2/2] kbuild: Improved external module support
Message-ID: <20040621215705.GA2903@mars.ravnborg.org>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620212353.GD10189@mars.ravnborg.org> <Pine.GSO.4.58.0406211059030.6543@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0406211059030.6543@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 11:01:34AM +0200, Geert Uytterhoeven wrote:
> > +
> > +KERNELSRC    := $1
> > +KERNELOUTPUT := $2
> > +
> > +MAKEFLAGS += --no-print-directory
> > +
> > +all:
> > +	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT)
> > +
> > +%:
> > +	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@
> > +
> > +EOF
> 
> The generated Makefile looks sufficiently similar to the one I'm using, so I'm
> wondering: Does it work if I say e.g. `make drivers/char/mem.o'? For me that
> part never worked, but `make drivers/char/' does work.

The Makefile is derived from the one you posted, I just typed it by hand.
Therefore the variable names differ.

In the "Match-Anything Rules::" part of 'info make' the trick needed to
let 'make drivers/char/mem.o' work was described - thanks for reminding me of this issue.

The match-anything rule must be marked as terminal rule using double-colon - viola.

So the rule now looks:
%::
	\$(MAKE) -C \$(KERNELSRC) O=\$(KERNELOUTPUT) \$@


	Sam
