Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbQL3Ej7>; Fri, 29 Dec 2000 23:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131055AbQL3Ejt>; Fri, 29 Dec 2000 23:39:49 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:55237 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131023AbQL3Ejo>; Fri, 29 Dec 2000 23:39:44 -0500
Date: Fri, 29 Dec 2000 20:09:16 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: PATCH: test13-pre5/drivers/sound/via82cxxx_audio.c did not compile
Message-ID: <20001229200916.A2645@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.0-test13-pre5 eliminated vm_operations_struct->swapout,
but this change was not reflected in drivers/sound/via82cxxx_audio.c,
causing that file to fail to compile.  I have attached what I believe
is the correct fix below.

	via82cxxx_audio.c has Jeff Garzik's name on it, but I understand
that he is taking a break for a few weeks to recover from typing strain.
(Hope you recover soon, Jeff.)  Consequently, I am not sure whom I should
ask to "bless" this change.  So, I'll just send this to linux-kernel
and Linus and will leave it to linux-kernel readers to sound the alarm
if I botched the patch.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sound.diffs"

--- linux-2.4.0-test13-pre5/drivers/sound/via82cxxx_audio.c	Mon Oct 30 12:24:22 2000
+++ linux/drivers/sound/via82cxxx_audio.c	Fri Dec 29 16:53:22 2000
@@ -1727,20 +1727,8 @@
 }
 
 
-#ifndef VM_RESERVE
-static int via_mm_swapout (struct page *page, struct file *filp)
-{
-	return 0;
-}
-#endif /* VM_RESERVE */
-
-
 struct vm_operations_struct via_mm_ops = {
 	nopage:		via_mm_nopage,
-
-#ifndef VM_RESERVE
-	swapout:	via_mm_swapout,
-#endif
 };
 
 

--IS0zKkzwUGydFO0o--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
