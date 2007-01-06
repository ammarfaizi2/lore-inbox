Return-Path: <linux-kernel-owner+w=401wt.eu-S1751205AbXAFH2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXAFH2A (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbXAFH1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:27:36 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59162 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751203AbXAFH1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:27:20 -0500
Message-ID: <368068421.90785@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20070106072730.157093477@mail.ustc.edu.cn>
References: <20070106072626.911640026@mail.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Sat, 06 Jan 2007 15:26:32 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] readahead: nfsd case: remove ra_min
Content-Disposition: inline; filename=readahead-nfsd-case-remove-ra_min.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ra_min => req_size.
Now it is for try_context_based_readahead() to compute ra_min from req_size.

Please fold it into readahead-nfsd-case.patch to avoid a compiling error.

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
---
 mm/readahead.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.20-rc3-mm1.orig/mm/readahead.c
+++ linux-2.6.20-rc3-mm1/mm/readahead.c
@@ -1673,7 +1673,7 @@ readit:
 		   !probe_page(mapping, ra_index)) {
 			ra->prev_page = ra_index - 1;
 			ret = try_context_based_readahead(mapping, ra, NULL,
-						 ra_index, ra_min, ra_max);
+						 ra_index, req_size, ra_max);
 			if (ret > 0)
 				ra_size += ra_submit(ra, mapping, filp);
 		}

--
