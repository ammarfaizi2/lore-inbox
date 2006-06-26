Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933103AbWFZWat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103AbWFZWat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbWFZWat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:30:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:31669 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933103AbWFZWas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:30:48 -0400
Date: Mon, 26 Jun 2006 17:30:32 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: Badari Pulavarty <pbadari@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm2 & ecryptfs
Message-ID: <20060626223032.GD2867@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <1151359559.32250.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151359559.32250.15.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 03:05:59PM -0700, Badari Pulavarty wrote:
> I am not sure, if its already reported or not. 
> 
> 2.6.17-mm2 vfs_statfs() takes a "dentry" instead of "sb".
> ecryptfs seems to be broken :(

Yeah, that one slipped right by me with the API change.

---

Update ecryptfs_statfs (API change).

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---
 fs/ecryptfs/super.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

b3c064b2248bd949c07900aab9ac4517f301d66c
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 437a542..8b014a4 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -122,9 +122,9 @@ static void ecryptfs_put_super(struct su
  * Get the filesystem statistics. Currently, we let this pass right through
  * to the lower filesystem and take no action ourselves.
  */
-static inline int ecryptfs_statfs(struct super_block *sb, struct kstatfs *buf)
+static inline int ecryptfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	return vfs_statfs(ecryptfs_superblock_to_lower(sb), buf);
+	return vfs_statfs(ecryptfs_dentry_to_lower(dentry), buf);
 }
 
 /**
-- 
1.3.3

