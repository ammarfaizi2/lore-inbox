Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264896AbUE0Rb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbUE0Rb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbUE0RbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:31:23 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:48785 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264896AbUE0RbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:31:09 -0400
Subject: [2.6.7-rc1-mm1] lp int copy_to_user replaced
From: FabF <fabian.frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-fcTncJAOiDiQ0e/btH3/"
Message-Id: <1085679127.2070.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 27 May 2004 19:32:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fcTncJAOiDiQ0e/btH3/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a patch to have standard __put_user for integer transfers in lp
driver.Is it correct ?

Regards,
FabF

--=-fcTncJAOiDiQ0e/btH3/
Content-Disposition: attachment; filename=lp1.diff
Content-Type: text/x-patch; name=lp1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/drivers/char/lp.c edited/drivers/char/lp.c
--- orig/drivers/char/lp.c	2004-05-10 04:31:58.000000000 +0200
+++ edited/drivers/char/lp.c	2004-05-27 19:28:12.581860488 +0200
@@ -31,6 +31,8 @@
  * Obsoleted and removed all the lowlevel stuff implemented in the last
  * month to use the IEEE1284 functions (that handle the _new_ compatibilty
  * mode fine).
+ *
+ * 27-MAY-2004  Replace int copy_to_user with put_user (Fabian Frederick)
  */
 
 /* This driver should, in theory, work with any parallel port that has an
@@ -603,16 +605,14 @@
 			return -EINVAL;
 			break;
 		case LPGETIRQ:
-			if (copy_to_user((int *) arg, &LP_IRQ(minor),
-					sizeof(int)))
+			if (__put_user(LP_IRQ(minor), (int *) arg))
 				return -EFAULT;
 			break;
 		case LPGETSTATUS:
 			lp_claim_parport_or_block (&lp_table[minor]);
 			status = r_str(minor);
 			lp_release_parport (&lp_table[minor]);
-
-			if (copy_to_user((int *) arg, &status, sizeof(int)))
+			if (__put_user(status, (int *) arg))
 				return -EFAULT;
 			break;
 		case LPRESET:
@@ -630,7 +630,7 @@
 #endif
  		case LPGETFLAGS:
  			status = LP_F(minor);
-			if (copy_to_user((int *) arg, &status, sizeof(int)))
+			if (__put_user(status, (int *) arg))
 				return -EFAULT;
 			break;
 

--=-fcTncJAOiDiQ0e/btH3/--

