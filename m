Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWC1Aaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWC1Aaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 19:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWC1Aaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 19:30:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:45212 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751181AbWC1Aa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 19:30:29 -0500
Date: Mon, 27 Mar 2006 18:29:33 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, <linuxppc-dev@ozlabs.org>
Subject: Please pull from 'misc' branch of powerpc
Message-ID: <Pine.LNX.4.44.0603271829080.31631-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'misc' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

 arch/powerpc/kernel/prom.c |   14 +-------------
 arch/ppc/lib/strcase.c     |    2 +-
 2 files changed, 2 insertions(+), 14 deletions(-)

Kumar Gala:
      ppc: fix strncasecmp prototype
      powerpc: use memparse() for mem= command line parsing

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5a24415..95d15eb 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1030,25 +1030,13 @@ static int __init early_init_dt_scan_cho
 
 	if (strstr(cmd_line, "mem=")) {
 		char *p, *q;
-		unsigned long maxmem = 0;
 
 		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
 			q = p + 4;
 			if (p > cmd_line && p[-1] != ' ')
 				continue;
-			maxmem = simple_strtoul(q, &q, 0);
-			if (*q == 'k' || *q == 'K') {
-				maxmem <<= 10;
-				++q;
-			} else if (*q == 'm' || *q == 'M') {
-				maxmem <<= 20;
-				++q;
-			} else if (*q == 'g' || *q == 'G') {
-				maxmem <<= 30;
-				++q;
-			}
+			memory_limit = memparse(q, &q);
 		}
-		memory_limit = maxmem;
 	}
 
 	/* break now */
diff --git a/arch/ppc/lib/strcase.c b/arch/ppc/lib/strcase.c
index 36b5210..d988578 100644
--- a/arch/ppc/lib/strcase.c
+++ b/arch/ppc/lib/strcase.c
@@ -11,7 +11,7 @@ int strcasecmp(const char *s1, const cha
 	return c1 - c2;
 }
 
-int strncasecmp(const char *s1, const char *s2, int n)
+int strncasecmp(const char *s1, const char *s2, size_t n)
 {
 	int c1, c2;
 

