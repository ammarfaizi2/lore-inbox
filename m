Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWEXWZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWEXWZj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWEXWZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:25:39 -0400
Received: from smtp-out.google.com ([216.239.45.12]:56524 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964779AbWEXWZj
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:25:39 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=F7Rot0Iu5rmaK4TXtLOPlLVUFeTQv3RvhzazPFEDxabvsRaa93lqMT0u5kytbLnM6
	7deDidqaPHiLIl4r8zQPw==
Subject: [PATCH]:x86_64: Change assembly to use regular cpuid_count macro
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 24 May 2006 15:25:22 -0700
Message-Id: <1148509522.14025.7.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor cleanup patch:  

Replacing the asm statement with cpuid_count macro(which already
provides the same functionality).


Signed-off-by: Rohit Seth <rohitseth@google.com>

arch/x86_64/kernel/setup.c |    7 ++-----
1 files changed, 2 insertions(+), 5 deletions(-)


--- linux-2.6.17-rc4.org/arch/x86_64/kernel/setup.c	2006-05-24 13:47:11.000000000 -0700
+++ linux-2.6.17-rc4/arch/x86_64/kernel/setup.c	2006-05-24 14:37:25.000000000 -0700
@@ -1024,15 +1024,12 @@
  */
 static int __cpuinit intel_num_cpu_cores(struct cpuinfo_x86 *c)
 {
-	unsigned int eax;
+	unsigned int eax, t;
 
 	if (c->cpuid_level < 4)
 		return 1;
 
-	__asm__("cpuid"
-		: "=a" (eax)
-		: "0" (4), "c" (0)
-		: "bx", "dx");
+	cpuid_count(4, 0, &eax, &t, &t, &t);
 
 	if (eax & 0x1f)
 		return ((eax >> 26) + 1);


