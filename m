Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWDJDVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWDJDVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 23:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWDJDVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 23:21:20 -0400
Received: from xenotime.net ([66.160.160.81]:3533 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750942AbWDJDVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 23:21:20 -0400
Date: Sun, 9 Apr 2006 20:23:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, zippel@linux-m68k.org, sam@ravnborg.org
Subject: [PATCH] config: exit if no beginning filename
Message-Id: <20060409202338.53e1731d.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

If the beginning Kconfig file is missing, config segfaults
so it might as well exit after the error message.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kconfig/conf.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2617-rc1.orig/scripts/kconfig/conf.c
+++ linux-2617-rc1/scripts/kconfig/conf.c
@@ -553,6 +553,7 @@ int main(int ac, char **av)
   	name = av[i];
 	if (!name) {
 		printf(_("%s: Kconfig file missing\n"), av[0]);
+		exit(1);
 	}
 	conf_parse(name);
 	//zconfdump(stdout);


---
