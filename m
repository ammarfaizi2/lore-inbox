Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUFBVMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUFBVMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUFBVMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:12:30 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57298 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264138AbUFBVM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:12:28 -0400
Message-ID: <40BE42AF.5050005@austin.ibm.com>
Date: Wed, 02 Jun 2004 16:12:15 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] use c99 struct initializer in hotcpu_notifier
Content-Type: multipart/mixed;
 boundary="------------060003060209090303060606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060003060209090303060606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi-

The hotcpu_notifier macro does not properly record the given priority in 
the notifier block.  This causes trouble only for callers which specify 
a non-zero priority, of which there are none (yet).

Patch is against 2.6.7-rc2; please apply.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>

--------------060003060209090303060606
Content-Type: text/x-patch;
 name="hotcpu_notifier_c99_initializers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotcpu_notifier_c99_initializers.patch"

--- linux-2.6.5-7.21/include/linux/cpu.h	2004-05-05 12:40:27.000000000 -0500
+++ linux-2.6.5-7.21.new/include/linux/cpu.h	2004-05-06 17:45:55.000000000 -0500
@@ -60,7 +60,8 @@ extern struct semaphore cpucontrol;
 #define unlock_cpu_hotplug()	up(&cpucontrol)
 #define lock_cpu_hotplug_interruptible() down_interruptible(&cpucontrol)
 #define hotcpu_notifier(fn, pri) {				\
-	static struct notifier_block fn##_nb = { fn, pri };	\
+	static struct notifier_block fn##_nb =			\
+		{ .notifier_call = fn, .priority = pri };	\
 	register_cpu_notifier(&fn##_nb);			\
 }
 int cpu_down(unsigned int cpu);

--------------060003060209090303060606--
