Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbUCOT10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUCOT10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:27:26 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:11740 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262702AbUCOT1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:27:24 -0500
Date: Mon, 15 Mar 2004 19:27:06 GMT
Message-Id: <200403151927.i2FJR6KQ015688@delerium.codemonkey.org.uk>
From: davej@redhat.com
To: linux-kernel@vger.kernel.org
Subject: [ALSA][2/6] Fix oops when initialisation fails.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try modprobing a driver that the hardware doesn't exist for.
In a few situations, you'll hit an oops due to proc_id not
being filled out that early.

		Dave


--- linux-2.6.4/sound/core/init.c~	2004-03-15 17:45:20.000000000 +0000
+++ linux-2.6.4/sound/core/init.c	2004-03-15 17:45:40.000000000 +0000
@@ -281,7 +281,8 @@
 	}
 	if (card->private_free)
 		card->private_free(card);
-	snd_info_unregister(card->proc_id);
+	if (card->proc_id)
+		snd_info_unregister(card->proc_id);
 	if (snd_info_card_free(card) < 0) {
 		snd_printk(KERN_WARNING "unable to free card info\n");
 		/* Not fatal error */

