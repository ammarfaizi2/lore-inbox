Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVJTVxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVJTVxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbVJTVxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:53:19 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:33366 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932513AbVJTVxT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:53:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sPT7afhvfjtzC0HYbLBEPOfEDJVT16GISmF7PrnOa/fUhhtvK6INxgm9QRY7B4S578Q2aNdncl+S0vcAtSG0iJ425QPeTcmF2QvXE85XGhnJPR9chnnqI0p3ZriLW/ntvGOrqthrmfQvsHEr20+VdLx+Fak3u3TCMb7VOHH/MY8=
Message-ID: <ff1cadb20510201453n1754e10er@mail.gmail.com>
Date: Thu, 20 Oct 2005 23:53:18 +0200
From: Luca Falavigna <dktrkranz@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] Use kzalloc instead of kcalloc in kernel/kprobes.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch, compiled against kernel version 2.6.14-rc5,
substitutes kcalloc with kzalloc in kernel/kprobes.c

Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -418,7 +418,7 @@ static inline void add_aggr_kprobe(struc
 /*
  * This is the second or subsequent kprobe at the address - handle
  * the intricacies
- * TODO: Move kcalloc outside the spinlock
+ * TODO: Move kzalloc outside the spinlock
  */
 static int __kprobes register_aggr_kprobe(struct kprobe *old_p,
 					  struct kprobe *p)
@@ -430,7 +430,7 @@ static int __kprobes register_aggr_kprob
 		copy_kprobe(old_p, p);
 		ret = add_new_kprobe(old_p, p);
 	} else {
-		ap = kcalloc(1, sizeof(struct kprobe), GFP_ATOMIC);
+		ap = kzalloc(sizeof(struct kprobe), GFP_ATOMIC);
 		if (!ap)
 			return -ENOMEM;
 		add_aggr_kprobe(ap, old_p);

Regards,
--
Luca
