Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268000AbTAIVul>; Thu, 9 Jan 2003 16:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268016AbTAIVul>; Thu, 9 Jan 2003 16:50:41 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:3968 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S268000AbTAIVtn>;
	Thu, 9 Jan 2003 16:49:43 -0500
Date: Thu, 9 Jan 2003 22:58:21 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms prints wrong symbol names
Message-ID: <20030109215821.GA2935@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Since stem compression arrived to kallsyms table, we are printing
name of symbol BEFORE one we want to print (and empty string for
first symbol) because of we return buffer with copy of last name
we skipped instead of 'name' variable as we did before. So one more
pass through loop is required.

Without this patch my stack traces were really strange...

				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz



--- linux-2.5.55/kernel/kallsyms.c	2003-01-09 22:47:40.000000000 +0100
+++ linux-2.5.55/kernel/kallsyms.c	2003-01-09 22:38:01.000000000 +0100
@@ -46,7 +46,7 @@
 		}
 
 		/* Grab name */
-		for (i = 0; i < best; i++) { 
+		for (i = 0; i < best + 1; i++) { 
 			unsigned prefix = *name++;
 			strncpy(namebuf + prefix, name, 127 - prefix);
 			name += strlen(name) + 1;
