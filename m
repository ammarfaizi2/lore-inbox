Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbTDCMOc>; Thu, 3 Apr 2003 07:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263363AbTDCMOc>; Thu, 3 Apr 2003 07:14:32 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:11188 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S263359AbTDCMOb>; Thu, 3 Apr 2003 07:14:31 -0500
Message-Id: <200304031224.h33CO3Gi016160@locutus.cmf.nrl.navy.mil>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: 2.5.66-mm3: drivers/atm/iphase.c doesn't compile 
In-reply-to: Your message of "Thu, 03 Apr 2003 14:14:22 +0200."
             <20030403121422.GJ3693@fs.tum.de> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 03 Apr 2003 07:24:03 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030403121422.GJ3693@fs.tum.de>,Adrian Bunk writes:
>drivers/atm/iphase.c:2979: `pad' undeclared (first use in this function)
>drivers/atm/iphase.c:2979: (Each undeclared identifier is reported only once
>drivers/atm/iphase.c:2979: for each function it appears in.)

i missed this one since i normally dont compile the iphase with debugging.
apply the following please to the 2.4 and 2.5 tree:


Index: linux/drivers/atm/iphase.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/iphase.c,v
retrieving revision 1.2
diff -u -r1.2 iphase.c
--- linux/drivers/atm/iphase.c	26 Mar 2003 17:28:02 -0000	1.2
+++ linux/drivers/atm/iphase.c	3 Apr 2003 12:20:15 -0000
@@ -2976,7 +2970,7 @@
            make it  aligned on a 48 byte boundary.  */
 	total_len = skb->len + sizeof(struct cpcs_trailer);  
 	total_len = ((total_len + 47) / 48) * 48;
-	IF_TX(printk("ia packet len:%d padding:%d\n", total_len, pad);)  
+	IF_TX(printk("ia packet len:%d padding:%d\n", total_len, total_len - skb->len);)  
  
 	/* Put the packet in a tx buffer */   
 	trailer = iadev->tx_buf[desc-1].cpcs;
