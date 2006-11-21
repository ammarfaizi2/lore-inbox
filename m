Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030917AbWKUMpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030917AbWKUMpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030918AbWKUMpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:45:09 -0500
Received: from mout1.freenet.de ([194.97.50.132]:60870 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1030917AbWKUMpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:45:08 -0500
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: Marcus Hartig <m.f.h@web.de>
Subject: Re: 2.6.19-rc6-rt5
Date: Tue, 21 Nov 2006 13:45:10 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <4562EAA9.8020102@web.de>
In-Reply-To: <4562EAA9.8020102@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211345.10983.fzu@wemgehoertderstaat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 21. November 2006 13:01 schrieb Marcus Hartig:
> HI!
> 
> rt4 runs fine. But while compiling 2.6.19-rc6-rt5 I get this error:
> 
> CC      mm/page_alloc.o
> mm/page_alloc.c: In function 'page_alloc_init':
> mm/page_alloc.c:2793: error: 'page_alloc_cpu_notify' undeclared (first use 
> in this function)
> mm/page_alloc.c:2793: error: (Each undeclared identifier is reported only once
> mm/page_alloc.c:2793: error: for each function it appears in.)
> make[1]: *** [mm/page_alloc.o] Error 1
> make: *** [mm] Error 2

Ingo posted a fix in another thread.
The (whitespace damaged, handapply!) excerpt of that fix below made
i386 compile here.

      Karsten

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -2768,7 +2768,6 @@ void __init free_area_init(unsigned long
                        __pa(PAGE_OFFSET) >> PAGE_SHIFT, NULL);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static int page_alloc_cpu_notify(struct notifier_block *self,
                                 unsigned long action, void *hcpu)
 {
@@ -2786,7 +2785,6 @@ static int page_alloc_cpu_notify(struct 
        }
        return NOTIFY_OK;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 void __init page_alloc_init(void)
 {
-
