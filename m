Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbWJLF3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbWJLF3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWJLF3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:29:12 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:51160 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965278AbWJLF3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:29:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=a8zRbbuluhOPCsBglnIONfmcA+1WlPQdfx/Z8O181kRnzmhjKGPpThy0JjiCECmJuJ9fGPfztiQOvez2crYzuPaDVRb0FhZW7tAUh8QQy0EM9j6G1nbUH2JDwe35rdPu9nrv/9gxtWEmszCg+eKAFuXjTHffDtzAHFfAJF6CDBs=
Date: Thu, 12 Oct 2006 14:29:33 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark.fasheh@oracle.com>, Kurt Hackel <kurt.hackel@oracle.com>
Subject: [PATCH] ocfs2: delete redundant memcmp()
Message-ID: <20061012052933.GB29465@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Mark Fasheh <mark.fasheh@oracle.com>,
	Kurt Hackel <kurt.hackel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch deletes redundant memcmp() while looking up in rb tree.

Cc: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Kurt Hackel <kurt.hackel@oracle.com>
Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

 fs/ocfs2/cluster/nodemanager.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: work-fault-inject/fs/ocfs2/cluster/nodemanager.c
===================================================================
--- work-fault-inject.orig/fs/ocfs2/cluster/nodemanager.c
+++ work-fault-inject/fs/ocfs2/cluster/nodemanager.c
@@ -152,14 +152,16 @@ static struct o2nm_node *o2nm_node_ip_tr
 	struct o2nm_node *node, *ret = NULL;
 
 	while (*p) {
+		int cmp;
+
 		parent = *p;
 		node = rb_entry(parent, struct o2nm_node, nd_ip_node);
 
-		if (memcmp(&ip_needle, &node->nd_ipv4_address,
-		           sizeof(ip_needle)) < 0)
+		cmp = memcmp(&ip_needle, &node->nd_ipv4_address,
+				sizeof(ip_needle));
+		if (cmp < 0)
 			p = &(*p)->rb_left;
-		else if (memcmp(&ip_needle, &node->nd_ipv4_address,
-			        sizeof(ip_needle)) > 0)
+		else if (cmp > 0)
 			p = &(*p)->rb_right;
 		else {
 			ret = node;
