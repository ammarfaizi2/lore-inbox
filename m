Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTL2OUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 09:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTL2OUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 09:20:44 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.16]:49430 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S263479AbTL2OUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 09:20:42 -0500
Subject: [PATCH] linux-2.6.0/sound/core/misc.c - vsnprintf
From: petter wahlman <petter.wahlman@chello.no>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072707638.927.24.camel@badeip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 15:20:38 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

vsnprintf does not copy more than 'size' bytes _including_ '\0'

-p.


--- linux-2.6.0/sound/core/misc.c       2003-12-18 03:58:38.000000000
+0100
+++ linux-2.6.0-pw/sound/core/misc.c    2003-12-29 14:42:15.000000000
+0100
@@ -51,9 +51,8 @@
                printk("ALSA %s:%d: ", file, line);
        }
        va_start(args, format);
-       vsnprintf(tmpbuf, sizeof(tmpbuf)-1, format, args);
+       vsnprintf(tmpbuf, sizeof(tmpbuf), format, args);
        va_end(args);
-       tmpbuf[sizeof(tmpbuf)-1] = '\0';
        printk(tmpbuf);
 }
 #endif
@@ -73,9 +72,8 @@
                printk(KERN_DEBUG "ALSA %s:%d: ", file, line);
        }
        va_start(args, format);
-       vsnprintf(tmpbuf, sizeof(tmpbuf)-1, format, args);
+       vsnprintf(tmpbuf, sizeof(tmpbuf), format, args);
        va_end(args);
-       tmpbuf[sizeof(tmpbuf)-1] = '\0';
        printk(tmpbuf);

 }


