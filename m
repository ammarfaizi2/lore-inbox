Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbUDBRck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 12:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUDBRck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 12:32:40 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:32700 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264125AbUDBRci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 12:32:38 -0500
Date: Fri, 2 Apr 2004 19:32:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove the warning from arch/i386/boot/setup.S
Message-ID: <20040402173242.GC26140@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure how many people tried to fix this before, but it's still in
2.6.4.  And guess what, we depend on undocumented behaviour, so I'd
prefer to make this dependency explicit.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens

The warning is correct, the calculated value for ramdisk_max would be
0xb7ffffff instead of 0x37ffffff.  Truncating 0xb7ffffff to 0x37ffffff
is desired behaviour, so we should do it explicitly.

 setup.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.1/arch/i386/boot/setup.S~initrd_warning	2004-03-09 11:37:29.000000000 +0100
+++ linux-2.6.1/arch/i386/boot/setup.S	2004-03-09 11:38:59.000000000 +0100
@@ -162,7 +162,8 @@
 					# can be located anywhere in
 					# low memory 0x10000 or higher.
 
-ramdisk_max:	.long MAXMEM-1		# (Header version 0x0203 or later)
+ramdisk_max:	.long (MAXMEM-1) & 0x7fffffff
+					# (Header version 0x0203 or later)
 					# The highest safe address for
 					# the contents of an initrd
 
