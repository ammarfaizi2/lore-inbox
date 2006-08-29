Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWH2OsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWH2OsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWH2OsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:48:10 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:49965 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965002AbWH2OsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:48:09 -0400
Message-ID: <44F45468.1080203@sw.ru>
Date: Tue, 29 Aug 2006 18:51:20 +0400
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
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: [PATCH 2/7] BC: kconfig
References: <44F45045.70402@sw.ru>
In-Reply-To: <44F45045.70402@sw.ru>
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
 
--- ./kernel/bc/Kconfig.bckm	2006-07-28 13:07:38.000000000 +0400
+++ ./kernel/bc/Kconfig	2006-07-28 13:09:51.000000000 +0400
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
+          When Y this option provides accounting and allows to configure
+          limits for user's consumption of exhaustible system resources.
+          The most important resource controlled by this patch is unswappable 
+          memory (either mlock'ed or used by internal kernel structures and 
+          buffers). The main goal of this patch is to protect processes
+          from running short of important resources because of an accidental
+          misbehavior of processes or malicious activity aiming to ``kill'' 
+          the system. It's worth to mention that resource limits configured 
+          by setrlimit(2) do not give an acceptable level of protection 
+          because they cover only small fraction of resources and work on a 
+          per-process basis.  Per-process accounting doesn't prevent malicious
+          users from spawning a lot of resource-consuming processes.
+
+endmenu
