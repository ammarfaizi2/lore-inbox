Return-Path: <linux-kernel-owner+w=401wt.eu-S1751382AbXAFNRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbXAFNRZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbXAFNRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:17:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:27654 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbXAFNRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:17:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=dA0nu0CMhhfl8dWMOA5h6oVzyi2ySmpIzlhCoh6bUkh8CfhVI85DctatmqaD9fC1GroUZXBiyCips75Kqs19vNa0i4dBhPjVY6WyThDQ7YwvpDeSS/oZBPSGWRJdRaX7YNuIFdmML7GGLoV2IjPA9o0f8mCou/Yc30ahny28gdA=
Date: Sat, 6 Jan 2007 15:16:59 +0200
To: Scott_Kilau@digi.com, mansarov@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] JSM_TTY: kmalloc->kzalloc/Casting cleanups
Message-ID: <20070106131659.GA19020@Ahmed>
Mail-Followup-To: Scott_Kilau@digi.com, mansarov@us.ibm.com,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please inform me if you are(n't) the maintaner, I'm not sure.]

Hi all, 
A small patch to transform kmalloc to kzalloc and removing their unneeded 
casts

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/serial/jsm/jsm_tty.c b/drivers/serial/jsm/jsm_tty.c
index 7cf1c60..be22bbd 100644
--- a/drivers/serial/jsm/jsm_tty.c
+++ b/drivers/serial/jsm/jsm_tty.c
@@ -194,31 +194,28 @@ static int jsm_tty_open(struct uart_port *port)
 	/* Drop locks, as malloc with GFP_KERNEL can sleep */
 
 	if (!channel->ch_rqueue) {
-		channel->ch_rqueue = (u8 *) kmalloc(RQUEUESIZE, GFP_KERNEL);
+		channel->ch_rqueue = kzalloc(RQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_rqueue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate read queue buf");
 			return -ENOMEM;
 		}
-		memset(channel->ch_rqueue, 0, RQUEUESIZE);
 	}
 	if (!channel->ch_equeue) {
-		channel->ch_equeue = (u8 *) kmalloc(EQUEUESIZE, GFP_KERNEL);
+		channel->ch_equeue = kzalloc(EQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_equeue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate error queue buf");
 			return -ENOMEM;
 		}
-		memset(channel->ch_equeue, 0, EQUEUESIZE);
 	}
 	if (!channel->ch_wqueue) {
-		channel->ch_wqueue = (u8 *) kmalloc(WQUEUESIZE, GFP_KERNEL);
+		channel->ch_wqueue = kzalloc(WQUEUESIZE, GFP_KERNEL);
 		if (!channel->ch_wqueue) {
 			jsm_printk(INIT, ERR, &channel->ch_bd->pci_dev,
 				"unable to allocate write queue buf");
 			return -ENOMEM;
 		}
-		memset(channel->ch_wqueue, 0, WQUEUESIZE);
 	}
 
 	channel->ch_flags &= ~(CH_OPENING);
@@ -392,13 +389,12 @@ int jsm_tty_init(struct jsm_board *brd)
 			 * Okay to malloc with GFP_KERNEL, we are not at
 			 * interrupt context, and there are no locks held.
 			 */
-			brd->channels[i] = kmalloc(sizeof(struct jsm_channel), GFP_KERNEL);
+			brd->channels[i] = kzalloc(sizeof(struct jsm_channel), GFP_KERNEL);
 			if (!brd->channels[i]) {
 				jsm_printk(CORE, ERR, &brd->pci_dev,
 					"%s:%d Unable to allocate memory for channel struct\n",
 							 __FILE__, __LINE__);
 			}
-			memset(brd->channels[i], 0, sizeof(struct jsm_channel));
 		}
 	}
 

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
