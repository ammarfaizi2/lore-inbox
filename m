Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272392AbTGaF1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 01:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272397AbTGaF1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 01:27:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:64463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272392AbTGaF1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 01:27:15 -0400
Date: Wed, 30 Jul 2003 22:28:10 -0700
From: Dave Olien <dmo@osdl.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse function pointer arguments now accept void pointers
Message-ID: <20030731052810.GA2853@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch eliminates warnings of the form:

	incorrect type in argument 1 (different base types)

from code of the form:

#define VPTR	((void *)1)

void f( int (g)(void))
{
}

int
main(void)
{
	f(VPTR);
	f(0);
}

--- sparse_original/evaluate.c	2003-07-29 14:13:09.000000000 -0700
+++ sparse_patch/evaluate.c	2003-07-30 18:14:25.000000000 -0700
@@ -647,7 +653,7 @@
 		t = t->ctype.base_type;
 		target_as |= t->ctype.as;
 	}
-	if (t->type == SYM_PTR) {
+	if (t->type == SYM_PTR || t->type == SYM_FN) {
 		struct expression *right = *rp;
 		struct symbol *s = source;
 		int source_as;
