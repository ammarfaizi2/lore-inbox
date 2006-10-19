Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946306AbWJSSRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946306AbWJSSRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946307AbWJSSRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:17:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:3722 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946306AbWJSSQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:16:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=bKF43Q3D2KIWSl+3tsDoF/CwYzpurmy22Rj5a+Cspjrf7yQ1CjFl99vndkKUnh2ZapwEpDuTvUDvqjpuywwrBrZ5alYLj56Wfoqp06OYZqunoixE4/rpSf8OVBhfUuFRInC503LQV8wgSW57hw/nHQws48NAHcu4L3vJFGC1zn0=
Date: Thu, 19 Oct 2006 22:16:49 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/nsproxy.c: use kmemdup()
Message-ID: <20061019181649.GB5346@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/nsproxy.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -44,11 +44,9 @@ static inline struct nsproxy *clone_name
 {
 	struct nsproxy *ns;
 
-	ns = kmalloc(sizeof(struct nsproxy), GFP_KERNEL);
-	if (ns) {
-		memcpy(ns, orig, sizeof(struct nsproxy));
+	ns = kmemdup(orig, sizeof(struct nsproxy), GFP_KERNEL);
+	if (ns)
 		atomic_set(&ns->count, 1);
-	}
 	return ns;
 }
 

