Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVHUEi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVHUEi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 00:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVHUEi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 00:38:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36071 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750787AbVHUEi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 00:38:57 -0400
Date: Sun, 21 Aug 2005 00:38:39 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: s390 build fix.
Message-ID: <20050821043839.GA28550@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{standard input}: Assembler messages:
{standard input}:397: Error: symbol `.Litfits' is already defined
{standard input}:585: Error: symbol `.Litfits' is already defined

Newer gcc's inline this it seems, which blows up.

--- linux-2.6.12/arch/s390/kernel/cpcmd.c~	2005-08-18 15:12:51.000000000 -0400
+++ linux-2.6.12/arch/s390/kernel/cpcmd.c	2005-08-18 15:13:35.000000000 -0400
@@ -46,9 +46,9 @@ int  __cpcmd(const char *cmd, char *resp
 				"lra	3,0(%4)\n"
 				"lr	5,%5\n"
 				"diag	2,4,0x8\n"
-				"brc	8, .Litfits\n"
+				"brc	8, .Litfits%=\n"
 				"ar	5, %5\n"
-				".Litfits: \n"
+				".Litfits%=: \n"
 				"lr	%0,4\n"
 				"lr	%1,5\n"
 				: "=d" (return_code), "=d" (return_len)
@@ -64,9 +64,9 @@ int  __cpcmd(const char *cmd, char *resp
 				"sam31\n"
 				"diag	2,4,0x8\n"
 				"sam64\n"
-				"brc	8, .Litfits\n"
+				"brc	8, .Litfits%=\n"
 				"agr	5, %5\n"
-				".Litfits: \n"
+				".Litfits%=: \n"
 				"lgr	%0,4\n"
 				"lgr	%1,5\n"
 				: "=d" (return_code), "=d" (return_len)

