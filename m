Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSHFSPX>; Tue, 6 Aug 2002 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHFSPX>; Tue, 6 Aug 2002 14:15:23 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:54726 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315179AbSHFSPW>;
	Tue, 6 Aug 2002 14:15:22 -0400
Date: Tue, 6 Aug 2002 11:18:59 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Fix dev->trans_start in wavelan
Message-ID: <20020806181859.GG11313@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Marcelo,

	Previous patch was for the Pcmcia driver, this one is for the
ISA driver. This fix an annoying kernel log message, does the right
obvious thing and is very low risk.
	Tested intensively on 2.4.19.

	Regards,

	Jean

-----------------------------------------------------------

diff -u -p linux/drivers/net/wavelan.p.25.h linux/drivers/net/wavelan.p.h
--- linux/drivers/net/wavelan.p.25.h	Mon Aug  5 14:56:35 2002
+++ linux/drivers/net/wavelan.p.h	Mon Aug  5 15:11:59 2002
@@ -345,6 +345,10 @@
  *	- Fix spinlock stupid bugs that I left in. The driver is now SMP
  *		compliant and doesn't lockup at startup.
  *
+ * Changes made for release in 2.4.20 :
+ * ----------------------------------
+ *	- Set dev->trans_start to avoid filling the logs
+ *
  * Wishes & dreams:
  * ----------------
  *	- roaming (see Pcmcia driver)
diff -u -p linux/drivers/net/wavelan.25.c linux/drivers/net/wavelan.c
--- linux/drivers/net/wavelan.25.c	Mon Aug  5 14:56:44 2002
+++ linux/drivers/net/wavelan.c	Mon Aug  5 14:57:36 2002
@@ -2782,6 +2782,9 @@ static inline int wv_packet_write(device
 		    (unsigned char *) &nop.nop_h.ac_link,
 		    sizeof(nop.nop_h.ac_link));
 
+	/* Make sure the watchdog will keep quiet for a while */
+	dev->trans_start = jiffies;
+
 	/* Keep stats up to date. */
 	lp->stats.tx_bytes += length;
 

