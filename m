Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSK1Owc>; Thu, 28 Nov 2002 09:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbSK1Owc>; Thu, 28 Nov 2002 09:52:32 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:8613 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265589AbSK1Owa>;
	Thu, 28 Nov 2002 09:52:30 -0500
Date: Thu, 28 Nov 2002 17:13:51 -0500
From: Christoph Hellwig <hch@sgi.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix io_apic_bug_finalize() prototype
Message-ID: <20021128171351.B6592@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*_initcall() expects int callbacks


--- 1.33/arch/i386/kernel/io_apic.c	Wed Nov 20 16:20:10 2002
+++ edited/arch/i386/kernel/io_apic.c	Thu Nov 28 14:22:44 2002
@@ -1749,10 +1749,12 @@
  *	APIC bugs then we can allow the modify fast path
  */
  
-static void __init io_apic_bug_finalize(void)
+static int __init io_apic_bug_finalize(void)
 {
-	if(sis_apic_bug == -1)
+	if (sis_apic_bug == -1)
 		sis_apic_bug = 0;
+
+	return 0;
 }
 
 late_initcall(io_apic_bug_finalize);
