Return-Path: <linux-kernel-owner+w=401wt.eu-S1161280AbWLPR4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWLPR4N (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbWLPR4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:56:13 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:34138 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161280AbWLPR4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:56:12 -0500
Date: Sat, 16 Dec 2006 18:55:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: kaber@trash.net
cc: Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] xt_request_find_match
Message-ID: <Pine.LNX.4.61.0612161851180.30896@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



Reusing code is a good idea, and I would like to do so from my 
match modules. netfilter already provides a xt_request_find_target() but 
an xt_request_find_match() does not yet exist. This patch adds it.

Objections welcome :)

---

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.20-rc1/net/netfilter/x_tables.c
===================================================================
--- linux-2.6.20-rc1.orig/net/netfilter/x_tables.c
+++ linux-2.6.20-rc1/net/netfilter/x_tables.c
@@ -206,6 +206,19 @@ struct xt_match *xt_find_match(int af, c
 }
 EXPORT_SYMBOL(xt_find_match);
 
+struct xt_match *xt_request_find_match(int af, const char *name, u8 revision)
+{
+	struct xt_match *match;
+
+	match = try_then_request_module(xt_find_match(af, name, revision),
+	                                "%st_%s", xt_prefix[af], name);
+	if(IS_ERR(match) || match == NULL)
+		return NULL;
+
+	return match;
+}
+EXPORT_SYMBOL_GPL(xt_request_find_match);
+
 /* Find target, grabs ref.  Returns ERR_PTR() on error. */
 struct xt_target *xt_find_target(int af, const char *name, u8 revision)
 {
#<EOF>

	-`J'
-- 
