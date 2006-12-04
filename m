Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759757AbWLDIyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759757AbWLDIyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 03:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759763AbWLDIyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 03:54:38 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:22961 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1759754AbWLDIyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 03:54:37 -0500
Message-ID: <365222471.26712@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 4 Dec 2006 16:54:36 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] io accounting minor fix
Message-ID: <20061204085436.GA6602@mail.ustc.edu.cn>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Account only successful nfs/fuse reads.

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.19-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc6-mm2/mm/readahead.c
@@ -242,7 +242,6 @@ int read_cache_pages(struct address_spac
 			page_cache_release(page);
 			continue;
 		}
-		task_io_account_read(PAGE_CACHE_SIZE);
 		ret = filler(data, page);
 		if (!pagevec_add(&lru_pvec, page)) {
 			cond_resched();
@@ -252,6 +251,7 @@ int read_cache_pages(struct address_spac
 			put_pages_list(pages);
 			break;
 		}
+		task_io_account_read(PAGE_CACHE_SIZE);
 	}
 	pagevec_lru_add(&lru_pvec);
 	return ret;
