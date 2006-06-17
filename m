Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWFQS1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWFQS1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFQS1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:27:06 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:11110 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750772AbWFQS1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:27:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QihLzDEZfdxAO8bni3Vd5FZN0JPwfzs2cHX2PZVrmu86+5dF9v76Dnwxi7Eyxm8mCt5iFUtA5UVVdVzyKMGgNjN6wGJmKlC72f5HLnbc/uBIMeObrpRAa4xF+eRZhD+DI1AOYGBZiszs5TSkAdCQBn/WAOB3ztOyu9OmzII/gHA=
Message-ID: <44944976.80400@gmail.com>
Date: Sat, 17 Jun 2006 12:27:02 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 05/20] chardev: GPIO for SCx200 & PC-8736x: put gpio_dump
 on a diet
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5/20. patch.dump-diet

Shrink scx200_gpio_dump() to a single printk with ternary ops.  The
function is still ifdef'd out, this is corrected in next patch, when
it is actually used.

The patch 'inadvertently' changed loglevel from DEBUG to INFO.  This
is Good, because in next patch, its wired to a 'command' which the
user can invoke when they want.  When they do so, its because they
want INFO to support their developement effort, and we want to give it
to them without compiling a DEBUG version of the driver.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.dump-diet
 scx200.c |   39 +++++++++++----------------------------
 1 files changed, 11 insertions(+), 28 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-4/arch/i386/kernel/scx200.c ax-5/arch/i386/kernel/scx200.c
--- ax-4/arch/i386/kernel/scx200.c	2006-06-17 01:07:24.000000000 -0600
+++ ax-5/arch/i386/kernel/scx200.c	2006-06-17 01:10:02.000000000 -0600
@@ -108,34 +108,17 @@ u32 scx200_gpio_configure(unsigned index
 #if 0
 void scx200_gpio_dump(unsigned index)
 {
-	u32 config = scx200_gpio_configure(index, ~0, 0);
-	printk(KERN_DEBUG "GPIO%02u: 0x%08lx", index, (unsigned long)config);
-	
-	if (config & 1) 
-		printk(" OE"); /* output enabled */
-	else
-		printk(" TS"); /* tristate */
-	if (config & 2) 
-		printk(" PP"); /* push pull */
-	else
-		printk(" OD"); /* open drain */
-	if (config & 4) 
-		printk(" PUE"); /* pull up enabled */
-	else
-		printk(" PUD"); /* pull up disabled */
-	if (config & 8) 
-		printk(" LOCKED"); /* locked */
-	if (config & 16) 
-		printk(" LEVEL"); /* level input */
-	else
-		printk(" EDGE"); /* edge input */
-	if (config & 32) 
-		printk(" HI"); /* trigger on rising edge */
-	else
-		printk(" LO"); /* trigger on falling edge */
-	if (config & 64) 
-		printk(" DEBOUNCE"); /* debounce */
-	printk("\n");
+        u32 config = scx200_gpio_configure(index, ~0, 0);
+
+        printk(KERN_INFO NAME ": GPIO-%02u: 0x%08lx %s %s %s %s %s %s %s\n",
+               index, (unsigned long) config,
+               (config & 1) ? "OE"      : "TS",		/* output enabled / tristate */
+               (config & 2) ? "PP"      : "OD",		/* push pull / open drain */
+               (config & 4) ? "PUE"     : "PUD",	/* pull up enabled/disabled */
+               (config & 8) ? "LOCKED"  : "",		/* locked / unlocked */
+               (config & 16) ? "LEVEL"  : "EDGE",	/* level/edge input */
+               (config & 32) ? "HI"     : "LO",		/* trigger on rising/falling edge */ 
+               (config & 64) ? "DEBOUNCE" : "");	/* debounce */
 }
 #endif  /*  0  */
 


