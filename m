Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVIURux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVIURux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbVIURus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:50:48 -0400
Received: from [151.97.230.9] ([151.97.230.9]:22979 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751343AbVIURs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:48:56 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 06/10] uml: run mconsole "sysrq" in process context
Date: Wed, 21 Sep 2005 19:28:57 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921172857.10219.71071.stgit@zion.home.lan>
In-Reply-To: <200509211923.21861.blaisorblade@yahoo.it>
References: <200509211923.21861.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Things are breaking horribly with sysrq called in interrupt context. I want to
try to fix it, but probably this is simpler. To tell the truth, sysrq is
normally run in interrupt context, so there shouldn't be any problem.

There's also a warning from the fault handler because it's run in atomic
context (I have a patch for that, only I deferred it). This is why I'm doing
this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/mconsole_user.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -23,7 +23,7 @@ static struct mconsole_command commands[
 	{ "reboot", mconsole_reboot, MCONSOLE_PROC },
 	{ "config", mconsole_config, MCONSOLE_PROC },
 	{ "remove", mconsole_remove, MCONSOLE_PROC },
-	{ "sysrq", mconsole_sysrq, MCONSOLE_INTR },
+	{ "sysrq", mconsole_sysrq, MCONSOLE_PROC },
 	{ "help", mconsole_help, MCONSOLE_INTR },
 	{ "cad", mconsole_cad, MCONSOLE_INTR },
 	{ "stop", mconsole_stop, MCONSOLE_PROC },

