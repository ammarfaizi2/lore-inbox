Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTFNX5b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 19:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbTFNX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 19:57:31 -0400
Received: from [65.39.167.210] ([65.39.167.210]:11393 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S261414AbTFNX5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 19:57:30 -0400
Date: Sat, 14 Jun 2003 20:09:03 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] linux-2.5.71: undefined reference to `register_cpu_notifier'
Message-ID: <Pine.LNX.4.44.0306142007460.4099-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this on a fresh tree:

net/built-in.o(.init.text+0x209): In function `flow_cache_init':
: undefined reference to `register_cpu_notifier'
make: *** [.tmp_vmlinux1] Error 1

I think this is the right fix for it?  Please correct me if I'm wrong.

--- net/core/flow.c~    2003-06-14 15:17:56.000000000 -0400
+++ net/core/flow.c     2003-06-14 20:07:22.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/percpu.h>
 #include <linux/bitops.h>
 #include <linux/notifier.h>
+#include <linux/cpu.h>
 #include <net/flow.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>


