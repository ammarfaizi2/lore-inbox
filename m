Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCAAdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCAAdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVCAAdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:33:50 -0500
Received: from mailfe03.swip.net ([212.247.154.65]:62952 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261158AbVCAAdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:33:18 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: [PATCH] SELinux: null dereference in error path
From: Alexander Nyberg <alexn@dsv.su.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jmorris@redhat.com, sds@epoch.ncsc.mil
Content-Type: text/plain
Date: Tue, 01 Mar 2005 01:32:54 +0100
Message-Id: <1109637174.3839.13.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bad' label will call function that unconditionally dereferences
the NULL pointer.

Found by the Coverity tool

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

===== security/selinux/ss/policydb.c 1.16 vs edited =====
--- 1.16/security/selinux/ss/policydb.c	2005-01-15 23:01:45 +01:00
+++ edited/security/selinux/ss/policydb.c	2005-02-26 12:47:44 +01:00
@@ -773,7 +773,7 @@ static int class_read(struct policydb *p
 	cladatum = kmalloc(sizeof(*cladatum), GFP_KERNEL);
 	if (!cladatum) {
 		rc = -ENOMEM;
-		goto bad;
+		goto out;
 	}
 	memset(cladatum, 0, sizeof(*cladatum));
 


