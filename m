Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRGWWfk>; Mon, 23 Jul 2001 18:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRGWWfa>; Mon, 23 Jul 2001 18:35:30 -0400
Received: from Campbell.cwx.net ([216.17.176.12]:48655 "EHLO campbell.cwx.net")
	by vger.kernel.org with ESMTP id <S261289AbRGWWfN>;
	Mon, 23 Jul 2001 18:35:13 -0400
Message-ID: <3B5CA6A1.4050807@campbell.cwx.net>
Date: Mon, 23 Jul 2001 16:35:13 -0600
From: Allen Campbell <lkml@campbell.cwx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FYI: vmware breakage w/2.4.7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

2.4.7 appears to break vmware (latest build: 1142.)  Looks like some
#defines moved. The vmmon build produces the following noise:

Building the vmmon module.

make: Entering directory `/tmp/vmware-config1/vmmon-only'
make[1]: Entering directory `/tmp/vmware-config1/vmmon-only'
make[2]: Entering directory `/tmp/vmware-config1/vmmon-only/driver-2.4.7'
make[2]: Leaving directory `/tmp/vmware-config1/vmmon-only/driver-2.4.7'
make[2]: Entering directory `/tmp/vmware-config1/vmmon-only/driver-2.4.7'
In file included from /usr/src/linux/include/linux/highmem.h:5,
                 from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/usr/src/linux/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux/include/asm/pgalloc.h:56: `PAGE_OFFSET' undeclared (first 
use in
this function)
/usr/src/linux/include/asm/pgalloc.h:56: (Each undeclared identifier is 
reported
 only once
/usr/src/linux/include/asm/pgalloc.h:56: for each function it appears in.)
/usr/src/linux/include/asm/pgalloc.h: In function `pte_alloc_one':
/usr/src/linux/include/asm/pgalloc.h:103: `PAGE_SIZE' undeclared (first 
use in t
his function)
In file included from /usr/src/linux/include/linux/pagemap.h:16,
                 from /usr/src/linux/include/linux/locks.h:8,
                 from /usr/src/linux/include/linux/devfs_fs_kernel.h:6,
                 from /usr/src/linux/include/linux/miscdevice.h:4,
                 from ../linux/driver.h:10,
                 from .././linux/driver.c:58:
/usr/src/linux/include/linux/highmem.h: In function `clear_user_highpage':
/usr/src/linux/include/linux/highmem.h:48: `PAGE_SIZE' undeclared (first 
use in
this function)
/usr/src/linux/include/linux/highmem.h: In function `clear_highpage':
/usr/src/linux/include/linux/highmem.h:54: `PAGE_SIZE' undeclared (first 
use in
this function)
/usr/src/linux/include/linux/highmem.h: In function `memclear_highpage':
/usr/src/linux/include/linux/highmem.h:62: `PAGE_SIZE' undeclared (first 
use in
this function)
/usr/src/linux/include/linux/highmem.h: In function 
`memclear_highpage_flush':
/usr/src/linux/include/linux/highmem.h:76: `PAGE_SIZE' undeclared (first 
use in
this function)
/usr/src/linux/include/linux/highmem.h: In function `copy_user_highpage':
/usr/src/linux/include/linux/highmem.h:90: `PAGE_SIZE' undeclared (first 
use in
this function)
/usr/src/linux/include/linux/highmem.h: In function `copy_highpage':
/usr/src/linux/include/linux/highmem.h:101: `PAGE_SIZE' undeclared 
(first use in
 this function)
.././linux/driver.c: In function `LinuxDriver_Ioctl':
.././linux/driver.c:928: structure has no member named `dumpable'
make[2]: *** [driver.o] Error 1
make[2]: Leaving directory `/tmp/vmware-config1/vmmon-only/driver-2.4.7'
make[1]: *** [driver] Error 2
make[1]: Leaving directory `/tmp/vmware-config1/vmmon-only'
make: *** [auto-build] Error 2
make: Leaving directory `/tmp/vmware-config1/vmmon-only'
Unable to build the vmmon module.


Doubtless were looking at the result of an inappropriate dependency on
the part of vmware.  I'm not expecting any sort of help or fix.  This
is just an FYI for those that need to emulate windows.


