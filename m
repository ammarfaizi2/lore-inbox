Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbTHVHcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 03:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTHVHbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 03:31:46 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:24593 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263042AbTHVHFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 03:05:14 -0400
Date: Fri, 22 Aug 2003 04:04:31 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH][resend] 4/13 2.4.22-rc2 fix __FUNCTION__ warnings
 drivers/media/video
Message-Id: <20030822040431.4a958f05.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,
this patch fix the warning: concatenation of string literals with __FUNCTION__ is deprecated

 cpia.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.4.22-rc2/drivers/media/video/cpia.h	2003-06-13 11:51:34.000000000 -0300
+++ linux-2.4.22-rc2-fix/drivers/media/video/cpia.h	2003-08-21 00:08:28.000000000 -0300
@@ -393,12 +393,12 @@
 /* ErrorCode */
 #define ERROR_FLICKER_BELOW_MIN_EXP     0x01 /*flicker exposure got below minimum exposure */
 
-#define ALOG(lineno,fmt,args...) printk(fmt,lineno,##args)
-#define LOG(fmt,args...) ALOG((__LINE__),KERN_INFO __FILE__":"__FUNCTION__"(%d):"fmt,##args)
+#define ALOG(fmt,args...) printk(fmt, ##args)
+#define LOG(fmt,args...) ALOG(KERN_INFO __FILE__ ":%s(%d):" fmt, __FUNCTION__ , __LINE__ , ##args)
 
 #ifdef _CPIA_DEBUG_
-#define ADBG(lineno,fmt,args...) printk(fmt, jiffies, lineno, ##args)
-#define DBG(fmt,args...) ADBG((__LINE__),KERN_DEBUG __FILE__"(%ld):"__FUNCTION__"(%d):"fmt,##args)
+#define ADBG(fmt,args...) printk(fmt, jiffies, ##args)
+#define DBG(fmt,args...) ADBG(KERN_DEBUG __FILE__" (%ld):%s(%d):" fmt, __FUNCTION__, __LINE__ , ##args)
 #else
 #define DBG(fmn,args...) do {} while(0)
 #endif

ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
