Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUIUBc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUIUBc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 21:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUIUBc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 21:32:58 -0400
Received: from soda.CSUA.Berkeley.EDU ([128.32.112.233]:25862 "EHLO
	soda.csua.berkeley.edu") by vger.kernel.org with ESMTP
	id S267449AbUIUBc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 21:32:56 -0400
Message-ID: <414F84C2.6000608@csua.berkeley.edu>
Date: Mon, 20 Sep 2004 18:32:50 -0700
From: Mark Goodman <mgoodman@CSUA.Berkeley.EDU>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix NFS3 krb5 clients on x86-64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is necessary to make NFS3 krb5 clients work on x86-64. It 
applies to 2.6.9-rc2. Please apply.

Signed-off-by: Mark Goodman <mgoodman@csua.berkeley.edu>

--- linux-2.6.9-rc2/net/sunrpc/auth_gss/auth_gss.c.orig    2004-09-20 
18:13:55.040214816 -0700
+++ linux-2.6.9-rc2/net/sunrpc/auth_gss/auth_gss.c    2004-09-20 
18:14:10.808817624 -0700
@@ -246,7 +246,7 @@ gss_parse_init_downcall(struct gss_api_m
     spin_lock_init(&ctx->gc_seq_lock);
     atomic_set(&ctx->count,1);
 
-    if (simple_get_bytes(&p, end, uid, sizeof(uid)))
+    if (simple_get_bytes(&p, end, uid, sizeof(*uid)))
         goto err_free_ctx;
     /* FIXME: discarded timeout for now */
     if (simple_get_bytes(&p, end, &timeout, sizeof(timeout)))

