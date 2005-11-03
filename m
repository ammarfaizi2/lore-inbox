Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbVKCPGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVKCPGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbVKCPGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:06:50 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:27337 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030258AbVKCPGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:06:49 -0500
Date: Thu, 3 Nov 2005 16:06:46 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] kconfig: fix restart for choice symbols
Message-ID: <Pine.LNX.4.61.0511031606240.2497@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The restart check whether new symbols became visible, didn't always work 
for choice symbols.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/conf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/scripts/kconfig/conf.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/conf.c	2005-11-03 13:19:34.000000000 +0100
+++ linux-2.6/scripts/kconfig/conf.c	2005-11-03 13:22:59.000000000 +0100
@@ -468,7 +468,8 @@ static void check_conf(struct menu *menu
 
 	sym = menu->sym;
 	if (sym) {
-		if (sym_is_changable(sym) && !sym_has_value(sym)) {
+		if ((sym_is_changable(sym) || sym_is_choice(sym)) &&
+		    !sym_has_value(sym)) {
 			if (!conf_cnt++)
 				printf(_("*\n* Restart config...\n*\n"));
 			rootEntry = menu_get_parent_menu(menu);
