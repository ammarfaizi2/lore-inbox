Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263142AbVCEPzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbVCEPzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbVCEPyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:54:00 -0500
Received: from coderock.org ([193.77.147.115]:48547 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262117AbVCEPgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:36:02 -0500
Subject: [patch 12/12] scripts/mod/sumversion.c: replace strtok() with strsep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nikai@nikai.net
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:45 +0100
Message-Id: <20050305153545.9769F1F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replaces strtok() with strsep()
 
 Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/scripts/mod/sumversion.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN scripts/mod/sumversion.c~strtok-scripts_mod_sumversion scripts/mod/sumversion.c
--- kj/scripts/mod/sumversion.c~strtok-scripts_mod_sumversion	2005-03-05 16:13:15.000000000 +0100
+++ kj-domen/scripts/mod/sumversion.c	2005-03-05 16:13:15.000000000 +0100
@@ -419,7 +419,9 @@ void get_src_version(const char *modname
 	*end = '\0';
 
 	md4_init(&md);
-	for (fname = strtok(sources, " "); fname; fname = strtok(NULL, " ")) {
+	while ((fname = strsep(&sources, " ")) != NULL) {
+		if (!*fname)
+			continue;
 		if (!parse_source_files(fname, &md))
 			goto release;
 	}
_
