Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUDMSL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 14:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbUDMSL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 14:11:59 -0400
Received: from krl.krl.com ([192.147.32.3]:37514 "EHLO krl.krl.com")
	by vger.kernel.org with ESMTP id S263666AbUDMSLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 14:11:52 -0400
Message-Id: <200404131811.i3DIBkv8012367@p-chan.krl.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: John Cherry <cherry@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.5 - 2004-04-12.22.30) - 2 New warnings (gcc 3.2.2) 
In-Reply-To: Message from John Cherry <cherry@osdl.org> 
   of "Tue, 13 Apr 2004 07:31:38 PDT." <200404131431.i3DEVcCg010071@cherrypit.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Apr 2004 14:11:46 -0400
From: Don Koch <aardvark@krl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/video/fbmem.c:914: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type

The following patch fixes the warning - the "data" field is "const"
for apparently varying definitions of the word "const" ;-).

===== fbmem.c 1.95 vs edited =====
--- 1.94/drivers/video/fbmem.c	Thu Mar 25 12:57:01 2004
+++ edited/fbmem.c	Tue Apr 13 13:17:56 2004
@@ -911,7 +911,7 @@
 			return -ENOMEM;
 		}
 		
-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user((char *)cursor.image.data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) { 
 			kfree(cursor.image.data);
 			kfree(cursor.mask);


