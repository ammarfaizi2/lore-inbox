Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVABAHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVABAHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 19:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVABAHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 19:07:40 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:37577 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261187AbVABAHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 19:07:33 -0500
Message-ID: <41D73B43.3080109@drzeus.cx>
Date: Sun, 02 Jan 2005 01:07:31 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-31107-1104624523-0001-2"
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH] Fix MMC warnings
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-31107-1104624523-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's a patch that fixes the compiler warnings in mmc.c.

--=_hades.drzeus.cx-31107-1104624523-0001-2
Content-Type: text/x-patch; name="mmc-warning.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-warning.patch"

Index: linux-wbsd/drivers/mmc/mmc.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc.c	(revision 117)
+++ linux-wbsd/drivers/mmc/mmc.c	(working copy)
@@ -428,14 +428,14 @@
 
 #define UNSTUFF_BITS(resp,start,size)					\
 	({								\
-		const u32 __mask = (1 << (size)) - 1;			\
+		const u32 __mask = ((size >= 32)?0:(1 << (size))) - 1;	\
 		const int __off = 3 - ((start) / 32);			\
 		const int __shft = (start) & 31;			\
 		u32 __res;						\
 									\
 		__res = resp[__off] >> __shft;				\
 		if ((size) + __shft >= 32)				\
-			__res |= resp[__off-1] << (32 - __shft);	\
+			__res |= resp[__off-1] << ((32 - __shft) % 32);	\
 		__res & __mask;						\
 	})
 

--=_hades.drzeus.cx-31107-1104624523-0001-2--
