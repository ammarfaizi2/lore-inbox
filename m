Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWAPXUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWAPXUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWAPXUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:20:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:49680 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751270AbWAPXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:20:05 -0500
Date: Tue, 17 Jan 2006 00:19:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Eric Sandeen <sandeen@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060116231952.GA8752@mars.ravnborg.org>
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <43C2CFBD.8040901@sgi.com> <20060109234532.78bda36a.akpm@osdl.org> <43C3E222.7020203@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C3E222.7020203@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 10:34:42AM -0600, Eric Sandeen wrote:
> Andrew Morton wrote:
> >It'd be nice to fix this:
> >
> >bix:/usr/src/25> make fs/xfs/linux-2.6/xfs_iops.o
> >  SPLIT   include/linux/autoconf.h -> include/config/*
> >  SHIPPED scripts/genksyms/lex.c
> >  SHIPPED scripts/genksyms/parse.h
> >  SHIPPED scripts/genksyms/keywords.c
> >  HOSTCC  scripts/genksyms/lex.o
> >  SHIPPED scripts/genksyms/parse.c
> >  HOSTCC  scripts/genksyms/parse.o
> >  HOSTLD  scripts/genksyms/genksyms
> >  HOSTCC  scripts/mod/file2alias.o
> >  HOSTCC  scripts/mod/modpost.o
> >  HOSTLD  scripts/mod/modpost
> >scripts/Makefile.build:15: /usr/src/devel/fs/xfs/linux-2.6/Makefile: No 
> >such file or directory
> >make[1]: *** No rule to make target 
> >`/usr/src/devel/fs/xfs/linux-2.6/Makefile'.  Stop.
> >make: *** [fs/xfs/linux-2.6/xfs_iops.o] Error 2
> 
> Hm, maybe Sam can correct me if I'm wrong, but I'm not sure that kbuild 
> will support more than one Makefile/Kbuild file per module; so if we have 
> some code in a subdirectory, I think it all needs to be driven from the 
> parent directory's Makefile... and then the above doesn't work.
> 
> Sam, is there any way to make this work with some code for the module in a 
> subdirectory?

Hi Eric.
I forgot to point out one ugly solution for this.
You can include a dummy Kbuild (Makefile) in each directory to support
this. I recall that reiser4 had similar question and this was the
solution I pointed out for them too.
No - I am not in favour of it. But for local development it could make
sense.
So it may solve the "Eric" part of it, but not the "Andrew" part of it
since these file will never get in the mainstream kernel (hopefully).

	Sam
