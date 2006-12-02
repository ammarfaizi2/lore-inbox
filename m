Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162418AbWLBLZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162418AbWLBLZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162965AbWLBLZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:25:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162418AbWLBLZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:25:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=lVCfS95QzXxihJzPsDKfX7ociAxTVLsMuxp4KzsZho0NsxjCmU3MTRYWq7LfR6OB2cOYm5lGLZbZvVxbJPLMEaZCvJiI6UoJYsEvAimICtYqMYXw50Q6hx6IT8eUVamOrOp/QaLmNSvQi2e74rAsAwOUVG8sLdfVe1cGYX4jud0=
Subject: [PATCH 2.6.19] arm26: replace kmalloc+memset with kzalloc
From: Yan Burman <burman.yan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, spyro@f2s.com
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:23:09 +0200
Message-Id: <1165058589.4523.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc 

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/arch/arm26/kernel/ecard.c linux-2.6.19-rc5_kzalloc/arch/arm26/kernel/ecard.c
--- linux-2.6.19-rc5_orig/arch/arm26/kernel/ecard.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/arm26/kernel/ecard.c	2006-11-11 22:44:04.000000000 +0200
@@ -620,12 +620,10 @@ ecard_probe(int slot, card_type_t type)
 	struct ex_ecid cid;
 	int i, rc = -ENOMEM;
 
-	ec = kmalloc(sizeof(ecard_t), GFP_KERNEL);
+	ec = kzalloc(sizeof(ecard_t), GFP_KERNEL);
 	if (!ec)
 		goto nomem;
 
-	memset(ec, 0, sizeof(ecard_t));
-
 	ec->slot_no	= slot;
 	ec->type        = type;
 	ec->irq		= NO_IRQ;




