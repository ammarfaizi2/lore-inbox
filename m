Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288662AbSAYAWy>; Thu, 24 Jan 2002 19:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290463AbSAYAWp>; Thu, 24 Jan 2002 19:22:45 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:4351 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288662AbSAYAWf>;
	Thu, 24 Jan 2002 19:22:35 -0500
Date: Thu, 24 Jan 2002 16:22:33 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trigraph warning cleanup for wavelan_cs in 2.5.3-pre5
Message-ID: <20020124162233.C12682@bougret.hpl.hp.com>
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

	Hi Linus,

	This is a trivial patch that fixes some trigraph warning and
was a leftover of the driver backport. I think adding that to your
tree would please Jeff.

	By the way : I've checked all the Config.help entries for
Wireless LANs and IrDA, and they seem to be in the right place (at
least, for "make config" only).

	Regards,

	Jean

------------------------------------------------------------

diff -u -p -r linux/drivers/net/wireless.v23/wavelan_cs.c linux/drivers/net/wireless/wavelan_cs.c
--- linux/drivers/net/wireless.v23/wavelan_cs.c	Thu Jan 17 10:48:59 2002
+++ linux/drivers/net/wireless/wavelan_cs.c	Fri Jan 18 10:36:22 2002
@@ -797,7 +797,7 @@ static inline void wl_roam_gather(device
   wavepoint_history *wavepoint=NULL;                /* WavePoint table entry */
   net_local *lp=(net_local *)dev->priv;              /* Device info */
 
-#if 0
+#ifdef I_NEED_THIS_FEATURE
   /* Some people don't need this, some other may need it */
   nwid=nwid^ntohs(beacon->domain_id);
 #endif
@@ -1417,7 +1417,7 @@ wv_init_info(device *	dev)
 	  printk("2430.5");
 	  break;
 	default:
-	  printk("???");
+	  printk("unknown");
 	}
     }
 
@@ -1732,7 +1732,7 @@ wv_set_frequency(u_long		base,	/* i/o po
 	 memcmp(dac, dac_verify, 2 * 2))
 	{
 #ifdef DEBUG_IOCTL_ERROR
-	  printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (??)\n");
+	  printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (?)\n");
 #endif
 	  return -EOPNOTSUPP;
 	}
@@ -1981,7 +1981,7 @@ wavelan_ioctl(struct net_device *	dev,	/
 
     case SIOCGIWFREQ:
       /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
-       * (does it work for everybody ??? - especially old cards...) */
+       * (does it work for everybody ? - especially old cards...) */
       if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
 	   (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
 	{
@@ -3163,7 +3163,7 @@ wv_mmc_init(device *	dev)
    */
 
   /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
-   * (does it work for everybody ??? - especially old cards...) */
+   * (does it work for everybody ? - especially old cards...) */
   /* Note : WFREQSEL verify that it is able to read from EEprom
    * a sensible frequency (address 0x00) + that MMR_FEE_STATUS_ID
    * is 0xA (Xilinx version) or 0xB (Ariadne version).
@@ -4718,7 +4718,7 @@ wavelan_event(event_t		event,		/* The ev
 	 * obliged to close nicely the wavelan here. David, could you
 	 * close the device before suspending them ? And, by the way,
 	 * could you, on resume, add a "route add -net ..." after the
-	 * ifconfig up ??? Thanks... */
+	 * ifconfig up ? Thanks... */
 
 	/* Stop receiving new messages and wait end of transmission */
 	wv_ru_stop(dev);
@@ -4745,7 +4745,7 @@ wavelan_event(event_t		event,		/* The ev
 	if(link->state & DEV_CONFIG)
 	  {
       	    CardServices(RequestConfiguration, link->handle, &link->conf);
-      	    if(link->open)	/* If RESET -> True, If RESUME -> False ??? */
+      	    if(link->open)	/* If RESET -> True, If RESUME -> False ? */
 	      {
 		wv_hw_reset(dev);
 		netif_device_attach(dev);
