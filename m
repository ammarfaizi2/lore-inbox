Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266241AbUGAT12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUGAT12 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUGAT12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:27:28 -0400
Received: from mail.aknet.ru ([217.67.122.194]:19721 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S266242AbUGAT1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:27:09 -0400
Message-ID: <40E4659B.5050003@aknet.ru>
Date: Thu, 01 Jul 2004 23:27:23 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] vm86: set IOPL to 3 on pushf
Content-Type: multipart/mixed;
 boundary="------------040200020202080007070707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------040200020202080007070707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi.

The attached patch fixes the pushf under v86
to always set the IOPL field to 3, as the
Intel CPUs do.
It was in 2.4 for year, but somehow missed
2.6. It comes from here (although now a bit
shorter):
http://lkml.org/lkml/2003/5/25/81

Andrew, could you please apply this to 2.6?


--------------040200020202080007070707
Content-Type: text/x-patch;
 name="vm86.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm86.c.diff"


--- linux/arch/i386/kernel/vm86.c.orig	2004-06-26 15:23:51.000000000 +0400
+++ linux/arch/i386/kernel/vm86.c	2004-07-01 21:57:36.687819904 +0400
@@ -394,6 +394,7 @@
 
 	if (VEFLAGS & VIF_MASK)
 		flags |= IF_MASK;
+	flags |= IOPL_MASK;
 	return flags | (VEFLAGS & current->thread.v86mask);
 }
 

--------------040200020202080007070707
Content-Type: text/plain


Scanned by evaluation version of Dr.Web antivirus Daemon 
http://drweb.ru/unix/


--------------040200020202080007070707--
