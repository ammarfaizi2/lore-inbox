Return-Path: <linux-kernel-owner+w=401wt.eu-S936369AbWLIIlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936369AbWLIIlA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936393AbWLIIk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:40:58 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:51657 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936337AbWLIIkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:40:39 -0500
Date: Sat, 9 Dec 2006 00:34:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: phil.el@wanadoo.fr, akpm <akpm@osdl.org>, ak@suse.de
Subject: [PATCH] x86 smp: export smp_num_siblings for oprofile
Message-Id: <20061209003424.cecc58a4.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

oprofile uses smp_num_siblings without testing for CONFIG_X86_HT.
I looked at modifying oprofile, but this way is cleaner & simpler
and I didn't see a good reason not to just export it when CONFIG_SMP.

WARNING: "smp_num_siblings" [arch/i386/oprofile/oprofile.ko] undefined!

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/kernel/smpboot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-git13.orig/arch/i386/kernel/smpboot.c
+++ linux-2.6.19-git13/arch/i386/kernel/smpboot.c
@@ -69,7 +69,7 @@ static int __devinitdata smp_b_stepping;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
-#ifdef CONFIG_X86_HT
+#ifdef CONFIG_SMP
 EXPORT_SYMBOL(smp_num_siblings);
 #endif
 


---
