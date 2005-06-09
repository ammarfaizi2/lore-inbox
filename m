Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFIB5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFIB5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVFIB5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:57:17 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:5722 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261203AbVFIB5O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 21:57:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=le4xfTx0Kjwyg7dfKiG6F0FG4UZ/7t6n4DlzOv+CtOuUvc5cY1EeIz9zkUNvQpKzUyoNxjBdPQALQIhJAXBz/TvICLrEbChDavT6OD+rV1SX+IZ6yH8Ouub7VbzulQx51451F7WsxqBPGRr1ZDHfA+IqwMLQWlsLSK0mhpMDUu4=
Message-ID: <9e473391050608185732750f46@mail.gmail.com>
Date: Wed, 8 Jun 2005 21:57:13 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: PATCH: fix 32/62 div in HPET driver
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 64 bit div should be one that adjusts 32/64 depending on arch.

Signed off by: jonsmirl@gmail.com <Jon Smirl>
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -834,7 +834,7 @@ int hpet_alloc(struct hpet_data *hdp)
 	printk("\n");
 
 	ns = hpetp->hp_period;	/* femptoseconds, 10^-15 */
-	do_div(ns, 1000000);	/* convert to nanoseconds, 10^-9 */
+	ns /= 1000000;		/* convert to nanoseconds, 10^-9 */
 	printk(KERN_INFO "hpet%d: %ldns tick, %d %d-bit timers\n",
 		hpetp->hp_which, ns, hpetp->hp_ntimer,
 		cap & HPET_COUNTER_SIZE_MASK ? 64 : 32);

-- 
Jon Smirl
jonsmirl@gmail.com
