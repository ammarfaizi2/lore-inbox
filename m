Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVKGLme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVKGLme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVKGLme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:42:34 -0500
Received: from magic.adaptec.com ([216.52.22.17]:12175 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S964801AbVKGLmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:42:33 -0500
Subject: [PATCH] lib - Fix broken function declaration in linux/textsearch.h
From: Ashutosh Naik <ashutosh_naik@adaptec.com>
To: pablo@eurodev.net, tgraf@suug.ch
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain
Message-Id: <1131363741.30115.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 07 Nov 2005 17:12:21 +0530
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 11:42:23.0369 (UTC) FILETIME=[5198C790:01C5E390]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This PATCH addresses the issue of the init function pointer in
lib/ts_bm.c, lib/ts_fsm.c and lib/ts_kmp.c using a mismatching
definition in linux/textsearch.h


Signed-off-by: Ashutosh Naik <ashutosh.naik@adaptec.com>

--
diff -Naurp linux-2.6.14-git10/include/linux/textsearch.h
linux-2.6.14-git10-mod/include/linux/textsearch.h
--- linux-2.6.14-git10/include/linux/textsearch.h       2005-10-28
05:32:08.000000000 +0530
+++ linux-2.6.14-git10-mod/include/linux/textsearch.h   2005-11-07
16:39:05.000000000 +0530
@@ -40,7 +40,7 @@ struct ts_state
 struct ts_ops
 {
        const char              *name;
-       struct ts_config *      (*init)(const void *, unsigned int,
int);
+       struct ts_config *      (*init)(const void *, unsigned int,
gfp_t);
        unsigned int            (*find)(struct ts_config *,
                                        struct ts_state *);
        void                    (*destroy)(struct ts_config *);


