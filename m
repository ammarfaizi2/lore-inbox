Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVIUQrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVIUQrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVIUQrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 12:47:06 -0400
Received: from [151.97.230.9] ([151.97.230.9]:32654 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751124AbVIUQrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 12:47:02 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 09/10] uml: comment about cast build fix
Date: Wed, 21 Sep 2005 18:40:29 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20050921164028.30500.13294.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Explain why the casting we do to silence this warning is indeed safe.

It is because the field we're casting from, though being 64-bit wide, was filled
with a pointer in first place by ourselves.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/os-Linux/aio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/aio.c b/arch/um/os-Linux/aio.c
--- a/arch/um/os-Linux/aio.c
+++ b/arch/um/os-Linux/aio.c
@@ -144,6 +144,7 @@ static int aio_thread(void *arg)
                                "errno = %d\n", errno);
                 }
                 else {
+			/* This is safe as we've just a pointer here. */
 			aio = (struct aio_context *) (long) event.data;
 			if(update_aio(aio, event.res)){
 				do_aio(ctx, aio);

