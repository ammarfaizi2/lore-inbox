Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263835AbTCUTGf>; Fri, 21 Mar 2003 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263854AbTCUTFW>; Fri, 21 Mar 2003 14:05:22 -0500
Received: from port-212-202-184-28.reverse.qdsl-home.de ([212.202.184.28]:31401
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S263835AbTCUTBp>; Fri, 21 Mar 2003 14:01:45 -0500
Message-ID: <3E7B62BB.9000800@trash.net>
Date: Fri, 21 Mar 2003 20:06:35 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030318 Debian/1.3-2
X-Accept-Language: en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ISDN: don't unlock lp if there is nothing to unlock
Content-Type: multipart/mixed;
 boundary="------------010401020001050401070607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010401020001050401070607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a bug introduced with 2.4.20, it is tried to unlock
lp after failed call to isdn_net_get_locked_lp.

Regards,
Patrick


--------------010401020001050401070607
Content-Type: text/plain;
 name="isdn-ppp-dont-unlock.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn-ppp-dont-unlock.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1104  -> 1.1105 
#	drivers/isdn/isdn_ppp.c	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/21	kaber@trash.net	1.1105
# [ISDN]: don't try to unlock when there is nothing to unlock
# --------------------------------------------
#
diff -Nru a/drivers/isdn/isdn_ppp.c b/drivers/isdn/isdn_ppp.c
--- a/drivers/isdn/isdn_ppp.c	Fri Mar 21 19:53:58 2003
+++ b/drivers/isdn/isdn_ppp.c	Fri Mar 21 19:53:58 2003
@@ -1251,7 +1251,7 @@
 	if (!lp) {
 		printk(KERN_WARNING "%s: all channels busy - requeuing!\n", netdev->name);
 		retval = 1;
-		goto unlock;
+		goto out;
 	}
 	/* we have our lp locked from now on */
 

--------------010401020001050401070607--

