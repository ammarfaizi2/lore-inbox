Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbUKBXsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUKBXsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUKBXsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:48:20 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:34181
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S261258AbUKBXmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:42:53 -0500
Subject: [patch 1/2] Kbuild: avoid backup localversion files
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it, sam@ravnborg.org
From: blaisorblade_spam@yahoo.it
Date: Wed, 03 Nov 2004 00:19:57 +0100
Message-Id: <20041102231958.94C7E4C07D@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Sam Ravnborg <sam@ravnborg.org>

(Please CC me on replies as I'm not subscribed).

Avoid including as localversion-files the *~ files, i.e. backup files. If I
have localversion-a and localversion-a~, I don't want both to be used. Nor I
want to use localversion*~ anyway.

Don't code that as $(wildcard localversion*[^~]) as that would exclude
"localversion" from the wildcard expansion result, because it requires at
least one character after localversion to exist in the name file. I.e., 

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN Makefile~avoid-backup-localversion Makefile
--- vanilla-linux-2.6.9/Makefile~avoid-backup-localversion	2004-11-03 00:16:50.651772000 +0100
+++ vanilla-linux-2.6.9-paolo/Makefile	2004-11-03 00:16:50.654771544 +0100
@@ -156,7 +156,7 @@ localversion-files := $(wildcard $(objtr
 endif
 
 LOCALVERSION = $(subst $(space),, \
-	       $(shell cat /dev/null $(localversion-files)) \
+	       $(shell cat /dev/null $(localversion-files:%~=)) \
 	       $(patsubst "%",%,$(CONFIG_LOCALVERSION)))
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCALVERSION)
_
