Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVASRT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVASRT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVASRRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:17:30 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:25772 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261787AbVASRQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:16:15 -0500
Subject: 2.6.10-mm1 hang
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-SL0Gb2LMDCDmaINzNCW7"
Organization: 
Message-Id: <1106153215.3577.134.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jan 2005 08:46:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SL0Gb2LMDCDmaINzNCW7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I was playing with kexec+kdump and ran into this on 2.6.10-mm1.
I have seen similar behaviour on 2.6.10. 

I am using a 4-way P-III machine. I have a module which tries
gets same spinlock twice. When I try to "insmod" this module,
my system hangs. All my windows froze, no more new logins,
console froze, doesn't respond to sysrq. I wasn't expecting
a system hang. Why ? Ideas ?

Here is the code.

Thanks,
Badari



--=-SL0Gb2LMDCDmaINzNCW7
Content-Disposition: attachment; filename=test.c
Content-Type: text/x-c; name=test.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <linux/init.h>
#include <asm/uaccess.h>
#include <linux/spinlock.h>
spinlock_t mylock = SPIN_LOCK_UNLOCKED;
static int __init panic_init(void)
{
        spin_lock_irq(&mylock);
        spin_lock_irq(&mylock);
       return 1;
}
 
 
module_init(panic_init);



--=-SL0Gb2LMDCDmaINzNCW7--

