Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUGFHnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUGFHnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 03:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUGFHnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 03:43:22 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:30656 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263596AbUGFHnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 03:43:20 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulus@samba.org, benh@kernel.crashing.org, rusty@rustcorp.com.au
Subject: Re: 2.6.7-mm6 - ppc32 inconsistent kallsyms data 
In-reply-to: Your message of "Tue, 06 Jul 2004 17:31:22 +1000."
             <13859.1089099082@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Jul 2004 17:43:01 +1000
Message-ID: <14454.1089099781@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate it when I spot a typo after pressing enter ...

--- kallsyms-ppc32 ---

PPC small data area base symbols shift between kallsyms phases 1 and 2,
which makes the kallsyms data unstable.  Exclude them from the kallsyms
list.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: 2.6.7-mm6/scripts/kallsyms.c
===================================================================
--- 2.6.7-mm6.orig/scripts/kallsyms.c	2004-07-06 17:26:14.000000000 +1000
+++ 2.6.7-mm6/scripts/kallsyms.c	2004-07-06 17:41:29.000000000 +1000
@@ -83,6 +83,11 @@ symbol_valid(struct sym_entry *s)
 	    strcmp(s->sym, "kallsyms_names") == 0)
 		return 0;
 
+	/* Exclude linker generated symbols which vary between passes */
+	if (strcmp(s->sym, "_SDA_BASE_") == 0 ||	/* ppc */
+	    strcmp(s->sym, "_SDA2_BASE_") == 0)		/* ppc */
+		return 0;
+
 	return 1;
 }
 

