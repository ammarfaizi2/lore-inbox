Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbUJ1UHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUJ1UHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUJ1UCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:02:20 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:39766 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262160AbUJ1T7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:59:40 -0400
Date: Thu, 28 Oct 2004 23:59:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: kbuild/all archs: Sanitize creating offsets.h
Message-ID: <20041028215959.GA17314@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028204430.C11436@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028204430.C11436@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 08:44:30PM +0100, Russell King wrote:
> On Thu, Oct 28, 2004 at 08:59:18PM +0200, Sam Ravnborg wrote:
> > When creating offsets.h from arch/$(ARCH)/Makefile we failed to check
> > all dependencies. A few key dependencies were listed - but a manually
> > edited list of include files are bound to be incomplete.
> > A few times I have tried building a kernel - which failed because
> > offsets.h needed to be updated but kbuild failed to do so.
> > I wonder what could happen with a kernel with an out-dated offsets.h
> > file with wrong assembler constants.
> 
> This fails:
> 
> rmk@dyn-67:[linux-2.6-rmk]:<1041> amake O=../build/rpc
>   Using /home/rmk/bk/linux-2.6-rmk as source for kernel
>   GEN    /home/rmk/bk/build/rpc/Makefile
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   GEN    /home/rmk/bk/build/rpc/Makefile
>   SHIPPED scripts/kconfig/zconf.tab.h
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/mconf.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
>   HOSTLLD -shared scripts/kconfig/libkconfig.so
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf -s arch/arm/Kconfig
> #
> # using defaults found in .config
> #
>   SPLIT   include/linux/autoconf.h -> include/config/*
> /home/rmk/bk/linux-2.6-rmk/scripts/Makefile.build:13: /home/rmk/bk/linux-2.6-rmk/include/asm/Makefile: No such file or directory
> make[2]: *** No rule to make target `/home/rmk/bk/linux-2.6-rmk/include/asm/Makefile'.  Stop.
> make[1]: *** [prepare0] Error 2
> make: *** [_all] Error 2
> 
> ../build/rpc only contained .version and .config

Did you apply the patch that enabled kbuild files to be named Kbuild?
It looks like this patch is missing.

If you did apply the patch could you please check if the asm->asm-arm symlink exists
when the error happens and that a file named Kbuild is located in the directory:
include/asm-arm/

	Sam
