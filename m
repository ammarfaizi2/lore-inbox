Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264709AbUDVVrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbUDVVrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbUDVVrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:47:09 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:30810 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264709AbUDVVrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:47:04 -0400
Subject: 2.6.6-rc2 addition warnings with gcc-3.4.0 and some timing results.
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082670435.1324.106.camel@spc0.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-4mdk 
Date: Thu, 22 Apr 2004 15:47:15 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built the current 2.6.6-rc2 tree recently pulled from
bk://linus.bkbits.net/linux-2.5 using both gcc-3.3.2 as shipped with
Mandrake 10, and with the recent release of gcc-3.4.0, which was built
with all the defaults for an i686 system.

The builds were performed in two separate directories, each made with
bk export -tplain ../dirname.

The times are for a make -j3 bzImage on a dual PIII 733 Mhz system.
Make oldconfig was run first, using the same .config in each case.
The running kernel was 2.6.6-rc2 built with gcc-3.4.0.

Gcc-3.4.0 appears to be a little faster. The kernel builds were run
several times.  The time results were consistent.

A few additional warnings were received with gcc-3.4.0.

gcc-3.3.2	688.38user 52.69system 6:13.64elapsed 198%CPU 
$ size vmlinux
   text    data     bss     dec     hex filename
3064764  360496  176584 3601844  36f5b4 vmlinux

gcc-3.4.0	599.56user 40.25system 5:23.11elapsed 198%CPU
$ size vmlinux
   text    data     bss     dec     hex filename
3005436  359728  176552 3541716  360ad4 vmlinux

Warnings only with gcc-3.4.0:

  CC      arch/i386/pci/pcbios.o
arch/i386/pci/pcbios.c: In function `pcibios_get_irq_routing_table':
arch/i386/pci/pcbios.c:424: warning: read-write constraint does not allow a register
arch/i386/pci/pcbios.c:424: warning: read-write constraint does not allow a register

  CC      fs/xfs/xfs_iget.o
include/asm/rwsem.h: In function `xfs_ilock_nowait':
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register
include/asm/rwsem.h:126: warning: read-write constraint does not allow a register

Steven

