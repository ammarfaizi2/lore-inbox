Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263520AbTDTDcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 23:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTDTDcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 23:32:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:61339 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263520AbTDTDck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 23:32:40 -0400
Date: Sat, 19 Apr 2003 20:06:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 604] New: CONFIG_SOFTWARE_SUSPEND should depend on CONFIG_SWAP 
Message-ID: <2260000.1050807981@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=604

           Summary: CONFIG_SOFTWARE_SUSPEND should depend on CONFIG_SWAP
    Kernel Version: 2.5.67 proper
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: andi@lisas.de


Distribution:
Hardware Environment:
Software Environment:
See #603

Problem Description:
Compiling CONFIG_SOFTWARE_SUSPEND without CONFIG_SWAP set leads to:
  gcc -Wp,-MD,kernel/.suspend.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototyp
es -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-b
oundary=2 -march=pentium3 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix
 include    -DKBUILD_BASENAME=suspend -DKBUILD_MODNAME=suspend -c -o kernel/susp
end.o kernel/suspend.c
kernel/suspend.c: In function `freeze_processes':
kernel/suspend.c:228: warning: comparison of distinct pointer types lacks a cast
kernel/suspend.c:293:2: warning: #warning This might be broken. We need to someh
ow wait for data to reach the disk
kernel/suspend.c: In function `mark_swapfiles':
kernel/suspend.c:321: warning: implicit declaration of function `rw_swap_page_sy
nc'
kernel/suspend.c: In function `read_swapfiles':
kernel/suspend.c:350: warning: implicit declaration of function `swap_list_lock'
kernel/suspend.c:352: `swap_info' undeclared (first use in this function)
kernel/suspend.c:352: (Each undeclared identifier is reported only once
kernel/suspend.c:352: for each function it appears in.)
kernel/suspend.c:377: warning: implicit declaration of function `swap_list_unloc
k'
kernel/suspend.c: In function `lock_swapdevices':
kernel/suspend.c:388: `swap_info' undeclared (first use in this function)
make[2]: *** [kernel/suspend.o] Error 1
make[1]: *** [kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.67'
make: *** [stamp-build] Error 2


I'm not sure whether CONFIG_SOFTWARE_SUSPEND should simply not be displayed if
CONFIG_SWAP is not set or whether CONFIG_SOFTWARE_SUSPEND should mention
CONFIG_SWAP requirement...
Whatever should be done, it shouldn't fail with such a compile error...


