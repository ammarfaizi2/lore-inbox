Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbUKWX6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbUKWX6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUKWX6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:58:23 -0500
Received: from mail.dif.dk ([193.138.115.101]:2018 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261665AbUKWXzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:55:21 -0500
Date: Wed, 24 Nov 2004 01:04:52 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix weird placement of static keyword in sound/core/pcm_memory.c
Message-ID: <Pine.LNX.4.61.0411240058410.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves the 'static' keyword to the beginning of the declaration 
to eliminate the following warning when building with gcc -W
sound/core/pcm_memory.c:40: warning: `static' is not at beginning of declaration

This has no actal imact on the code, but it's one less warning to sift 
through when looking for potential trouble-code with -W
I have a hard time thinking of a reason to not apply this trivial patch :)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk6-orig/sound/core/pcm_memory.c linux-2.6.10-rc2-bk6/sound/core/pcm_memory.c
--- linux-2.6.10-rc2-bk6-orig/sound/core/pcm_memory.c	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6.10-rc2-bk6/sound/core/pcm_memory.c	2004-11-24 00:57:06.000000000 +0100
@@ -37,7 +37,7 @@ static int maximum_substreams = 4;
 module_param(maximum_substreams, int, 0444);
 MODULE_PARM_DESC(maximum_substreams, "Maximum substreams with preallocated DMA memory.");
 
-const static size_t snd_minimum_buffer = 16384;
+static const size_t snd_minimum_buffer = 16384;
 
 
 /*



