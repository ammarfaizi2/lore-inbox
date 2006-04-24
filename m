Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWDXVYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWDXVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWDXVX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:23:56 -0400
Received: from mx.pathscale.com ([64.160.42.68]:36547 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751291AbWDXVXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:23:41 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 12 of 13] ipath - fix label name in interrupt handler
X-Mercurial-Node: e3f1bfd7ce468cc4df69c757b21a994f3877a8bc
Message-Id: <e3f1bfd7ce468cc4df69.1145913788@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1145913776@eng-12.pathscale.com>
Date: Mon, 24 Apr 2006 14:23:08 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Names that are the opposite of their intended meanings are not so helpful.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r f23abcaaea84 -r e3f1bfd7ce46 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Mon Apr 24 14:21:04 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Mon Apr 24 14:21:04 2006 -0700
@@ -665,14 +665,14 @@ static void handle_layer_pioavail(struct
 
 	ret = __ipath_layer_intr(dd, IPATH_LAYER_INT_SEND_CONTINUE);
 	if (ret > 0)
-		goto clear;
+		goto set;
 
 	ret = __ipath_verbs_piobufavail(dd);
 	if (ret > 0)
-		goto clear;
+		goto set;
 
 	return;
-clear:
+set:
 	set_bit(IPATH_S_PIOINTBUFAVAIL, &dd->ipath_sendctrl);
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
 			 dd->ipath_sendctrl);
