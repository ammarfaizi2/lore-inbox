Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVAYG5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVAYG5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVAYG5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:57:51 -0500
Received: from witte.sonytel.be ([80.88.33.193]:54753 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261841AbVAYG5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:57:49 -0500
Date: Tue, 25 Jan 2005 07:57:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: pluto@pld-linux.org
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] m68k csum_partial_copy_* (was: Re: [PATCH] csum_and_copy_from_user
 gcc4 warning fixes)
In-Reply-To: <200501160029.j0G0TIin007461@hera.kernel.org>
Message-ID: <Pine.GSO.4.61.0501250756270.12001@waterleaf.sonytel.be>
References: <200501160029.j0G0TIin007461@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2005, Linux Kernel Mailing List wrote:
> ChangeSet 1.2408, 2005/01/15 15:33:46-08:00, pluto@pld-linux.org
> 
> 	[PATCH] csum_and_copy_from_user gcc4 warning fixes
> 	
> 	This patch kills tons of gcc4 warnings:

You forgot to update include/asm-m68k/checksum.h. Here's a fix:

--- linux-2.6.11-rc2/include/asm-m68k/checksum.h	2004-05-24 11:13:52.000000000 +0200
+++ linux-m68k-2.6.11-rc2/include/asm-m68k/checksum.h	2005-01-24 14:58:28.000000000 +0100
@@ -25,11 +25,14 @@ unsigned int csum_partial(const unsigned
  * better 64-bit) boundary
  */
 
-extern unsigned int csum_partial_copy_from_user(const char *src, char *dst,
-						int len, int sum, int *csum_err);
-
-extern unsigned int csum_partial_copy_nocheck(const char *src, char *dst,
-					      int len, int sum);
+extern unsigned int csum_partial_copy_from_user(const unsigned char *src,
+						unsigned char *dst,
+						int len, int sum,
+						int *csum_err);
+
+extern unsigned int csum_partial_copy_nocheck(const unsigned char *src,
+					      unsigned char *dst, int len,
+					      int sum);
 
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
