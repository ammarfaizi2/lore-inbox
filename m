Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSBZXuu>; Tue, 26 Feb 2002 18:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSBZXud>; Tue, 26 Feb 2002 18:50:33 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:40842 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S289484AbSBZXtF>; Tue, 26 Feb 2002 18:49:05 -0500
Date: Tue, 26 Feb 2002 23:52:25 +0000
From: Dave Jones <davej@suse.de>
To: Marcelo Tossati <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4 bluesmoke fixes.
Message-ID: <20020226235225.A27562@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Marcelo Tossati <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems every time I look at this file I spot something else wrong.
First bug is a simple ordering problem.
Second bug already got fixed once recently, and somehow got lost.

Weird. Applies to 2.4.18, and any derivative thereof.


diff -urN --exclude-from=/home/davej/.exclude linux-2.4.18-ac2/arch/i386/kernel/bluesmoke.c linux-2.4.18-ac2-dj/arch/i386/kernel/bluesmoke.c
--- linux-2.4.18-ac2/arch/i386/kernel/bluesmoke.c	Tue Feb 26 23:44:17 2002
+++ linux-2.4.18-ac2-dj/arch/i386/kernel/bluesmoke.c	Tue Feb 26 23:49:15 2002
@@ -41,13 +41,12 @@
 			if(high&(1<<27))
 			{
 				rdmsr(MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk("[%08x%08x]", alow, ahigh);
+				printk("[%08x%08x]", ahigh, alow);
 			}
 			if(high&(1<<26))
 			{
 				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk(" at %08x%08x", 
-					high, low);
+				printk(" at %08x%08x", ahigh, alow);
 			}
 			printk("\n");
 			/* Clear it */

-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
