Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbWJBS0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbWJBS0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWJBS0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:26:09 -0400
Received: from mail.fieldses.org ([66.93.2.214]:1152 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S965261AbWJBS0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:26:07 -0400
Date: Mon, 2 Oct 2006 14:26:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: NeilBrown <neilb@suse.de>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2 of 3] nfsd4: fslocs: fix compile in non-CONFIG_NFSD_V4 case
Message-ID: <20061002182603.GD8084@fieldses.org>
References: <20060929130518.23919.patches@notabene> <1060929030913.24108@suse.de> <20060928234540.fd74f1e1.akpm@osdl.org> <20061002182327.GB8084@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002182327.GB8084@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix fsloc_parse in the non-CONFIG_NFSD_V4 case, to make it inline, to
make it consistent with the definition in the CONFIG_NFSD_V4 case, and
to include parameter names.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 fs/nfsd/export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 71f3655..ee7b03a 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -463,7 +463,7 @@ out_free_all:
 }
 
 #else /* CONFIG_NFSD_V4 */
-static int fsloc_parse(char **, char *, struct svc_export *) { return 0; }
+static inline int fsloc_parse(char **mesg, char *buf, struct nfsd4_fs_locations *fsloc) { return 0; }
 #endif
 
 static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
-- 
1.4.2.g55c3

