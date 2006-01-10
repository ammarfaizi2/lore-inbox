Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWAJUBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWAJUBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWAJUBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:01:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52494 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932283AbWAJUBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:01:23 -0500
Date: Tue, 10 Jan 2006 21:00:54 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sandeen <sandeen@sgi.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060110200054.GA14721@mars.ravnborg.org>
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <43C2CFBD.8040901@sgi.com> <20060109234532.78bda36a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109234532.78bda36a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 11:45:32PM -0800, Andrew Morton wrote:
> 
> It'd be nice to fix this:
> 
> bix:/usr/src/25> make fs/xfs/linux-2.6/xfs_iops.o
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   SHIPPED scripts/genksyms/lex.c
>   SHIPPED scripts/genksyms/parse.h
>   SHIPPED scripts/genksyms/keywords.c
>   HOSTCC  scripts/genksyms/lex.o
>   SHIPPED scripts/genksyms/parse.c
>   HOSTCC  scripts/genksyms/parse.o
>   HOSTLD  scripts/genksyms/genksyms
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/modpost.o
>   HOSTLD  scripts/mod/modpost
> scripts/Makefile.build:15: /usr/src/devel/fs/xfs/linux-2.6/Makefile: No such file or directory
> make[1]: *** No rule to make target `/usr/src/devel/fs/xfs/linux-2.6/Makefile'.  Stop.
> make: *** [fs/xfs/linux-2.6/xfs_iops.o] Error 2

xfs as one of the very few users in the kernel has split up .o files in
several directories. And kbuild does not have support for specifying
that is shall link to a .o file that is being build in a sub-directory.

This is in general noe encouraged for the kernel - it is not common
practice. And therefore not something I have planned to implement.

If there is a general consensus that we like to have this then it is
doable, but it will uglify scripts/Makefile.lib even more.

For xfs this is 37 .o files that are build in three directories.
The easy fix would be to move the files to stay just under the xfs/
directory like all others - but xfs people prefer not to do so to stay
compatible with their external source tree.

	Sam
