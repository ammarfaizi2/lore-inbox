Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVAMWaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVAMWaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVAMWaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:30:07 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:5071 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261800AbVAMW3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:29:21 -0500
From: Christian Borntraeger <cborntra@de.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] reintroduce EXPORT_SYMBOL(task_nice) for binfmt_elf32
Date: Thu, 13 Jan 2005 23:29:12 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
References: <200501132042.31215.cborntra@de.ibm.com> <200501132202.25048.cborntra@de.ibm.com> <20050113210501.GA29232@infradead.org>
In-Reply-To: <20050113210501.GA29232@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132329.13881.cborntra@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Although a little comment explaining what it's exported for might be
> nice ;-)  So people can't complain if it's unexported if binfmt_elf
> doesn't need it anymore one day.

OK. I dont mind if you apply this patch or the former one without the 
comment. Whatever you prefer. 

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>

--- a/kernel/sched.c	2005-01-12 01:42:35 +01:00
+++ b/kernel/sched.c	2005-01-13 23:21:01 +01:00
@@ -3187,6 +3187,15 @@
 	return TASK_NICE(p);
 }
 
+/*
+ * The only users of task_nice are binfmt_elf and binfmt_elf32.
+ * binfmt_elf is no longer modular, but binfmt_elf32 still is.
+ * Therefore, task_nice is needed if there is a compat_mode. 
+ */
+#ifdef CONFIG_COMPAT
+EXPORT_SYMBOL(task_nice);
+#endif
+
 /**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
