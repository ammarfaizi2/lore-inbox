Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUCAViX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUCAViX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:38:23 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:44715 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261442AbUCAViV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:38:21 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Redundant unplug_timer deletion
Date: Mon, 1 Mar 2004 13:38:07 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB501F2AB4D@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Redundant unplug_timer deletion
Thread-Index: AcP/1Xv6xfgebh8mRduG6Mg1d8jYMg==
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 01 Mar 2004 21:38:07.0741 (UTC) FILETIME=[7C711AD0:01C3FFD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only path to get to del_timer call in __generic_unplug_device()
is when blk_remove_plug() returns 1, and in that case it already
removed the unplug_timer.

Patch to remove this redundant call.

- Ken

--- linux-2.6.3/drivers/block/ll_rw_blk.c	2004-02-17 19:57:16
+++ linux-2.6.3.blk/drivers/block/ll_rw_blk.c	2004-03-01 13:29:37
@@ -1136,8 +1136,6 @@ static inline void __generic_unplug_devi
 	if (!blk_remove_plug(q))
 		return;
 
-	del_timer(&q->unplug_timer);
-
 	/*
 	 * was plugged, fire request_fn if queue has stuff to do
 	 */
