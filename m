Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWF3ASy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWF3ASy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWF3ASw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:18:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:33196 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S933175AbWF3AS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:18:28 -0400
Subject: [RFC][Update][Patch 10/16]Cleanup journal_tag_bytes()
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:18:25 -0700
Message-Id: <1151626706.6601.80.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup journal_tag_bytes() to use the new JBD_TAG_SIZE* macros.

Signed-off-by: Stephen Tweedie <sct@redhat.com>
Acked-by: Badari Pulavarty <pbadari@us.ibm.com>


---

 linux-2.6.17-ming/fs/jbd/journal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/jbd/journal.c~jbd-cleanup-journal_tag_bytes fs/jbd/journal.c
--- linux-2.6.17/fs/jbd/journal.c~jbd-cleanup-journal_tag_bytes	2006-06-28 16:47:05.112984715 -0700
+++ linux-2.6.17-ming/fs/jbd/journal.c	2006-06-28 16:47:05.117984141 -0700
@@ -1608,9 +1608,9 @@ int journal_blocks_per_page(struct inode
 size_t journal_tag_bytes(journal_t *journal)
 {
 	if (JFS_HAS_INCOMPAT_FEATURE(journal, JFS_FEATURE_INCOMPAT_64BIT))
-		return sizeof(journal_block_tag_t);
+		return JBD_TAG_SIZE64;
 	else
-		return offsetof(journal_block_tag_t, t_blocknr_high);
+		return JBD_TAG_SIZE32;
 }
 
 /*

_


