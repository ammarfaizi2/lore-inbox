Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269219AbTCBOVJ>; Sun, 2 Mar 2003 09:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269220AbTCBOVJ>; Sun, 2 Mar 2003 09:21:09 -0500
Received: from smtp01.web.de ([217.72.192.180]:18714 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S269219AbTCBOVI>;
	Sun, 2 Mar 2003 09:21:08 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] compiletime-fix in isdn_ppp
Date: Sun, 2 Mar 2003 15:31:33 +0000
User-Agent: KMail/1.5
Cc: kai@germaschewski.name
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303021531.33678.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Without this patch linux-2.5.63 vanilla didn't compile.
I don't know, if I have introduced a problem with this patch, but for me it 
compiles now. :)

bye, Michael Buesch.



diff -urN -X /home/mb/dontdiff 
linux-2.5.63-vanilla/drivers/isdn/i4l/isdn_ppp.c 
linux-2.5.63/drivers/isdn/i4l/isdn_ppp.c
--- linux-2.5.63-vanilla/drivers/isdn/i4l/isdn_ppp.c	2002-12-16 
02:08:12.000000000 +0000
+++ linux-2.5.63/drivers/isdn/i4l/isdn_ppp.c	2003-03-02 14:23:48.000000000 
+0000
@@ -1037,7 +1037,7 @@
                 isdn_ppp_frame_log("xmit1", skb->data, skb->len, 32, 
ipppd->unit, -1);
 
 	ippp_push_proto(ind_ppp, skb, proto);
-	ippp_mp_xmit(idev, skb, proto);
+	ippp_mp_xmit(idev, skb);
 	return 0;
 
  drop:
diff -urN -X /home/mb/dontdiff 
linux-2.5.63-vanilla/drivers/isdn/i4l/isdn_ppp_mp.h 
linux-2.5.63/drivers/isdn/i4l/isdn_ppp_mp.h
--- linux-2.5.63-vanilla/drivers/isdn/i4l/isdn_ppp_mp.h	2002-12-16 
02:08:24.000000000 +0000
+++ linux-2.5.63/drivers/isdn/i4l/isdn_ppp_mp.h	2003-03-02 14:23:58.000000000 
+0000
@@ -42,9 +42,9 @@
 }
 
 static inline void
-ippp_mp_xmit(isdn_net_dev *idev, struct sk_buff *skb, u16 proto)
+ippp_mp_xmit(isdn_net_dev *idev, struct sk_buff *skb)
 {
-	ippp_xmit(idev, skb, proto);
+	ippp_xmit(idev, skb);
 }
 
 static inline void 

