Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWHUSe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWHUSe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWHUSe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:34:28 -0400
Received: from server6.greatnet.de ([83.133.96.26]:5043 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750702AbWHUSe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:34:28 -0400
Message-ID: <44E9FCB5.4050101@nachtwindheim.de>
Date: Mon, 21 Aug 2006 20:34:29 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [DOCBOOK] fix segfault in docproc.c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Adds a missing exit, if the file that should be parsed couldn't be opened.
Without it crashes with a segfault, cause the filedescriptor is accessed even if the file could not be opened.
This error happens on 2.6.18-rc4-mm[12] when executing make xmldocs.

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>
---

--- linux-2.6.18-rc4/scripts/basic/docproc.c	2006-06-18 03:49:35.000000000 +0200
+++ linux/scripts/basic/docproc.c	2006-08-18 22:19:48.000000000 +0200
@@ -177,6 +177,7 @@
 		{
 			fprintf(stderr, "docproc: ");
 			perror(real_filename);
+			exit(1);
 		}
 		while(fgets(line, MAXLINESZ, fp)) {
 			char *p;


