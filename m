Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVCVT3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVCVT3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVCVT3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:29:31 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:59660 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261702AbVCVT21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:28:27 -0500
Date: Tue, 22 Mar 2005 19:28:17 +0000 (GMT)
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
To: linux-kernel@vger.kernel.org
cc: kernelnewbies@nl.linux.org
Subject: [QUESTION] omit adler32 in zlib
Message-ID: <Pine.LNX.4.58.0503221926470.5876@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dedekind@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

zlib deflate generates an adler32 checksum for the input uncompressed 
data. In order to gain some drop of performance we would like not to 
generate/check adler32 because we anyway protect our data by much stronger 
CRC32.

How to correctly do that?

My quick investigation has shown that it is possible if I pass the a 
negative windowBits parameter to the deflateInit2() function to achieve 
the goal. But this feature isn't noted in the deflate API description 
(include/linux/zlib.h) and is called "undocumented feature" in 
lib/zlib_deflate/deflate.c.

So the question is: is it OK to use this undocumented feature? What are 
alternatives?

I also noted that if I use  deflate via crypto API, I'll get what I want 
since it does:

#define DEFLATE_DEF_WINBITS             11
ret = zlib_deflateInit2(stream,
	DEFLATE_DEF_LEVEL,
	Z_DEFLATED,
	-DEFLATE_DEF_WINBITS,
	DEFLATE_DEF_MEMLEVEL,
	Z_DEFAULT_STRATEGY);

(note the "minus" character before DEFLATE_DEF_WINBITS)

I'm curious why crypto API omits adler32 by default?

Thanks.

--
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
