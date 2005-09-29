Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVI2TeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVI2TeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVI2TdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:33:24 -0400
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]:55197 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S964803AbVI2TdG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:33:06 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 4/5] uml: revert "run mconsole "sysrq" in process context"
Date: Thu, 29 Sep 2005 21:30:53 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20050929193053.14528.77465.stgit@zion.home.lan>
In-Reply-To: <200509292102.44942.blaisorblade@yahoo.it>
References: <200509292102.44942.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Revert commit 12ebcd73e40e09f0dfddf89e465cc0541e0ff8b1, i.e. 
[PATCH] uml: run mconsole "sysrq" in process context
on request from Jeff Dike.

a) sysrq may be run when the scheduler is non-functioning

b) the warning I wanted to fix actually came from the fault handler run in
atomic context. But I fixed that not to take the semaphore in a separate patch.

c) the fault handler is run because of a fault, and that fault was unaffected by
this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>
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
-	{ "sysrq", mconsole_sysrq, MCONSOLE_PROC },
+	{ "sysrq", mconsole_sysrq, MCONSOLE_INTR },
 	{ "help", mconsole_help, MCONSOLE_INTR },
 	{ "cad", mconsole_cad, MCONSOLE_INTR },
 	{ "stop", mconsole_stop, MCONSOLE_PROC },

