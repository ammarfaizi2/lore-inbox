Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVDXSWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVDXSWi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVDXSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:21:58 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:46530 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262362AbVDXSUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:20:30 -0400
Subject: [patch 1/6] uml: workaround old problematic sed behaviour [compile-fix, for 2.6.12]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       rob@landley.net, imcdnzl@gmail.com
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:09:53 +0200
Message-Id: <20050424180955.0C70C33AED@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Rob Landley <rob@landley.net>

Old versions of sed from 1998 (predating the first release of gcc 2.95, but 
still in use by debian stable) don't understand the single-line version of 
the sed append command.  Since newer versions of sed still understand the... 
ahem, "vintage" form of the command, change our code to use that.

Signed-off-by: Rob Landley <rob@landley.net>
Acked-by: Ian McDonald <imcdnzl@gmail.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/Makefile~uml-workaround-sed-behaviour arch/um/kernel/Makefile
--- linux-2.6.12/arch/um/kernel/Makefile~uml-workaround-sed-behaviour	2005-04-24 19:32:15.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/Makefile	2005-04-24 19:32:15.000000000 +0200
@@ -53,6 +53,7 @@ quiet_cmd_quote2 = QUOTE   $@
       cmd_quote2 = sed -e '/CONFIG/{'          \
 		  -e 's/"CONFIG"\;/""/'        \
 		  -e 'r $(obj)/config.tmp'     \
-		  -e 'a""\;'                   \
+		  -e 'a \'                     \
+		  -e '""\;'                    \
 		  -e '}'                       \
 		  $< > $@
_
