Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUIARRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUIARRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUIAP4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:56:02 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:64946 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267334AbUIAPvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:46 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMPw000660@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove pointless check in zlib
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We dereference 'z' a few lines above this check.
If it was possible to hit this condition, it wouldve
triggered long ago, in the form of a crash.

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/lib/zlib_inflate/inflate.c linux-2.6/lib/zlib_inflate/inflate.c
--- bk-linus/lib/zlib_inflate/inflate.c	2004-06-03 13:40:26.000000000 +0100
+++ linux-2.6/lib/zlib_inflate/inflate.c	2004-06-03 13:42:54.000000000 +0100
@@ -53,8 +53,6 @@ int zlib_inflateInit2_(
       return Z_VERSION_ERROR;
 
   /* initialize state */
-  if (z == NULL)
-    return Z_STREAM_ERROR;
   z->msg = NULL;
   z->state = &WS(z)->internal_state;
   z->state->blocks = NULL;
