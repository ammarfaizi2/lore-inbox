Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVACRRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVACRRu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVACRRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:17:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58568 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261509AbVACRR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:17:27 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Date: Mon, 3 Jan 2005 09:17:20 -0800
User-Agent: KMail/1.7.1
References: <20050103011113.6f6c8f44.akpm@osdl.org>
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_g4X2Bn95cpVlkJu"
Message-Id: <200501030917.20414.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_g4X2Bn95cpVlkJu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, January 3, 2005 1:11 am, you wrote:
> +replace-numnodes-with-node_online_map-ia64.patch

Here are some compile fixes for this patch.  Looks like simple typos.  Note 
that the kernel won't boot even with these fixes, I'm debugging that now 
(suspect nodemask related stuff is causing the hang too).

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Jesse

--Boundary-00=_g4X2Bn95cpVlkJu
Content-Type: text/plain;
  charset="iso-8859-1";
  name="for-each-node-ia64-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="for-each-node-ia64-fixes.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.10-mm1.orig/arch/ia64/mm/discontig.c linux-2.6.10-mm1/arch/ia64/mm/discontig.c
--- linux-2.6.10-mm1.orig/arch/ia64/mm/discontig.c	2005-01-03 08:58:43.000000000 -0800
+++ linux-2.6.10-mm1/arch/ia64/mm/discontig.c	2005-01-03 08:55:44.000000000 -0800
@@ -379,7 +379,7 @@ static void __init reserve_pernode_space
 	struct bootmem_data *bdp;
 	int node;
 
-	for_each_online(node) {
+	for_each_online_node(node) {
 		pg_data_t *pdp = mem_data[node].pgdat;
 
 		bdp = pdp->bdata;
diff -Napur -X /home/jbarnes/dontdiff linux-2.6.10-mm1.orig/arch/ia64/sn/kernel/sn2/prominfo_proc.c linux-2.6.10-mm1/arch/ia64/sn/kernel/sn2/prominfo_proc.c
--- linux-2.6.10-mm1.orig/arch/ia64/sn/kernel/sn2/prominfo_proc.c	2005-01-03 08:58:43.000000000 -0800
+++ linux-2.6.10-mm1/arch/ia64/sn/kernel/sn2/prominfo_proc.c	2005-01-03 08:56:25.000000000 -0800
@@ -266,7 +266,7 @@ void __exit prominfo_exit(void)
 	char name[NODE_NAME_LEN];
 
 	entp = proc_entries;
-	for (cnodeid) {
+	for_each_online_node(cnodeid) {
 		remove_proc_entry("fit", *entp);
 		remove_proc_entry("version", *entp);
 		sprintf(name, "node%d", cnodeid);

--Boundary-00=_g4X2Bn95cpVlkJu--
