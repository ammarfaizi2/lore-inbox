Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263823AbUFXFU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUFXFU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 01:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUFXFU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 01:20:58 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:11697 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263823AbUFXFUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 01:20:55 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: LKML <linux-kernel@vger.kernel.org>
Date: Thu, 24 Jun 2004 15:20:49 +1000
Cc: rth@twiddle.net
Subject: [PATCH] 2.6.7 fix broken alpha build ptrace.c error
Message-ID: <20040624052049.GB20676@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When compiling an alpha 2.6.7 kernel the following
error was produced, attached is a patch that fixes
the build. I can supply a config file if necessary.
 
 alpha-linux-gcc -Wp,-MD,arch/alpha/kernel/.ptrace.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -msmall-data -mcpu=ev56 -Wa,-mev6 -O2 -fomit-frame-pointer  -Werror -Wno-sign-compare   -DKBUILD_BASENAME=ptrace -DKBUILD_MODNAME=ptrace -c -o arch/alpha/kernel/ptrace.o arch/alpha/kernel/ptrace.c
cc1: warnings being treated as errors
In file included from include/net/checksum.h:26,
                 from include/linux/skbuff.h:30,
                 from include/linux/security.h:34,
                 from arch/alpha/kernel/ptrace.c:16:
include/asm/checksum.h:75: warning: `struct in6_addr' declared inside parameter list
include/asm/checksum.h:75: warning: its scope is only this definition or declaration, which is probably not what you want
make[1]: *** [arch/alpha/kernel/ptrace.o] Error 1
make: *** [arch/alpha/kernel] Error 2

 Darren

--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alpha-2.6.7-build-fix.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/24 15:04:33+10:00 dsw@quasar.(none) 
#   Fix broken alpha build
# 
# include/asm-alpha/checksum.h
#   2004/06/24 15:04:23+10:00 dsw@quasar.(none) +1 -0
#   A change was made between 2.6.6 and 2.6.7 that breaks the alpha build.
#   This patch rectifies the problem, by including 'linux/in6.h'
#   
#   signed-off-by Darren Williams <dsw@gelato.unsw.edu.au>
# 
diff -Nru a/include/asm-alpha/checksum.h b/include/asm-alpha/checksum.h
--- a/include/asm-alpha/checksum.h	2004-06-24 15:06:28 +10:00
+++ b/include/asm-alpha/checksum.h	2004-06-24 15:06:28 +10:00
@@ -1,6 +1,7 @@
 #ifndef _ALPHA_CHECKSUM_H
 #define _ALPHA_CHECKSUM_H
 
+#include <linux/in6.h>
 
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,

--a8Wt8u1KmwUX3Y2C--
