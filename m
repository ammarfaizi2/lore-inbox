Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbTH3FTl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 01:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTH3FTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 01:19:41 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:15451 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261455AbTH3FTj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 01:19:39 -0400
Date: Sat, 30 Aug 2003 02:17:42 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22-ac1 fix drivers/isdn/hisax/st5481.h
Message-Id: <20030830021742.7695a507.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This patch removes old printk´s and the #if from these that not is necessary,
and it leaves the correct ones (that is in your patch).

This way it is as if one patched the 2.4.22 with the patch that I sent days ago
to the LKML and as it is in the 2.6.

With this, kernel compiles of clean way without deprecated warnings. (all!)

Please apply it.

PS: Good Luck in its studies!

chau,
 djgera


--- linux-2.4.22-ac1/drivers/isdn/hisax/st5481.h	2003-08-29 21:24:28.000000000 -0300
+++ linux-2.4.22-ac1-fix/drivers/isdn/hisax/st5481.h	2003-08-30 01:24:27.000000000 -0300
@@ -218,19 +218,6 @@
 
 #define L1_EVENT_COUNT (EV_TIMER3 + 1)
 
-#if (__GNUC__ > 2)
-
-#define ERR(format, arg...) \
-printk(KERN_ERR __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
-
-#define WARN(format, arg...) \
-printk(KERN_WARNING __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
-
-#define INFO(format, arg...) \
-printk(KERN_INFO __FILE__ ": " __FUNCTION__ ": " format "\n" , ## arg)
-
-#else
-
 #define ERR(format, arg...) \
 printk(KERN_ERR __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
@@ -240,8 +227,6 @@
 #define INFO(format, arg...) \
 printk(KERN_INFO __FILE__ ": %s: " format "\n" , __FUNCTION__ , ## arg)
 
-#endif
-
 #include "isdnhdlc.h"
 #include "fsm.h"
 #include "hisax_if.h"


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
