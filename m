Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVIHT6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVIHT6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVIHT6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:58:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964973AbVIHT6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:58:51 -0400
Date: Thu, 8 Sep 2005 15:56:33 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, adam@yggdrasil.com
Subject: [PATCH] module-init-tools: don't do '-' substitutions in depmod
Message-ID: <20050908195633.GB9884@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
	adam@yggdrasil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch removes the '-' for '_' substitution from
depmod - this makes the names printed for modules in module.alias
match the actual names of the module files.

Bill

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="module-init-tools.patch"

diff -ru depmod.c.old depmod.c
--- depmod.c	2005-04-30 08:38:46.000000000 -0400
+++ depmod.c	2005-09-08 15:52:26.000000000 -0400
@@ -607,13 +607,8 @@
 	else
 		afterslash++;
 
-	/* Convert to underscores, stop at first . */
-	for (i = 0; afterslash[i] && afterslash[i] != '.'; i++) {
-		if (afterslash[i] == '-')
-			modname[i] = '_';
-		else
+	for (i = 0; afterslash[i] && afterslash[i] != '.'; i++)
 			modname[i] = afterslash[i];
-	}
 	modname[i] = '\0';
 }
 

--DocE+STaALJfprDB--
