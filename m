Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVAMVGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVAMVGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVAMVEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:04:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:33011 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261695AbVAMVCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:02:35 -0500
From: Christian Borntraeger <cborntra@de.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] reintroduce EXPORT_SYMBOL(task_nice) for binfmt_elf32
Date: Thu, 13 Jan 2005 22:02:24 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
References: <200501132042.31215.cborntra@de.ibm.com> <20050113194807.GA28010@infradead.org>
In-Reply-To: <20050113194807.GA28010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501132202.25048.cborntra@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Thu, Jan 13, 2005 at 08:42:30PM +0100, Christian Borntraeger wrote:
> > export was the fact, that binfmt_elf is no longer modular.
> > Unfortunately that is not true in the emulation case on s390 and
> > (untested) sparc64.
>
> I'd suggest putting it under CONFIG_COMPAT.

Agreed. Better?

Signed-Off: Christian Borntraeger <cborntra@de.ibm.com>

--- a/kernel/sched.c	2005-01-12 01:42:35 +01:00
+++ b/kernel/sched.c	2005-01-13 21:59:15 +01:00
@@ -3187,6 +3187,10 @@
 	return TASK_NICE(p);
 }
 
+#ifdef CONFIG_COMPAT
+EXPORT_SYMBOL(task_nice);
+#endif
+
 /**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
