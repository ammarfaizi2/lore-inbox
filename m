Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVAVNs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVAVNs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 08:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVAVNs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 08:48:56 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:44734 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262717AbVAVNsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 08:48:54 -0500
Message-ID: <41F259C4.9020903@tiscali.de>
Date: Sat, 22 Jan 2005 14:48:52 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Dave Jones <davej@codemonkey.org.uk>, cpufreq@lists.linux.org.uk,
       "H. Peter Anvin" <hpa@zytor.com>, Dominik Brodowski <linux@brodo.de>,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH]: speedstep-lib: fix frequency multiplier for Pentium4 models
 0&1
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Pentium4 models 0&1 have a longer MSR_EBC_FREQUENCY_ID register as 
the models 2&3, so the bit shift must be bigger.

Signed-off-by: Matthias-Christian Ott <matthias.christian@tiscali.de>

--- linux-bk/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c.orig    
2005-01-21 13:55:37.000000000 +0100
+++ linux-bk/arch/i386/kernel/cpu/cpufreq/speedstep-lib.c    2005-01-22 
10:58:34.000000000 +0100
@@ -160,7 +160,14 @@
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
 


