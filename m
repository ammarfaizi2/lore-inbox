Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270175AbTHCDHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 23:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270439AbTHCDHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 23:07:39 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:59313 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S270175AbTHCDHi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 23:07:38 -0400
Message-ID: <3F2C7A03.6080204@terra.com.br>
Date: Sat, 02 Aug 2003 23:57:07 -0300
From: Raphael Kubo da Costa <suroii@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvac.org, akpm@osdl.org
Subject: Re: 2.6.0-test2-mm3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's my first patch. ;)
This is a fix for i386's fpu_system.h, which was causing an error during 
the compilation of fpu_entry.c.

--- linux-2.6.0-test2-mm3/arch/i386/math-emu/fpu_system.h	2003-08-02 22:54:44.000000000 -0300
+++ linux-2.6.0-test2-mm3-fix/arch/i386/math-emu/fpu_system.h	2003-08-02 22:53:55.000000000 -0300
@@ -22,7 +22,7 @@
 
 /* s is always from a cpu register, and the cpu does bounds checking
  * during register load --> no further bounds checks needed */
-#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)current->mm->context.ldt)[(s) >> 3])
+#define LDT_DESCRIPTOR(s)	(((struct desc_struct *)current->mm->context.ldt_pages)[(s) >> 3])
 #define SEG_D_SIZE(x)		((x).b & (3 << 21))
 #define SEG_G_BIT(x)		((x).b & (1 << 23))
 #define SEG_GRANULARITY(x)	(((x).b & (1 << 23)) ? 4096 : 1)


