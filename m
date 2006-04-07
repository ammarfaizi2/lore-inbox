Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWDGOct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWDGOct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWDGOce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:34 -0400
Received: from [151.97.230.9] ([151.97.230.9]:43228 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932348AbWDGOcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 15/17] uml: local_irq_save, not local_save_flags
Date: Fri, 07 Apr 2006 16:31:24 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143124.19201.87107.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The call to local_save_flags seems bogus since it is followed by
local_irq_restore, and it's intended to lock the list from concurrent
mconsole_interrupt invocations.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/mconsole_kern.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index f8c6269..a0e1200 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -62,7 +62,7 @@ static void mc_work_proc(void *unused)
 	unsigned long flags;
 
 	while(!list_empty(&mc_requests)){
-		local_save_flags(flags);
+		local_irq_save(flags);
 		req = list_entry(mc_requests.next, struct mconsole_entry,
 				 list);
 		list_del(&req->list);
