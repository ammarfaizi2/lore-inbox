Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263282AbVBCOKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbVBCOKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbVBCOKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:10:39 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:56781 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S263282AbVBCOK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:10:29 -0500
Message-ID: <42023EEB.7070600@tiscali.de>
Date: Thu, 03 Feb 2005 16:10:35 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 Patch] speedstep-lib.c: fix frequency multiplier for Pentium4
 models 0&1
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Pentium4 models 0&1 have a longer MSR_EBC_FREQUENCY_ID register as 
the models 2&3, so the bit shift must be bigger.

Signed-off-by: Matthias-Christian Ott <matthias.christian@tiscali.de>

diff -Nurp linux-2.6.11-rc3/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c 
linux-2.6.11-rc3-ott/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c
--- linux-2.6.11-rc3/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c    
2004-12-24 22:35:27.000000000 +0100
+++ linux-2.6.11-rc3-ott/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c    
2005-02-03 16:04:59.000000000 +0100
@@ -160,7 +160,14 @@ static unsigned int pentium4_get_frequen
         printk(KERN_DEBUG "speedstep-lib: couldn't detect FSB speed. 
Please send an e-mail to <linux@brodo.de>\n");
 
     /* Multiplier. */
-    mult = msr_lo >> 24;
+    if (c->x86_model < 2)
+        {
+        mult = msr_lo >> 27;
+        }
+    else
+        {
+        mult = msr_lo >> 24;
+        }
 
     dprintk("P4 - FSB %u kHz; Multiplier %u; Speed %u kHz\n", fsb, 
mult, (fsb * mult));
 

