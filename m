Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314327AbSESLLu>; Sun, 19 May 2002 07:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314330AbSESLLt>; Sun, 19 May 2002 07:11:49 -0400
Received: from mailf.telia.com ([194.22.194.25]:59858 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S314327AbSESLLs>;
	Sun, 19 May 2002 07:11:48 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <hch@infradead.org>
Subject: I/O-APIC not enabled in 2.4.19-pre8 on UP machines
From: Peter Osterlund <petero2@telia.com>
Date: 19 May 2002 13:11:39 +0200
Message-ID: <m2elg88k9g.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like I/O-APIC setup was accidentally disabled in 2.4.19-pre7
for UP machines.

Here is a patch to fix it:

--- linux/arch/i386/kernel/io_apic.c.orig	Sun May 19 12:58:40 2002
+++ linux/arch/i386/kernel/io_apic.c	Sun May 19 12:58:24 2002
@@ -191,11 +191,7 @@
 #define MAX_PIRQS 8
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
-#ifdef CONFIG_X86_UP_APIC
-int skip_ioapic_setup=1;
-#else
-int skip_ioapic_setup=0;
-#endif
+int skip_ioapic_setup;
 
 static int __init noioapic_setup(char *str)
 {

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
