Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTECIK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 04:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTECIK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 04:10:26 -0400
Received: from [203.145.184.221] ([203.145.184.221]:26896 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263273AbTECIKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 04:10:25 -0400
Subject: [PATCH 2.5.68] mod_timer fix for dst.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-vbmaZismRYQXcf0+/Hme"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 13:57:34 +0530
Message-Id: <1051950454.1243.21.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vbmaZismRYQXcf0+/Hme
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Small fix converting {del,add}_timer to mod_timer.

Applicable for 2.4.x also

vinay


--=-vbmaZismRYQXcf0+/Hme
Content-Disposition: attachment; filename=dst.c.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=dst.c.patch; charset=UTF-8

--- linux-2.5.68/net/core/dst.c	2003-03-25 10:08:35.000000000 +0530
+++ linux-2.5.68-mod/net/core/dst.c	2003-05-03 13:42:12.000000000 +0530
@@ -154,11 +154,9 @@
 	dst->next =3D dst_garbage_list;
 	dst_garbage_list =3D dst;
 	if (dst_gc_timer_inc > DST_GC_INC) {
-		del_timer(&dst_gc_timer);
 		dst_gc_timer_inc =3D DST_GC_INC;
 		dst_gc_timer_expires =3D DST_GC_MIN;
-		dst_gc_timer.expires =3D jiffies + dst_gc_timer_expires;
-		add_timer(&dst_gc_timer);
+		mod_timer(&dst_gc_timer, jiffies + dst_gc_timer_expires);
 	}
 	spin_unlock_bh(&dst_lock);
 }

--=-vbmaZismRYQXcf0+/Hme--

