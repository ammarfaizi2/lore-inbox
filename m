Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVAYUqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVAYUqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVAYUqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:46:08 -0500
Received: from waste.org ([216.27.176.166]:64640 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262135AbVAYUm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:42:28 -0500
Date: Tue, 25 Jan 2005 12:42:19 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] rol32 thinko
Message-ID: <20050125204219.GM12076@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This thinko.. makes things a bit more arbitrary than we'd like. I've
re-audited the other rotate conversions.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rc2mm1/drivers/char/random.c
===================================================================
--- rc2mm1.orig/drivers/char/random.c	2005-01-25 12:26:13.000000000 -0800
+++ rc2mm1/drivers/char/random.c	2005-01-25 12:27:00.000000000 -0800
@@ -474,7 +474,7 @@
 	add_ptr = r->add_ptr;
 
 	while (nwords--) {
-		w = rol32(input_rotate, next_w);
+		w = rol32(next_w, input_rotate);
 		if (nwords > 0)
 			next_w = *in++;
 		i = add_ptr = (add_ptr - 1) & wordmask;

-- 
Mathematics is the supreme nostalgia of our time.
