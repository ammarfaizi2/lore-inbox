Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbUJ1VCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbUJ1VCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUJ1VCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:02:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32008 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262895AbUJ1VA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:00:29 -0400
Date: Thu, 28 Oct 2004 22:00:24 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: kbuild/all archs: Sanitize creating offsets.h
Message-ID: <20041028220024.D11436@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028204430.C11436@flint.arm.linux.org.uk> <20041028215959.GA17314@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041028215959.GA17314@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 28, 2004 at 11:59:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 11:59:59PM +0200, Sam Ravnborg wrote:
> >   SPLIT   include/linux/autoconf.h -> include/config/*
> > /home/rmk/bk/linux-2.6-rmk/scripts/Makefile.build:13: /home/rmk/bk/linux-2.6-rmk/include/asm/Makefile: No such file or directory
> > make[2]: *** No rule to make target `/home/rmk/bk/linux-2.6-rmk/include/asm/Makefile'.  Stop.
> > make[1]: *** [prepare0] Error 2
> > make: *** [_all] Error 2
> > 
> > ../build/rpc only contained .version and .config
> 
> Did you apply the patch that enabled kbuild files to be named Kbuild?
> It looks like this patch is missing.

I applied three patches.  The first was "kbuild: Prefer Kbuild as name of
the kbuild files"

> If you did apply the patch could you please check if the asm->asm-arm
> symlink exists when the error happens and that a file named Kbuild is
> located in the directory: include/asm-arm/

In the source tree, I have:

drwxrwxr-x   2 rmk rmk  4096 Oct 28 20:38 include/asm
-rw-rw-r--   1 rmk rmk  1026 Oct 28 20:37 include/asm-arm/Kbuild

Note that kbuild created an extra directory called asm in the source
tree.  In the output tree:

rmk@dyn-67:[linux-2.6-rmk]:<1047> vdir ../build/rpc/include/
drwxr-xr-x  120 rmk rmk 4096 Oct 28 20:42 config
drwxrwxr-x    2 rmk rmk 4096 Oct 28 20:42 linux
rmk@dyn-67:[linux-2.6-rmk]:<1048> vdir ../build/rpc/include2/
total 0
lrwxrwxrwx  1 rmk rmk 42 Oct 28 20:42 asm -> /home/rmk/bk/linux-2.6-rmk/include/asm-arm

After removing ../build/rpc/include* and include/asm:

rmk@dyn-67:[linux-2.6-rmk]:<1050> amake O=../build/rpc
  Using /home/rmk/bk/linux-2.6-rmk as source for kernel
  GEN    /home/rmk/bk/build/rpc/Makefile
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-arm
  GEN    /home/rmk/bk/build/rpc/Makefile
scripts/kconfig/conf -s arch/arm/Kconfig
#
# using defaults found in .config
#
  SPLIT   include/linux/autoconf.h -> include/config/*
/home/rmk/bk/linux-2.6-rmk/scripts/Makefile.build:13: /home/rmk/bk/linux-2.6-rmk/include/asm/Makefile: No such file or directory
make[2]: *** No rule to make target `/home/rmk/bk/linux-2.6-rmk/include/asm/Makefile'.  Stop.
make[1]: *** [prepare0] Error 2
make: *** [_all] Error 2
rmk@dyn-67:[linux-2.6-rmk]:<1051> vdir ../build/rpc/include*
../build/rpc/include:
total 8
lrwxrwxrwx    1 rmk rmk    7 Oct 28 21:59 asm -> asm-arm
drwxr-xr-x  120 rmk rmk 4096 Oct 28 21:59 config
drwxrwxr-x    2 rmk rmk 4096 Oct 28 21:59 linux
 
../build/rpc/include2:
total 0
lrwxrwxrwx  1 rmk rmk 42 Oct 28 21:59 asm -> /home/rmk/bk/linux-2.6-rmk/include/asm-arm
rmk@dyn-67:[linux-2.6-rmk]:<1052> vdir include/
...
drwxrwxr-x   2 rmk rmk  4096 Oct 28 21:59 asm
drwxrwxr-x  25 rmk rmk  4096 Oct 28 20:37 asm-arm

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
