Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264763AbTE1UiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbTE1UiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:38:02 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36815 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264763AbTE1UiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:38:02 -0400
Date: Wed, 28 May 2003 16:51:16 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux390@de.ibm.com, James Antill <jantill@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Patch for strncmp use in s390 (sclp)
Message-ID: <20030528165116.B21984@devserv.devel.redhat.com>
References: <20030528162019.A3492@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030528162019.A3492@devserv.devel.redhat.com>; from zaitcev@redhat.com on Wed, May 28, 2003 at 04:20:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is different from the one in setup.c, being an actual bug.

-- Pete

--- linux-2.4.20-1.1931.2.199.z0/drivers/s390/char/sclp_tty.c	2003-05-19 17:16:59.000000000 -0400
+++ linux-2.4.20-1.1931.2.199.z1/drivers/s390/char/sclp_tty.c	2003-05-28 12:40:01.000000000 -0400
@@ -500,7 +500,7 @@
 		memcpy(sclp_tty->flip.char_buf_ptr, buf, count);
 		if (count < 2 ||
 		    (strncmp ((const char *) buf + count - 2, "^n", 2) &&
-		     strncmp ((const char *) buf + count - 2, "\0252n", 2))) {
+		     strncmp ((const char *) buf + count - 2, "\252n", 2))) {
 			sclp_tty->flip.char_buf_ptr[count] = '\n';
 			count++;
 		} else
