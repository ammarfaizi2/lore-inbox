Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUHKV0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUHKV0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUHKV0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:26:43 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:5572 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268238AbUHKV0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:26:36 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [TRIVIAL PATCH] use size_t length specifier in mptbase.c
Date: Wed, 11 Aug 2004 14:26:15 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_37oGBd7aAl3enI8"
Message-Id: <200408111426.15537.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_37oGBd7aAl3enI8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks like mptbase.c is using offsetof but trying to use %d instead of %zd 
when printing a warning.  Fix it up to reduce warnings when compiling on 
systems where size_t isn't 32 bits.  With this patch and Alex's earlier one 
to fix up some ACPI warnings applied, the sn2_defconfig target is error and 
warning free.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_37oGBd7aAl3enI8
Content-Type: text/plain;
  charset="us-ascii";
  name="mptbase-size_t-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mptbase-size_t-fix.patch"

===== drivers/message/fusion/mptbase.c 1.26 vs edited =====
--- 1.26/drivers/message/fusion/mptbase.c	2004-06-26 19:26:07 -07:00
+++ edited/drivers/message/fusion/mptbase.c	2004-08-11 14:09:39 -07:00
@@ -2416,7 +2416,7 @@
 		}
 	} else {
 		printk(MYIOC_s_ERR_FMT 
-		     "Invalid IOC facts reply, msgLength=%d offsetof=%d!\n",
+		     "Invalid IOC facts reply, msgLength=%d offsetof=%zd!\n",
 		     ioc->name, facts->MsgLength, (offsetof(IOCFactsReply_t,
 		     RequestFrameSize)/sizeof(u32)));
 		return -66;

--Boundary-00=_37oGBd7aAl3enI8--
