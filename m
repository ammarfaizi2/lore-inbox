Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWIILdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWIILdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWIILdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:33:55 -0400
Received: from mail.gmx.de ([213.165.64.20]:40933 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932081AbWIILdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:33:54 -0400
X-Authenticated: #14349625
Subject: 2.6.18-rc6-mm1 breaks glibc build
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 13:44:14 +0000
Message-Id: <1157809454.19305.17.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

For whatever reason, glibc sets sysincludes to point to the running
kernel's include directory ala...
	sysincludes = -I /lib/modules/2.6.18-rc6-mm1-smp/build/include
in it's config.make instead of using installed headers, and this leads
to the compile failure below.

I just edited config.make to point to different headers, dunno if it
_should_ work as before (2.6.18-rc6 does) or not.

/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h: Assembler messages:
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:22: Error: no such instruction: `static inline void *ERR_PTR(long error)'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:23: Error: junk at end of line, first unrecognized character is `{'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:24: Error: no such instruction: `return (void *)error'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:25: Error: junk at end of line, first unrecognized character is `}'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:27: Error: no such instruction: `static inline long PTR_ERR(const void *ptr)'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:28: Error: junk at end of line, first unrecognized character is `{'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:29: Error: no such instruction: `return (long)ptr'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:30: Error: junk at end of line, first unrecognized character is `}'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:32: Error: no such instruction: `static inline long IS_ERR(const void *ptr)'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:33: Error: junk at end of line, first unrecognized character is `{'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:34: Error: no such instruction: `return unlikely(((unsigned long)ptr)>=(unsigned long)-4095)'
/lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h:35: Error: junk at end of line, first unrecognized character is `}'
make[2]: *** [/usr/local/src/gnu/glibc/snapshots/glibc-20060904/i686-suse-linux/csu/sysdep.o] Error 1
make[2]: Leaving directory `/usr/local/src/gnu/glibc/snapshots/glibc-20060904/csu'
make[1]: *** [csu/subdir_lib] Error 2
make[1]: Leaving directory `/usr/local/src/gnu/glibc/snapshots/glibc-20060904'
make: *** [all] Error 2

