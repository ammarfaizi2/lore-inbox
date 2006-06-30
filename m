Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWF3ATB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWF3ATB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWF3ASy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:18:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25535 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S933178AbWF3ASr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:18:47 -0400
Subject: [RFC][Update][Patch 12/16]Fix undefined ">> 32" in revoke code
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:18:44 -0700
Message-Id: <1151626725.6601.82.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"val >> 32" is undefined if val is a 32-bit value, so this code is
broken if CONFIG_LBD is not set.  Make it safe for that case.

Signed-off-by: Stephen Tweedie <sct@redhat.com>
Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.17-ming/fs/jbd/revoke.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/jbd/revoke.c~jbd-revoke-32bit-shift-fix fs/jbd/revoke.c
--- linux-2.6.17/fs/jbd/revoke.c~jbd-revoke-32bit-shift-fix	2006-06-28 16:47:09.695458913 -0700
+++ linux-2.6.17-ming/fs/jbd/revoke.c	2006-06-28 16:47:09.699458454 -0700
@@ -110,7 +110,7 @@ static inline int hash(journal_t *journa
 {
 	struct jbd_revoke_table_s *table = journal->j_revoke;
 	int hash_shift = table->hash_shift;
-	int hash = (int)block ^ (int)(block >> 32);
+	int hash = (int)block ^ (int)((block >> 31) >> 1);
 
 	return ((hash << (hash_shift - 6)) ^
 		(hash >> 13) ^

_


