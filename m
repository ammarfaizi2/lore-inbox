Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUJSCRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUJSCRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 22:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUJSCRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 22:17:31 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:4280 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267863AbUJSCR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 22:17:26 -0400
Date: Tue, 19 Oct 2004 04:17:19 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.9 BK build broken
Message-ID: <20041019021719.GA22924@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BitKeeper fails to build (error message with GCC 3.4, ICE with GCC 3.3):

Parent repository is bk://linux.bkbits.net/linux-2.5
MD5KEY: 417454bfpfdm0m7rr7xnJadPA4ioZA

KEY of latest changeset:
torvalds@ppc970.osdl.org|ChangeSet|20041018234151|19286

$ LANG=C make CC=/opt/gcc-3.4/bin/gcc
...
  LDS     arch/i386/kernel/vsyscall.lds
  AS      arch/i386/kernel/vsyscall-int80.o
  SYSCALL arch/i386/kernel/vsyscall-int80.so
  AS      arch/i386/kernel/vsyscall-sysenter.o
  SYSCALL arch/i386/kernel/vsyscall-sysenter.so
  AS      arch/i386/kernel/vsyscall.o
In file included from include/linux/init.h:5,
                 from arch/i386/kernel/vsyscall.S:1:
include/linux/compiler.h:20: syntax error in macro parameter list
make[1]: *** [arch/i386/kernel/vsyscall.o] Error 1
make: *** [arch/i386/kernel] Error 2

$ nl -ba include/linux/compiler.h | grep -5 20
    15  # define __safe
    16  # define __force
    17  # define __iomem
    18  # define __chk_user_ptr(x) (void)0
    19  # define __chk_io_ptr(x) (void)0
    20  #define __builtin_warning(x, ...) (1)
    21  #endif
    22
    23  #ifdef __KERNEL__
    24
    25  #ifndef __ASSEMBLY__

$ /opt/gcc-3.4/bin/gcc --version
gcc (GCC) 3.4.2
Copyright (C) 2004 Free Software Foundation, Inc.
...

-- 
Matthias Andree
