Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVJBRDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVJBRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJBRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 13:03:25 -0400
Received: from host-84-9-203-39.bulldogdsl.com ([84.9.203.39]:62851 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751128AbVJBRDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 13:03:25 -0400
Date: Sun, 2 Oct 2005 18:03:18 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] release_resource() check for NULL resource
Message-ID: <20051002170318.GA22074@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If release_resource() is passed a NULL resource
the kernel will OOPS.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urN -X ../dontdiff linux-2.6.14-rc3/kernel/resource.c linux-2.6.14-rc3-bjd1/kernel/resource.c
--- linux-2.6.14-rc3/kernel/resource.c	2005-10-02 12:58:03.000000000 +0100
+++ linux-2.6.14-rc3-bjd1/kernel/resource.c	2005-10-02 17:58:09.000000000 +0100
@@ -181,6 +181,9 @@
 {
 	struct resource *tmp, **p;
 
+	if (!old)
+		return 0;
+
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="resource-release-null.patch"

diff -urN -X ../dontdiff linux-2.6.14-rc3/kernel/resource.c linux-2.6.14-rc3-bjd1/kernel/resource.c
--- linux-2.6.14-rc3/kernel/resource.c	2005-10-02 12:58:03.000000000 +0100
+++ linux-2.6.14-rc3-bjd1/kernel/resource.c	2005-10-02 17:58:09.000000000 +0100
@@ -181,6 +181,9 @@
 {
 	struct resource *tmp, **p;
 
+	if (!old)
+		return 0;
+
 	p = &old->parent->child;
 	for (;;) {
 		tmp = *p;

--UugvWAfsgieZRqgk--
