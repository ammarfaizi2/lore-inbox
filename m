Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJAOv6>; Mon, 1 Oct 2001 10:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJAOvs>; Mon, 1 Oct 2001 10:51:48 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:58119 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S275097AbRJAOvb>; Mon, 1 Oct 2001 10:51:31 -0400
Message-ID: <3BB88246.ED5F3072@osdlab.org>
Date: Mon, 01 Oct 2001 07:48:38 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] netconsole-C2 skb checking
Content-Type: multipart/mixed;
 boundary="------------7B7AE9D1A269F75357D761DC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7B7AE9D1A269F75357D761DC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Ingo,

This small patch handles skb allocation a bit
more cleanly.

I didn't see that anyone else had already seen this.
Please apply/use.

~Randy
--------------7B7AE9D1A269F75357D761DC
Content-Type: text/plain; charset=us-ascii;
 name="netcon-skb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netcon-skb.patch"

--- linux/drivers/net/netconsole.c.org	Fri Sep 28 17:46:24 2001
+++ linux/drivers/net/netconsole.c	Mon Oct  1 07:43:31 2001
@@ -96,10 +96,11 @@
 
 	spin_lock_irqsave(&netconsole_lock, flags);
 	skb = netconsole_skbs;
-	if (skb)
+	if (skb) {
 		netconsole_skbs = skb->next;
-	skb->next = NULL;
-	nr_netconsole_skbs--;
+		skb->next = NULL;
+		nr_netconsole_skbs--;
+	}
 	spin_unlock_irqrestore(&netconsole_lock, flags);
 
 	return skb;

--------------7B7AE9D1A269F75357D761DC--

