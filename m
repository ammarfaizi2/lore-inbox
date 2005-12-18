Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbVLRRCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbVLRRCK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbVLRRCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:02:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:51645 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S965220AbVLRRCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:02:06 -0500
Message-ID: <43A5A7B5.21A4CAAE@tv-sign.ru>
Date: Sun, 18 Dec 2005 21:17:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH rc5-rt2 0/3] plist: alternative implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rediff against patch-2.6.15-rc5-rt2.

Nothing was changed except s/plist_next_entry/plist_first_entry/
to match the current naming.

These patches were only compile tested. This is beacuse I can't
even compile 2.6.15-rc5-rt2, I had to comment out this line

	lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o

in lib/Makefile. I think CONFIG_RWSEM_GENERIC_SPINLOCK means that
lib/rwsem.c should be ignored.

After that the kernel panics at boot time, the call trace shows

	set_workqueue_thread_prio
	wake_up_process
	set_workqueue_prio
	init_workqueues

will try to look further on Tuesday.

Just to make it clear, these problems were _without_ these patches.

Oleg.
