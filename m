Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUIIQnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUIIQnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUIIQn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:43:27 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:45706 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266257AbUIIQhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:37:23 -0400
Date: Thu, 9 Sep 2004 18:37:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc1-bk16] ppc32: Use $(addprefix ...) on arch/ppc/boot/lib/
Message-ID: <20040909163705.GA7830@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040909153031.GA2945@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909153031.GA2945@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 08:30:31AM -0700, Tom Rini wrote:
> The following makes arch/ppc/boot/lib/Makefile use $(addprefix ...) to
> get lib/zlib_inflate/ source code.  Previously we were manually setting
> the dependancy and invoking cc_o_c.  Worse, we were invoking the cmd
> version, not the rule version and thus when MODVERSIONS=y, we wouldn't
> do the .tmp_foo.o -> foo.o rename, and thus the compile would break.
> Using $(addprefix ...) gets us using the standard rules again (and is
> shorter to boot).

Your patch was pending my comments - sorry.


Why not:

lib-y := $(addprefix lib/zlib_inflate/,infblock.o infcodes.o inffast.o \
                                       inflate.o inftrees.o infutil.o)
lib-y += div64.o
lib-$(CONFIG_VGA_CONSOLE) += vreset.o kbd.o

No need to use that ugly relative path.
I do not like this way of selectng .o files. It will so
obviously break the build with make -j if there is no synchronisation
point. vmlinux provide this synchronisation point in this case.
But in this particular case I see no better alternative.

	Sam
