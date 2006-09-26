Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWIZFG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWIZFG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWIZFG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:06:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:54447 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1750956AbWIZFG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:06:27 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,217,1157353200"; 
   d="scan'208"; a="137401443:sNHT35821765"
Message-ID: <4518B465.9040408@intel.com>
Date: Tue, 26 Sep 2006 13:02:29 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Subject: [PATCH 2/3] disallow kprobes on notifier_call_chain
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When kprobe is re-entered, the re-entered kprobe kernel path will will call atomic_notifier_call_chain function, if this function is kprobed that will incur numerous kprobe recursive fault. This patch disallows kprobes on atomic_notifier_call_chain function.

Signed-off-by: bibo, mao <bibo.mao@intel.com>
Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

thanks
bibo,mao

diff -Nruap 2.6.18-mm1.org/kernel/sys.c 2.6.18-mm1/kernel/sys.c
--- 2.6.18-mm1.org/kernel/sys.c	2006-09-26 10:16:33.000000000 +0800
+++ 2.6.18-mm1/kernel/sys.c	2006-09-26 10:49:37.000000000 +0800
@@ -222,7 +222,7 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_
  *	of the last notifier function called.
  */
  
-int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+int __kprobes atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 		unsigned long val, void *v)
 {
 	int ret;
