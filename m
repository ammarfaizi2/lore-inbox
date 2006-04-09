Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWDIP0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWDIP0l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWDIP0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:26:41 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27818 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750771AbWDIP0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:26:40 -0400
Date: Sun, 9 Apr 2006 17:26:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/19] kconfig: fix default value for choice input
Message-ID: <Pine.LNX.4.64.0604091726250.23108@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The wrong default value can cause conf to end up in endless loop for choice
questions.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/conf.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6-git/scripts/kconfig/conf.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/conf.c
+++ linux-2.6-git/scripts/kconfig/conf.c
@@ -328,8 +328,7 @@ static int conf_choice(struct menu *menu
 		printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
 		def_sym = sym_get_choice_value(sym);
 		cnt = def = 0;
-		line[0] = '0';
-		line[1] = 0;
+		line[0] = 0;
 		for (child = menu->list; child; child = child->next) {
 			if (!menu_is_visible(child))
 				continue;
