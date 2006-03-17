Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWCQNLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWCQNLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 08:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWCQNLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 08:11:13 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:41307 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S932435AbWCQNLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 08:11:12 -0500
X-ME-UUID: 20060317131111604.93A0F1C00059@mwinf1208.wanadoo.fr
From: Laurent Wandrebeck <l.wandrebeck@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [patch 1/1] telephony ixc missing return check for request_region()
Date: Fri, 17 Mar 2006 14:15:17 +0100
User-Agent: KMail/1.8
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603171415.18120.l.wandrebeck@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
in drivers/telephony/ixj.c, request_region() is called without checking the return
value. Here is a simple patch to fix it.
Patch against 2.6.16-rc6-git8.
Please CC me on replies.
Regards.

Signed-off-by: Laurent Wandrebeck <l.wandrebeck@free.fr>

--- linux-2.6.16-rc6/drivers/telephony/ixj.c.ori        2006-03-11 23:12:55.000000000 +0100
+++ linux-2.6.16-rc6/drivers/telephony/ixj.c    2006-03-17 14:10:32.000000000 +0100
@@ -6802,7 +6802,10 @@ static int ixj_selfprobe(IXJ *j)
                        }
                } else if (j->dsp.low == 0x22) {
                        j->cardtype = QTI_PHONEJACK_PCI;
-                       request_region(j->XILINXbase, 4, "ixj control");
+                       if (!request_region(j->XILINXbase, 4, "ixj control")) {
+                               printk(KERN_INFO "ixj: can't get I/O address 0x%x\n", j->XILINXbase);
+                               return -1;
+                       }
                        j->pld_slicw.pcib.e1 = 1;
                        outb_p(j->pld_slicw.byte, j->XILINXbase);
                } else

