Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164363AbWLHBPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164363AbWLHBPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164346AbWLHBOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:14:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:47309 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164325AbWLHBOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:14:38 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:14:51 +1100
Message-Id: <1061208011451.30761@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 017 of 18] knfsd: Don't ignore kstrdup failure in rpc caches.
References: <20061208120939.30428.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcauth_unix.c |    4 ++++
 1 file changed, 4 insertions(+)

diff .prev/net/sunrpc/svcauth_unix.c ./net/sunrpc/svcauth_unix.c
--- .prev/net/sunrpc/svcauth_unix.c	2006-12-08 12:08:37.000000000 +1100
+++ ./net/sunrpc/svcauth_unix.c	2006-12-08 12:09:31.000000000 +1100
@@ -53,6 +53,10 @@ struct auth_domain *unix_domain_find(cha
 			return NULL;
 		kref_init(&new->h.ref);
 		new->h.name = kstrdup(name, GFP_KERNEL);
+		if (new->h.name == NULL) {
+			kfree(new);
+			return NULL;
+		}
 		new->h.flavour = &svcauth_unix;
 		new->addr_changes = 0;
 		rv = auth_domain_lookup(name, &new->h);
