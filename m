Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUCGFos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 00:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUCGFor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 00:44:47 -0500
Received: from CPE-203-51-28-65.nsw.bigpond.net.au ([203.51.28.65]:35826 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261757AbUCGFop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 00:44:45 -0500
Message-ID: <404AB6C7.7010803@eyal.emu.id.au>
Date: Sun, 07 Mar 2004 16:44:39 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre2
References: <Pine.LNX.4.44.0403061618420.4428-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0403061618420.4428-100000@dmt.cyclades>
Content-Type: multipart/mixed;
 boundary="------------080000090101030200040809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080000090101030200040809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes -pre2 -- it contains networking updates, network drivers 
> updates, an XFS update, amongst others.
 >
> <jon:focalhost.com>:
>   o [CRYPTO]: Add ARC4 module

In standard C we declare all variables at the top of a function. While
some compilers allow extension, it is not a good idea to get used to
them if we want portable code.

If fails for me on Debian/stable.

Attached is a trivial patch for crypto/arc4.c.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>

--------------080000090101030200040809
Content-Type: text/plain;
 name="2.4.26-pre2-arc4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.26-pre2-arc4.patch"

--- linux/crypto/arc4.c.orig	Sun Mar  7 16:33:11 2004
+++ linux/crypto/arc4.c	Sun Mar  7 16:35:12 2004
@@ -55,14 +55,14 @@
 static void arc4_crypt(void *ctx_arg, u8 *out, const u8 *in)
 {
 	struct arc4_ctx *ctx = ctx_arg;
+	u8 *const S, x, y, a, b;
 
-	u8 *const S = ctx->S;
-	u8 x = ctx->x;
-	u8 y = ctx->y;
-
-	u8 a = S[x];
+	S = ctx->S;
+	x = ctx->x;
+	y = ctx->y;
+	a = S[x];
 	y = (y + a) & 0xff;
-	u8 b = S[y];
+	b = S[y];
 	S[x] = b;
 	S[y] = a;
 	x = (x + 1) & 0xff;

--------------080000090101030200040809--
