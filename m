Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbREVBAG>; Mon, 21 May 2001 21:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbREVA74>; Mon, 21 May 2001 20:59:56 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:64783 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S262215AbREVA7s>; Mon, 21 May 2001 20:59:48 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: John Stoffel <stoffel@casc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
In-Reply-To: Your message of "Mon, 21 May 2001 16:38:34 -0400."
             <15113.31946.548249.53012@gargle.gargle.HOWL> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 May 2001 10:59:04 +1000
Message-ID: <2436.990493144@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001 16:38:34 -0400, 
John Stoffel <stoffel@casc.com> wrote:
>All that CML2 does is enforce dependencies in the configuration
>language.  You can't make a .config which conflicts.  Admittedly
>there's nothing stopping you from hacking it with vi after the fact,
>but why?

CML2 will not stop you hacking .config by hand.  But the 2.5 makefile
rewrite will, because we have had too many bug reports caused by people
who hand edited .config, did not revalidate it and generated invalid
kernels.  Yes, you can hand edit .config.  No, you cannot compile until
.config has been (re-)validated.

# Not a real dependency, this checks for hand editing of .config.
$(KBUILD_OBJTREE)include/linux/autoconf.h: $(KBUILD_OBJTREE).config
        @echo Your .config is newer than include/linux/autoconf.h, this should not happen.
        @echo Always run make one of "{menu,old,x}config" after manually updating .config.
        @/bin/false

And before people complain: Don't create a config that violates the CML
rules, correct the CML rules, the Makefiles and the source so .config
is valid.  The kernel build requires a valid .config.

