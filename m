Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUDPVRZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUDPVRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:17:25 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:65438 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263760AbUDPVRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:17:24 -0400
Date: Fri, 16 Apr 2004 22:16:28 +0100
From: Dave Jones <davej@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NFS thinko
Message-ID: <20040416211628.GM20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, trond.myklebust@fys.uio.no,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dereferencing 'exp' before the check for NULL.

		Dave


--- linux-2.6.5/include/linux/nfsd/export.h~	2004-04-16 22:13:28.000000000 +0100
+++ linux-2.6.5/include/linux/nfsd/export.h	2004-04-16 22:14:21.000000000 +0100
@@ -118,13 +118,15 @@
 	if (ek && !IS_ERR(ek)) {
 		struct svc_export *exp = ek->ek_export;
 		int err;
+		if (!exp)
+			goto out;
 		cache_get(&exp->h);
 		expkey_put(&ek->h, &svc_expkey_cache);
-		if (exp &&
-		    (err = cache_check(&svc_export_cache, &exp->h, reqp)))
+		if (err = cache_check(&svc_export_cache, &exp->h, reqp))
 			exp = ERR_PTR(err);
 		return exp;
 	} else
+out:
 		return ERR_PTR(PTR_ERR(ek));
 }
 
