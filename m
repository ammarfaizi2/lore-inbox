Return-Path: <linux-kernel-owner+w=401wt.eu-S1751201AbXAFH1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbXAFH1K (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXAFH1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:27:09 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59155 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751201AbXAFH1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:27:07 -0500
Message-ID: <368068421.28878@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20070106072730.019364791@mail.ustc.edu.cn>
References: <20070106072626.911640026@mail.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Sat, 06 Jan 2007 15:26:31 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] readahead: call scheme: remove get_readahead_bounds()
Content-Disposition: inline; filename=readahead-call-scheme-remove-get_readahead_bounds.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the one and only get_readahead_bounds() call.

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>

---
 mm/readahead.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.20-rc3-mm1.orig/mm/readahead.c
+++ linux-2.6.20-rc3-mm1/mm/readahead.c
@@ -1572,7 +1572,6 @@ page_cache_readahead_adaptive(struct add
 				pgoff_t offset, unsigned long req_size)
 {
 	unsigned long ra_size;
-	unsigned long ra_min;
 	unsigned long ra_max;
 	int ret;
 
@@ -1593,7 +1592,7 @@ page_cache_readahead_adaptive(struct add
 	else if (offset)
 		ra_account(ra, RA_EVENT_CACHE_MISS, req_size);
 
-	get_readahead_bounds(ra, &ra_min, &ra_max);
+	ra_max = get_max_readahead(ra);
 
 	/* read-ahead disabled? */
 	if (unlikely(!ra_max || !readahead_ratio)) {
@@ -1633,7 +1632,7 @@ page_cache_readahead_adaptive(struct add
 	 * Context based sequential read-ahead.
 	 */
 	ret = try_context_based_readahead(mapping, ra, page,
-							offset, ra_min, ra_max);
+						offset, req_size, ra_max);
 	if (ret > 0)
 		return ra_submit(ra, mapping, filp);
 	if (ret < 0)

--
