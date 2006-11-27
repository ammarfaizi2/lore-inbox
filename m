Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756807AbWK0FBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbWK0FBU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbWK0FBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:01:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57363 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756807AbWK0FBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:01:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=OU65xoOEnWmONMdS+m3jDt+8VfMp+cZXgJdA1bQDPpNxKuoQAxVu+KtbQToU9tUtkOxKSkH3Tu+/DzUCaU6FeYSrN/AknfKjGN34LB3NmUIJknXGbD/e5ia/NmKYN8/Zq7YcpGI4COppyeC2gtulfWEjk88wdWALkIBKKIwUeoE=
Date: Mon, 27 Nov 2006 13:54:07 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] audit: fix kstrdup() error check
Message-ID: <20061127045407.GA1231@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup() returns NULL on error.

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 kernel/auditfilter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work-fault-inject/kernel/auditfilter.c
===================================================================
--- work-fault-inject.orig/kernel/auditfilter.c
+++ work-fault-inject/kernel/auditfilter.c
@@ -800,8 +800,8 @@ static inline int audit_dupe_selinux_fie
 
 	/* our own copy of se_str */
 	se_str = kstrdup(sf->se_str, GFP_KERNEL);
-	if (unlikely(IS_ERR(se_str)))
-	    return -ENOMEM;
+	if (unlikely(!se_str))
+		return -ENOMEM;
 	df->se_str = se_str;
 
 	/* our own (refreshed) copy of se_rule */
