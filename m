Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTBXN3A>; Mon, 24 Feb 2003 08:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTBXN3A>; Mon, 24 Feb 2003 08:29:00 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:59276 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267081AbTBXN27>; Mon, 24 Feb 2003 08:28:59 -0500
Message-Id: <200302241338.h1ODcwGi028650@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] get skb->len right after adjusting head 
In-reply-to: Your message of "Sun, 23 Feb 2003 21:45:13 PST."
             <20030223.214513.120185268.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 24 Feb 2003 08:38:58 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030223.214513.120185268.davem@redhat.com>,"David S. Miller" writes:
>Don't try to modify skb->{data,len} by hands, let the skb_*()
>interfaces do it.  Use skb_pull() in this case.

missed that function when i went looking for it.  again, the right way:

Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.1
retrieving revision 1.7
diff -u -d -b -w -r1.1 -r1.7
--- linux/net/atm/lec.c	20 Feb 2003 13:46:30 -0000	1.1
+++ linux/net/atm/lec.c	24 Feb 2003 13:34:43 -0000	1.7
@@ -711,7 +705,7 @@
                         lec_arp_check_empties(priv, vcc, skb);
                 }
                 skb->dev = dev;
-                skb->data += 2; /* skip lec_id */
+                skb_pull(skb, 2); /* skip lec_id */
 #ifdef CONFIG_TR
                 if (priv->is_trdev) skb->protocol = tr_type_trans(skb, dev);
                 else
