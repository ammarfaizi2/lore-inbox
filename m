Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUKAMYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUKAMYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 07:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUKAMYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 07:24:19 -0500
Received: from main.gmane.org ([80.91.229.2]:64390 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261766AbUKAMYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 07:24:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: [rc4-amd64] RC4 optimized for AMD64
Date: Mon, 1 Nov 2004 12:24:07 +0000 (UTC)
Message-ID: <cm59t7$pbu$1@sea.gmane.org>
References: <cm4moc$c7t$1@sea.gmane.org> <Xine.LNX.4.44.0411010232470.2694-100000@thoron.boston.redhat.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ivry-1-81-57-179-18.fbx.proxad.net
User-Agent: slrn/0.9.8.0pl1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-11-01, James Morris <jmorris@redhat.com> wrote:
| 
|  Only problem is that the setkey code is released under a GPL incompatible
|  license.  Although it's probably not difficult to make the kernel's
|  existing C setkey code to work with the new asm code.

Yes, it would be very easy to do. This patch (completetly untested)
is probably all that is necessary to make Linux arc4_set_key() work
with rc4-amd64:

--- 8< -----------------------------------------------------------------
--- crypto/arc4.c.orig  2004-11-01 13:16:41.739375512 +0100
+++ crypto/arc4.c       2004-11-01 13:18:16.799924112 +0100
@@ -20,8 +20,8 @@
 #define ARC4_BLOCK_SIZE                1
 
 struct arc4_ctx {
-       u8 S[256];
-       u8 x, y;
+       u64 x, y;
+       u64 S[256];
 };
 
 static int arc4_set_key(void *ctx_arg, const u8 *in_key, unsigned int key_len, u32 *flags)
--- 8< -----------------------------------------------------------------

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.

