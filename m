Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUDLMYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 08:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUDLMYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 08:24:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:45037 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262866AbUDLMYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 08:24:54 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Rik Faith <faith@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change audit_log_format() -> printk() (was: 2.6.5-mm4)
References: <20040410200551.31866667.akpm@osdl.org>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Mon, 12 Apr 2004 14:24:48 +0200
Message-ID: <87isg5wfhr.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/
>
> lightweight-auditing-framework.patch
>   Light-weight Auditing Framework
>   Light-weight Auditing Framework update
>   lightweight-auditing-framework warning fixes
>   Light-weight Auditing Framework receive filter fixes
>   lightweight-auditing-framework-receive-filter-fixes compile fix

I've seen several printk()'s substituted with audit_log_format().
Maybe this small patch helps those not using the audit framework.

I have not tested this patch.

Regards, Olaf.

diff -urN a/include/linux/audit.h b/include/linux/audit.h
--- a/include/linux/audit.h	Mon Apr 12 11:58:33 2004
+++ b/include/linux/audit.h	Mon Apr 12 12:01:43 2004
@@ -197,8 +197,8 @@
 #define audit_log(t,f,...) do { ; } while (0)
 #define audit_log_start(t) ({ NULL; })
 #define audit_log_vformat(b,f,a) do { ; } while (0)
-#define audit_log_format(b,f,...) do { ; } while (0)
-#define audit_log_end(b) do { ; } while (0)
+#define audit_log_format(b,f,args...) printk(f, args)
+#define audit_log_end(b) printk("\n")
 #define audit_log_end_fast(b) do { ; } while (0)
 #define audit_log_end_irq(b) do { ; } while (0)
 #define audit_log_d_path(b,p,d,v) do { ; } while (0)
