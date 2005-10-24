Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVJXBHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVJXBHu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 21:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVJXBHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 21:07:50 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:18596 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750887AbVJXBHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 21:07:50 -0400
Date: Mon, 24 Oct 2005 11:07:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@osdl.org>
Subject: [PATCH] propogate gfp_t changes further
Message-Id: <20051024110736.7bbe004e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This small patch gits rid of a couple of compile warnings.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/linux/textsearch.h |    4 ++--
 lib/textsearch.c           |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

3c2113ffbc51db2bd1e1285c60657850289e634d
diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -40,7 +40,7 @@ struct ts_state
 struct ts_ops
 {
 	const char		*name;
-	struct ts_config *	(*init)(const void *, unsigned int, int);
+	struct ts_config *	(*init)(const void *, unsigned int, gfp_t);
 	unsigned int		(*find)(struct ts_config *,
 					struct ts_state *);
 	void			(*destroy)(struct ts_config *);
@@ -148,7 +148,7 @@ static inline unsigned int textsearch_ge
 extern int textsearch_register(struct ts_ops *);
 extern int textsearch_unregister(struct ts_ops *);
 extern struct ts_config *textsearch_prepare(const char *, const void *,
-					    unsigned int, int, int);
+					    unsigned int, gfp_t, int);
 extern void textsearch_destroy(struct ts_config *conf);
 extern unsigned int textsearch_find_continuous(struct ts_config *,
 					       struct ts_state *,
diff --git a/lib/textsearch.c b/lib/textsearch.c
--- a/lib/textsearch.c
+++ b/lib/textsearch.c
@@ -254,7 +254,8 @@ unsigned int textsearch_find_continuous(
  *         parameters or a ERR_PTR().
  */
 struct ts_config *textsearch_prepare(const char *algo, const void *pattern,
-				     unsigned int len, int gfp_mask, int flags)
+				     unsigned int len, gfp_t gfp_mask,
+				     int flags)
 {
 	int err = -ENOENT;
 	struct ts_config *conf;
