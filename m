Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTEYRX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTEYRX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:23:29 -0400
Received: from [212.45.9.156] ([212.45.9.156]:63361 "EHLO null.ru")
	by vger.kernel.org with ESMTP id S263668AbTEYRXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:23:17 -0400
Message-ID: <3ED0FE69.6070503@yahoo.com>
Date: Sun, 25 May 2003 21:33:29 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030312
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] vm86: fix IOPL virtualisation
Content-Type: multipart/mixed;
 boundary="------------060501020503080301010805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060501020503080301010805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

The attached patch implements the following:
http://x86.ddj.com/articles/vme1/vme_overview.htm
---
In addition to moving the VIF to the IF on the stack image, 
PUSHF always pushes an IOPL image of 3 onto the
stack.
---

Many DOS programs, including dos4gw, are
checking if they are in a v86 mode by trying
to alter IOPL. With that patch they are not
get confused under dosemu.
Also the patch fixes what looks like a bug
with an IF flag.

--------------060501020503080301010805
Content-Type: text/plain;
 name="v86_iopl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v86_iopl.diff"

--- linux/arch/i386/kernel/vm86.c	Sun Aug  4 03:44:30 2002
+++ linux/arch/i386/kernel/vm86.c	Sat May 24 19:30:45 2003
@@ -362,6 +362,9 @@
 
 	if (VEFLAGS & VIF_MASK)
 		flags |= IF_MASK;
+	else
+		flags &= ~IF_MASK;
+	flags |= IOPL_MASK;
 	return flags | (VEFLAGS & current->thread.v86mask);
 }
 

--------------060501020503080301010805--

