Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316156AbSEJWmc>; Fri, 10 May 2002 18:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316153AbSEJWmN>; Fri, 10 May 2002 18:42:13 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:16635 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316154AbSEJWlk>;
	Fri, 10 May 2002 18:41:40 -0400
Date: Fri, 10 May 2002 15:41:39 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir253_long_set_bit.diff
Message-ID: <20020510154139.C14407@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir253_long_set_bit.diff :
-----------------------
	        <Following patch from Paul Mackerras>
	o [CORRECT] Argument of set_bit and friends should be unsigned long
		Should fix all compile warnings ;-)


diff -u -p linux/include/net/irda/irlmp.d8.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d8.h	Fri May  3 18:53:43 2002
+++ linux/include/net/irda/irlmp.h	Fri May  3 18:56:45 2002
@@ -100,7 +100,7 @@ struct lsap_cb {
 	irda_queue_t queue;      /* Must be first */
 	magic_t magic;
 
-	int  connected;
+	unsigned long connected;	/* set_bit used on this */
 	int  persistent;
 
 	__u8 slsap_sel;   /* Source (this) LSAP address */
diff -u -p linux/include/net/irda/irttp.d8.h linux/include/net/irda/irttp.h
--- linux/include/net/irda/irttp.d8.h	Fri May  3 18:54:03 2002
+++ linux/include/net/irda/irttp.h	Fri May  3 18:56:45 2002
@@ -139,7 +139,7 @@ struct tsap_cb {
 	__u32 tx_max_sdu_size; /* Max transmit user data size */
 
 	int close_pend;        /* Close, but disconnect_pend */
-	int disconnect_pend;   /* Disconnect, but still data to send */
+	unsigned long disconnect_pend; /* Disconnect, but still data to send */
 	struct sk_buff *disconnect_skb;
 };
 
diff -u -p linux/net/irda/irnet/irnet.d8.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.d8.h	Fri May  3 18:54:31 2002
+++ linux/net/irda/irnet/irnet.h	Fri May  3 18:56:45 2002
@@ -409,8 +409,8 @@ typedef struct irnet_socket
 
   /* ------------------------ IrTTP part ------------------------ */
   /* We create a pseudo "socket" over the IrDA tranport */
-  int			ttp_open;	/* Set when IrTTP is ready */
-  int			ttp_connect;	/* Set when IrTTP is connecting */
+  unsigned long		ttp_open;	/* Set when IrTTP is ready */
+  unsigned long		ttp_connect;	/* Set when IrTTP is connecting */
   struct tsap_cb *	tsap;		/* IrTTP instance (the connection) */
 
   char			rname[NICKNAME_MAX_LEN + 1];
diff -u -p linux/net/irda/irnet/irnet_ppp.d8.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.d8.c	Fri May  3 18:56:38 2002
+++ linux/net/irda/irnet/irnet_ppp.c	Fri May  3 18:56:45 2002
@@ -860,7 +860,7 @@ ppp_irnet_send(struct ppp_channel *	chan
       irda_irnet_connect(self);
 #endif /* CONNECT_IN_SEND */
 
-      DEBUG(PPP_INFO, "IrTTP not ready ! (%d-%d)\n",
+      DEBUG(PPP_INFO, "IrTTP not ready ! (%ld-%ld)\n",
 	    self->ttp_open, self->ttp_connect);
 
       /* Note : we can either drop the packet or block the packet.
