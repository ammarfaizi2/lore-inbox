Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWCUN0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWCUN0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWCUN0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:26:04 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:9515 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751680AbWCUN0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:26:02 -0500
Subject: [patch] [trivial]  remove needless check in binfmt_elf.c
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM Deutschland Entwicklung
Date: Tue, 21 Mar 2006 14:26:23 +0100
Message-Id: <1142947584.6243.8.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local variable i is unsigned int and thus cannot be negative.

signed-off-by: Carsten Otte <cotte@de.ibm.com>
--
diff -ruN linux-2.6.16/fs/binfmt_elf.c linux-2.6.16-fix/fs/binfmt_elf.c
--- linux-2.6.16/fs/binfmt_elf.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-fix/fs/binfmt_elf.c	2006-03-21 14:02:33.000000000 +0100
@@ -1334,7 +1334,7 @@
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
 	psinfo->pr_state = i;
-	psinfo->pr_sname = (i < 0 || i > 5) ? '.' : "RSDTZW"[i];
+	psinfo->pr_sname = (i > 5) ? '.' : "RSDTZW"[i];
 	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
 	psinfo->pr_nice = task_nice(p);
 	psinfo->pr_flag = p->flags;

