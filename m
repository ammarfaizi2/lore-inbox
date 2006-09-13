Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWIMGqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWIMGqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWIMGqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:46:23 -0400
Received: from mx10.go2.pl ([193.17.41.74]:43668 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751631AbWIMGqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:46:22 -0400
Date: Wed, 13 Sep 2006 08:50:10 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060913065010.GA2110@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Probably after 2.6.18-rc6-git1 there is this cc warning: 
"arch/i386/kernel/mpparse.c:231: warning: comparison is
always false due to limited range of data type".
Maybe this patch will be helpful.

Jarek P.


diff -Nurp linux-2.6.18-rc6-git4-/arch/i386/kernel/mpparse.c linux-2.6.18-rc6-git4/arch/i386/kernel/mpparse.c
--- linux-2.6.18-rc6-git4-/arch/i386/kernel/mpparse.c	2006-09-13 00:01:00.000000000 +0200
+++ linux-2.6.18-rc6-git4/arch/i386/kernel/mpparse.c	2006-09-13 00:01:00.000000000 +0200
@@ -228,12 +228,14 @@ static void __init MP_bus_info (struct m
 
 	mpc_oem_bus_info(m, str, translation_table[mpc_record]);
 
+#if 0xFF >= MAX_MP_BUSSES
 	if (m->mpc_busid >= MAX_MP_BUSSES) {
 		printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
 			" is too large, max. supported is %d\n",
 			m->mpc_busid, str, MAX_MP_BUSSES - 1);
 		return;
 	}
+#endif
 
 	if (strncmp(str, BUSTYPE_ISA, sizeof(BUSTYPE_ISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
