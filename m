Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTDSRGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 13:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTDSRGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 13:06:18 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:1804 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id S263418AbTDSRGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 13:06:17 -0400
Message-ID: <3EA18498.90AAF8B5@compuserve.com>
Date: Sat, 19 Apr 2003 13:17:12 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.66 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: new unresolves in 2.6.67 bk
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice several new build failures in bk latest for some scsi and net
drivers when built-in.  I haven't tried these as modules.  For example:

*** Warning: "restore_flags" [drivers/net/ni65.ko] undefined!
*** Warning: "cli" [drivers/net/ni65.ko] undefined!
*** Warning: "save_flags" [drivers/net/ni65.ko] undefined!
*** Warning: "restore_flags" [drivers/net/ni5010.ko] undefined!
*** Warning: "cli" [drivers/net/ni5010.ko] undefined!
*** Warning: "save_flags" [drivers/net/ni5010.ko] undefined!
*** Warning: "restore_flags" [drivers/net/82596.ko] undefined!
*** Warning: "cli" [drivers/net/82596.ko] undefined!
*** Warning: "save_flags" [drivers/net/82596.ko] undefined!

When the PSI240i driver is enabled:

  gcc -Wp,-MD,drivers/scsi/.psi240i.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
-DMODULE   -DKBUILD_BASENAME=psi240i -DKBUILD_MODNAME=psi240i -c -o
drivers/scsi/psi240i.o drivers/scsi/psi240i.c
drivers/scsi/psi240i.c: In function `Psi240i_QueueCommand':
drivers/scsi/psi240i.c:393: structure has no member named `host'
drivers/scsi/psi240i.c:394: structure has no member named `target'
drivers/scsi/psi240i.c: In function `Psi240i_Detect':
drivers/scsi/psi240i.c:578: warning: `__check_region' is deprecated
(declared at include/linux/ioport.h:113)
drivers/scsi/psi240i.c:604: warning: implicit declaration of function
`save_flags'
drivers/scsi/psi240i.c:605: warning: implicit declaration of function
`cli'
drivers/scsi/psi240i.c:609: warning: implicit declaration of function
`restore_flags'
drivers/scsi/psi240i.c: At top level:
drivers/scsi/psi240i.c:720: warning: initialization from incompatible
pointer type
drivers/scsi/psi240i.c:720: warning: initialization from incompatible
pointer type
make[2]: *** [drivers/scsi/psi240i.o] Error 1
make[1]: *** [drivers/scsi] Error 2

-- 
Kevin
