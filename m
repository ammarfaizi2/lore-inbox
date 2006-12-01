Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758884AbWLAOLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884AbWLAOLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758954AbWLAOLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:11:39 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:62412 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1758884AbWLAOLi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:11:38 -0500
Date: Fri, 1 Dec 2006 14:11:30 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Subject: RFC: Unneeded memory barriers
Message-ID: <20061201141130.GA24203@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When disassembling a kernel I found around over 90 sync Instructions from
mb, rmb and wmb calls in the kernel and only few of those make any sense
to me.  So here's the first one - I think the wmb() in kernel/futex.c is
not needed on uniprocessors so should become an smb_wmb().

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/kernel/futex.c b/kernel/futex.c
index 93ef30b..d867899 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -553,7 +553,7 @@ static void wake_futex(struct futex_q *q
 	 * at the end of wake_up_all() does not prevent this store from
 	 * moving.
 	 */
-	wmb();
+	smp_wmb();
 	q->lock_ptr = NULL;
 }
 
