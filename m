Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276857AbRJRMZZ>; Thu, 18 Oct 2001 08:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277231AbRJRMZQ>; Thu, 18 Oct 2001 08:25:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41857 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S276857AbRJRMZH>;
	Thu, 18 Oct 2001 08:25:07 -0400
Date: Thu, 18 Oct 2001 05:25:10 -0700 (PDT)
Message-Id: <20011018.052510.105430257.davem@redhat.com>
To: cary_dickens2@hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, erik_habbinga@hp.com
Subject: Re: Problem with 2.4.14prex and qlogicfc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D574@xfc01.fc.hp.com>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D574@xfc01.fc.hp.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please try this patch:

--- linux/drivers/scsi/qlogicfc.h.~1~	Tue Nov 28 08:33:08 2000
+++ linux/drivers/scsi/qlogicfc.h	Thu Oct 18 05:22:52 2001
@@ -62,13 +62,8 @@
  * determined for each queue request anew.
  */
 
-#if BITS_PER_LONG > 32
 #define DATASEGS_PER_COMMAND 2
 #define DATASEGS_PER_CONT 5
-#else
-#define DATASEGS_PER_COMMAND 3
-#define DATASEGS_PER_CONT 7
-#endif
 
 #define QLOGICFC_REQ_QUEUE_LEN	127	/* must be power of two - 1 */
 #define QLOGICFC_MAX_SG(ql)	(DATASEGS_PER_COMMAND + (((ql) > 0) ? DATASEGS_PER_CONT*((ql) - 1) : 0))
