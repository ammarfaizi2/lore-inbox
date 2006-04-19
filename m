Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWDSNoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWDSNoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 09:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDSNoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 09:44:13 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:52631 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750769AbWDSNoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 09:44:13 -0400
Date: Wed, 19 Apr 2006 09:44:08 -0400
From: Fernando Barsoba <fbarsoba@hotmail.com>
Subject: problems compiling kernel module
To: linux-kernel@vger.kernel.org
Message-id: <44463EA8.9090301@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 8BIT
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am really stuck with this thing.. For couple of days i have been 
trying to compile a kernel module. I have been following the info in 
http://www.faqs.org/docs/kernel/x204.html. But no success... i 
recompiled the latest kernel version, and i think i trying to compile 
the module against the source code for that kernel.. however, strange 
errors appear.

Please any help will be appreciated.

Here's the error:

Code:

[fbarsoba@localhost ~]$ cd workspace/kernel_tests/
[fbarsoba@localhost kernel_tests]$ make
gcc -O2 -DMODULE -D__KERNEL__ -W -Wall -Wstrict-prototypes 
-Wmissing-prototypes -isystem /lib/modules/`uname -r`/build/include -c 
-o hello-1.o hello-1.c
In file included from 
/lib/modules/2.6.16.7/build/include/linux/spinlock.h:87, from 
/lib/modules/2.6.16.7/build/include/linux/capability.h:45, from 
/lib/modules/2.6.16.7/build/include/linux/sched.h:7, from 
/lib/modules/2.6.16.7/build/include/linux/module.h:10, from hello-1.c:3:
/lib/modules/2.6.16.7/build/include/asm/spinlock.h: In function 
‘__raw_spin_lock’: 
/lib/modules/2.6.16.7/build/include/asm/spinlock.h:42: error: expected 
‘:’ or ‘)’ before ‘KBUILD_BASENAME’ 
/lib/modules/2.6.16.7/build/include/asm/spinlock.h: In function 
‘__raw_read_lock’: 
/lib/modules/2.6.16.7/build/include/asm/spinlock.h:96: error: expected 
‘:’ or ‘)’ before ‘KBUILD_BASENAME’ 
/lib/modules/2.6.16.7/build/include/asm/spinlock.h:96: error: expected 
expression before ‘else’ 
/lib/modules/2.6.16.7/build/include/asm/spinlock.h: In function 
‘__raw_write_lock’: 
/lib/modules/2.6.16.7/build/include/asm/spinlock.h:101: error: expected 
‘:’ or ‘)’ before ‘KBUILD_BASENAME’ 
/lib/modules/2.6.16.7/build/include/asm/spinlock.h:101: error: expected 
expression before ‘else’ In file included from 
/lib/modules/2.6.16.7/build/include/linux/sched.h:20, from 
/lib/modules/2.6.16.7/build/include/linux/module.h:10, from hello-1.c:3: 
/lib/modules/2.6.16.7/build/include/asm/semaphore.h: In function ‘down’: 
/lib/modules/2.6.16.7/build/include/asm/semaphore.h:112: error: expected 
‘:’ or ‘)’ before ‘KBUILD_BASENAME’ 
/lib/modules/2.6.16.7/build/include/asm/semaphore.h: In function 
‘down_interruptible’: 
/lib/modules/2.6.16.7/build/include/asm/semaphore.h:137: error: expected 
‘:’ or ‘)’ before ‘KBUILD_BASENAME’ 
/lib/modules/2.6.16.7/build/include/asm/semaphore.h: In function 
‘down_trylock’:/lib/modules/2.6.16.7/build/include/asm/semaphore.h:161: 
error: expected ‘:’ or ‘)’ before ‘KBUILD_BASENAME’ 
/lib/modules/2.6.16.7/build/include/asm/semaphore.h: In function ‘up’: 
/lib/modules/2.6.16.7/build/include/asm/semaphore.h:184: error: expected 
‘:’ or ‘)’ before ‘KBUILD_BASENAME’ make: *** [hello-1.o] Error 1


And here are the files:

Code:

/* hello-1.c - The simplest kernel module.
*/ #include <linux/module.h> /* Needed by all modules
*/ #include <linux/kernel.h> /* Needed for KERN_ALERT */

int init_module(void) {
printk("<1>Hello world 1.\n"); // A non 0 return means init_module 
failed; module can't be loaded.
return 0;
}

void cleanup_module(void) {
printk(KERN_ALERT "Goodbye world 1.\n");
}


Code:

TARGET := hello-1
WARN := -W -Wall -Wstrict-prototypes -Wmissing-prototypes
INCLUDE := -isystem /lib/modules/`uname -r`/build/include
CFLAGS := -O2 -DMODULE -D__KERNEL__ ${WARN} ${INCLUDE} CC := gcc
${TARGET}.o: ${TARGET}.c
.PHONY: clean
clean: rm -rf {TARGET}.o


