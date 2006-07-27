Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWG0U4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWG0U4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWG0UyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:54:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750799AbWG0UxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:15 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 03/30] NFS: Disambiguate nfs_stat_to_errno() [try #11]
Date: Thu, 27 Jul 2006 21:52:32 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205232.8443.14318.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the NFS4 version of nfs_stat_to_errno() so that it doesn't conflict with
the common one used by NFS2 and NFS3.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/nfs4xdr.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1750d99..14377f2 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -58,7 +58,7 @@ #define NFSDBG_FACILITY		NFSDBG_XDR
 /* Mapping from NFS error code to "errno" error code. */
 #define errno_NFSERR_IO		EIO
 
-static int nfs_stat_to_errno(int);
+static int nfs4_stat_to_errno(int);
 
 /* NFSv4 COMPOUND tags are only wanted for debugging purposes */
 #ifdef DEBUG
@@ -2127,7 +2127,7 @@ static int decode_op_hdr(struct xdr_stre
 	}
 	READ32(nfserr);
 	if (nfserr != NFS_OK)
-		return -nfs_stat_to_errno(nfserr);
+		return -nfs4_stat_to_errno(nfserr);
 	return 0;
 }
 
@@ -3597,7 +3597,7 @@ static int decode_setclientid(struct xdr
 		READ_BUF(len);
 		return -NFSERR_CLID_INUSE;
 	} else
-		return -nfs_stat_to_errno(nfserr);
+		return -nfs4_stat_to_errno(nfserr);
 
 	return 0;
 }
@@ -4255,7 +4255,7 @@ static int nfs4_xdr_dec_fsinfo(struct rp
 	if (!status)
 		status = decode_fsinfo(&xdr, fsinfo);
 	if (!status)
-		status = -nfs_stat_to_errno(hdr.status);
+		status = -nfs4_stat_to_errno(hdr.status);
 	return status;
 }
 
@@ -4345,7 +4345,7 @@ static int nfs4_xdr_dec_setclientid(stru
 	if (!status)
 		status = decode_setclientid(&xdr, clp);
 	if (!status)
-		status = -nfs_stat_to_errno(hdr.status);
+		status = -nfs4_stat_to_errno(hdr.status);
 	return status;
 }
 
@@ -4367,7 +4367,7 @@ static int nfs4_xdr_dec_setclientid_conf
 	if (!status)
 		status = decode_fsinfo(&xdr, fsinfo);
 	if (!status)
-		status = -nfs_stat_to_errno(hdr.status);
+		status = -nfs4_stat_to_errno(hdr.status);
 	return status;
 }
 
@@ -4520,7 +4520,7 @@ static struct {
  * This one is used jointly by NFSv2 and NFSv3.
  */
 static int
-nfs_stat_to_errno(int stat)
+nfs4_stat_to_errno(int stat)
 {
 	int i;
 	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
