Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUF2V0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUF2V0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUF2V0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:26:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:20915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266073AbUF2V0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:26:45 -0400
Date: Tue, 29 Jun 2004 14:29:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm4 compile buglet
Message-Id: <20040629142929.14e1b746.akpm@osdl.org>
In-Reply-To: <40E1DCD0.7090604@travellingkiwi.com>
References: <40E1DCD0.7090604@travellingkiwi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hamie <hamish@travellingkiwi.com> wrote:
>
> drivers/built-in.o(.init.text+0x90ed): In function `do_wrlvtpc':
> : undefined reference to `apic_write'

You'll need to disable CONFIG_PERFCTR or apply the below patch.




--- linux-2.6.7-mm4/drivers/perfctr/x86_tests.c.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/x86_tests.c	2004-06-29 13:26:26.000000000 +0200
@@ -44,6 +44,11 @@
 #define CR4MOV	"movl"
 #endif
 
+#ifndef PERFCTR_INTERRUPT_SUPPORT
+#undef apic_write
+#define apic_write(reg,vector)			do{}while(0)
+#endif
+
 static void __init do_rdpmc(unsigned pmc, unsigned unused2)
 {
 	unsigned i;
