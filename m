Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVCEPKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVCEPKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVCEPKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:10:18 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:58549 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261481AbVCEPIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:08:45 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sat, 5 Mar 2005 16:08:44 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] qtronix missing failure handling
Message-ID: <20050305150844.GA7544@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Qtronix keyboard driver doesn't handle the possible failure of memory
allocation.

Signed-off-by: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>

diff -pruN linux-2.6.11-mm1/drivers/char/qtronix.c linux-2.6.11-mm1-pi/drivers/char/qtronix.c
--- linux-2.6.11-mm1/drivers/char/qtronix.c	2005-03-05 15:56:43.000000000 +0100
+++ linux-2.6.11-mm1-pi/drivers/char/qtronix.c	2005-03-05 15:57:22.000000000 +0100
@@ -591,6 +591,11 @@ static int __init psaux_init(void)
 		return retval;
 
 	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
+	if (!queue) {
+		misc_deregister(&psaux_mouse);
+		return -ENOMEM;
+	}
+		
 	memset(queue, 0, sizeof(*queue));
 	queue->head = queue->tail = 0;
 	init_waitqueue_head(&queue->proc_list);
-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/
