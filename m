Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWJEPqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWJEPqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWJEPqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:46:17 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:39801 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751396AbWJEPqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:46:15 -0400
Message-ID: <45252A26.3050609@sw.ru>
Date: Thu, 05 Oct 2006 19:52:06 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, xemul@openvz.org,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>, Srivatsa <vatsa@in.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, haveblue@us.ibm.com
Subject: [PATCH 2/10] BC: kconfig
References: <4525257A.4040609@openvz.org>
In-Reply-To: <4525257A.4040609@openvz.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel/bc/Kconfig file with BC options and
include it into arch Kconfigs

Signed-off-by: Pavel Emelianov <xemul@openvz.org>
Signed-off-by: Kirill Korotaev <dev@openvz.org>

---

 init/Kconfig      |    4 ++++
 kernel/bc/Kconfig |   16 ++++++++++++++++
 2 files changed, 20 insertions(+)

--- ./init/Kconfig.bc_kconfig	2006-10-05 11:42:43.000000000 +0400
+++ ./init/Kconfig	2006-10-05 11:43:56.000000000 +0400
@@ -564,6 +564,10 @@ config STOP_MACHINE
 	  Need stop_machine() primitive.
 endmenu
 
+menu "Beancounters"
+source "kernel/bc/Kconfig"
+endmenu
+
 menu "Block layer"
 source "block/Kconfig"
 endmenu
--- /dev/null	2006-07-18 14:52:43.075228448 +0400
+++ ./kernel/bc/Kconfig	2006-10-05 11:43:56.000000000 +0400
@@ -0,0 +1,16 @@
+config BEANCOUNTERS
+	bool "Enable resource accounting/control"
+	default n
+	help
+	  When Y this option provides accounting and allows configuring
+	  limits for user's consumption of exhaustible system resources.
+	  The most important resource controlled by this patch is unswappable
+	  memory (either mlock'ed or used by internal kernel structures and
+	  buffers). The main goal of this patch is to protect processes
+	  from running short of important resources because of accidental
+	  misbehavior of processes or malicious activity aiming to ``kill''
+	  the system. It's worth mentioning that resource limits configured
+	  by setrlimit(2) do not give an acceptable level of protection
+	  because they cover only a small fraction of resources and work on a
+	  per-process basis.  Per-process accounting doesn't prevent malicious
+	  users from spawning a lot of resource-consuming processes.
