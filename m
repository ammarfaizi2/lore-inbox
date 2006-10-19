Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946238AbWJSRJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946238AbWJSRJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946252AbWJSRI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:08:58 -0400
Received: from mx2.netapp.com ([216.240.18.37]:1709 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946238AbWJSRGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:10 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607096:sNHT18874460"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 01/11] NFSv4: Fix thinko in fs/nfs/super.c
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:27.0957 (UTC) FILETIME=[EA66F250:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Duh. addr.sin_port should be in network byte order.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/super.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 28659a9..28108c8 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -834,7 +834,7 @@ static int nfs4_get_sb(struct file_syste
 	}
 	/* RFC3530: The default port for NFS is 2049 */
 	if (addr.sin_port == 0)
-		addr.sin_port = NFS_PORT;
+		addr.sin_port = htons(NFS_PORT);
 
 	/* Grab the authentication type */
 	authflavour = RPC_AUTH_UNIX;
