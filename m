Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUIWHUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUIWHUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 03:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIWHUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 03:20:49 -0400
Received: from soda.CSUA.Berkeley.EDU ([128.32.112.233]:13829 "EHLO
	soda.csua.berkeley.edu") by vger.kernel.org with ESMTP
	id S268301AbUIWHUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 03:20:47 -0400
Message-ID: <415278CF.6010505@csua.berkeley.edu>
Date: Thu, 23 Sep 2004 00:18:39 -0700
From: Mark Goodman <mgoodman@CSUA.Berkeley.EDU>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Let NFS3 krb5 mounts survive a krb5 ticket expiration
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my environment, this patch lets NFS3 krb5 mounts survive a krb5 
ticket expiration. It applies to 2.6.9-rc2. Please consider applying.

Signed-off-by: Mark Goodman <mgoodman@csua.berkeley.edu>

--- linux-2.6.9-rc2/net/sunrpc/auth_gss/auth_gss.c.orig    2004-09-23 
00:07:28.891626224 -0700
+++ linux-2.6.9-rc2/net/sunrpc/auth_gss/auth_gss.c    2004-09-23 
00:06:56.159602248 -0700
@@ -742,6 +742,9 @@ gss_marshal(struct rpc_task *task, u32 *
                    &verf_buf, &mic);
     if(maj_stat != 0){
         printk("gss_marshal: gss_get_mic FAILED (%d)\n", maj_stat);
+        if (maj_stat == GSS_S_CONTEXT_EXPIRED) {
+            cred->cr_flags |= RPCAUTH_CRED_DEAD;
+        }
         goto out_put_ctx;
     }
     p = xdr_encode_opaque(p, NULL, mic.len);

