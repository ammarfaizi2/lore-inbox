Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932221AbWFDL0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWFDL0a (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 07:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWFDL0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 07:26:30 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:64420 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932221AbWFDL0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 07:26:30 -0400
Message-ID: <349420386.12104@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sun, 4 Jun 2006 19:26:36 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: [PATCH] radixtree: normalize radix_tree_tag_get() return value
Message-ID: <20060604112636.GB5984@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	nickpiggin@yahoo.com.au
References: <349410738.29011@ustc.edu.cn> <20060604021105.1ce7d727.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604021105.1ce7d727.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In radix_tree_tag_get(), return normalized value of 0/1, as indicated
by its comment.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

--- linux-2.6.17-rc5-mm2.orig/lib/radix-tree.c
+++ linux-2.6.17-rc5-mm2/lib/radix-tree.c
@@ -531,7 +531,7 @@ int radix_tree_tag_get(struct radix_tree
 			int ret = tag_get(slot, tag, offset);
 
 			BUG_ON(ret && saw_unset_tag);
-			return ret;
+			return !! ret;
 		}
 		slot = slot->slots[offset];
 		shift -= RADIX_TREE_MAP_SHIFT;
