Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWIEPQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWIEPQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWIEPQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:16:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:18823 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965106AbWIEPQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:16:21 -0400
Message-ID: <44FD95A4.9050808@sw.ru>
Date: Tue, 05 Sep 2006 19:20:04 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alexey Dobriyan <adobriyan@mail.ru>, Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Hugh Dickins <hugh@veritas.com>
Subject: [PATCH 2/13] BC: kconfig
References: <44FD918A.7050501@sw.ru>
In-Reply-To: <44FD918A.7050501@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel/bc/Kconfig file with BC options and
include it into arch Kconfigs

Signed-off-by: Pavel Emelianov <xemul@sw.ru>
Signed-off-by: Kirill Korotaev <dev@sw.ru>

---

 init/Kconfig      |    2 ++
 kernel/bc/Kconfig |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

--- ./init/Kconfig.bckm	2006-07-10 12:39:10.000000000 +0400
+++ ./init/Kconfig	2006-07-28 14:10:41.000000000 +0400
@@ -222,6 +222,8 @@ source "crypto/Kconfig"
 
 	  Say N if unsure.
 
+source "kernel/bc/Kconfig"
+
 config SYSCTL
 	bool
 
--- ./kernel/bc/Kconfig.bckconf	2006-09-05 12:21:09.000000000 +0400
+++ ./kernel/bc/Kconfig	2006-09-05 12:19:54.000000000 +0400
@@ -0,0 +1,25 @@
+#
+# Resource beancounters (BC)
+#
+# Copyright (C) 2006 OpenVZ. SWsoft Inc
+
+menu "User resources"
+
+config BEANCOUNTERS
+	bool "Enable resource accounting/control"
+	default n
+	help
+          When Y this option provides accounting and allows configuring
+          limits for user's consumption of exhaustible system resources.
+          The most important resource controlled by this patch is unswappable
+          memory (either mlock'ed or used by internal kernel structures and
+          buffers). The main goal of this patch is to protect processes
+          from running short of important resources because of accidental
+          misbehavior of processes or malicious activity aiming to ``kill''
+          the system. It's worth mentioning that resource limits configured
+          by setrlimit(2) do not give an acceptable level of protection
+          because they cover only a small fraction of resources and work on a
+          per-process basis.  Per-process accounting doesn't prevent malicious
+          users from spawning a lot of resource-consuming processes.
+
+endmenu
