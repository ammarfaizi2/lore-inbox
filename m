Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTFDNmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 09:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTFDNmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 09:42:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37584 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263295AbTFDNmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 09:42:20 -0400
Subject: Re: 2.5.70-mm4
From: Paul Larson <plars@linuxtestproject.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20030603231827.0e635332.akpm@digeo.com>
References: <20030603231827.0e635332.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Jun 2003 08:55:19 -0500
Message-Id: <1054734923.8311.149.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See bug 772 - http://bugme.osdl.org/show_bug.cgi?id=772
----------------------
CC      kernel/ksyms.o
kernel/ksyms.c:490: `__preempt_spin_lock' undeclared here (not in a
function)
kernel/ksyms.c:490: initializer element is not constant
kernel/ksyms.c:490: (near initialization for
`__ksymtab___preempt_spin_lock.value')
kernel/ksyms.c:491: `__preempt_write_lock' undeclared here (not in a
function)
kernel/ksyms.c:491: initializer element is not constant
kernel/ksyms.c:491: (near initialization for
`__ksymtab___preempt_write_lock.value')
make[1]: *** [kernel/ksyms.o] Error 1
make: *** [kernel] Error 2

It looks like this got broken in /include/linux/spinlock.h:
#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) &&
!defined(CONFIG_DEBUG_EVENTLOG)
void __preempt_spin_lock(spinlock_t *lock);
void __preempt_write_lock(rwlock_t *lock);
...


