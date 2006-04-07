Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWDGOgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWDGOgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDGOc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:26 -0400
Received: from [151.97.230.9] ([151.97.230.9]:32476 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932343AbWDGOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:23 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 11/17] uml: move outside spinlock call not needing it
Date: Fri, 07 Apr 2006 16:31:15 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143115.19201.62648.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Move a call to kfree on a local variable out of a spinlock - there's no need to
have it in. Done on a just merged patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/sigio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9ba9429..00e9388 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -304,8 +304,8 @@ out_clear_poll:
 					   .size	= 0,
 					   .used	= 0 });
 out_free:
-	kfree(p);
 	sigio_unlock();
+	kfree(p);
 out_close2:
 	close(l_sigio_private[0]);
 	close(l_sigio_private[1]);
