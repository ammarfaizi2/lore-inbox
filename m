Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbUJ1TtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUJ1TtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUJ1TtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:49:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46343 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261962AbUJ1Toe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:44:34 -0400
Date: Thu, 28 Oct 2004 20:44:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: kbuild/all archs: Sanitize creating offsets.h
Message-ID: <20041028204430.C11436@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041028185917.GA9004@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 28, 2004 at 08:59:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 08:59:18PM +0200, Sam Ravnborg wrote:
> When creating offsets.h from arch/$(ARCH)/Makefile we failed to check
> all dependencies. A few key dependencies were listed - but a manually
> edited list of include files are bound to be incomplete.
> A few times I have tried building a kernel - which failed because
> offsets.h needed to be updated but kbuild failed to do so.
> I wonder what could happen with a kernel with an out-dated offsets.h
> file with wrong assembler constants.

This fails:

rmk@dyn-67:[linux-2.6-rmk]:<1041> amake O=../build/rpc
  Using /home/rmk/bk/linux-2.6-rmk as source for kernel
  GEN    /home/rmk/bk/build/rpc/Makefile
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  GEN    /home/rmk/bk/build/rpc/Makefile
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/mconf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  HOSTCC  -fPIC scripts/kconfig/zconf.tab.o
  HOSTLLD -shared scripts/kconfig/libkconfig.so
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/arm/Kconfig
#
# using defaults found in .config
#
  SPLIT   include/linux/autoconf.h -> include/config/*
/home/rmk/bk/linux-2.6-rmk/scripts/Makefile.build:13: /home/rmk/bk/linux-2.6-rmk/include/asm/Makefile: No such file or directory
make[2]: *** No rule to make target `/home/rmk/bk/linux-2.6-rmk/include/asm/Makefile'.  Stop.
make[1]: *** [prepare0] Error 2
make: *** [_all] Error 2

../build/rpc only contained .version and .config

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
