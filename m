Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUHMTCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUHMTCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUHMS7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:59:48 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:43997 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266905AbUHMS6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:58:53 -0400
Message-ID: <411D0F0A.1060204@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:57:14 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] iph5526.c fixes from 2.6
Content-Type: multipart/mixed;
	boundary="------------060100050202030408030403"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060100050202030408030403
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

unreached code, rx/tx typo, etc.

=D6zkan Sezer



--------------060100050202030408030403
Content-Type: text/plain;
	name="iph5526.c-2.6-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="iph5526.c-2.6-fixes.diff"

--- 27rc5~/drivers/net/fc/iph5526.c	2003-06-13 17:51:34.000000000 +0300
+++ 27rc5/drivers/net/fc/iph5526.c	2004-08-07 14:09:39.000000000 +0300
@@ -689,8 +689,8 @@
 			prev_IMQ_index = current_IMQ_index;
 		}
 	} /*end of for loop*/		
-	return;
 	LEAVE("tachyon_interrupt");
+       return;
 }
 
 
@@ -2933,7 +2933,7 @@
 {
 	struct fc_info *fi = (struct fc_info*)dev->priv;
 	printk(KERN_WARNING "%s: timed out on send.\n", dev->name);
-	fi->fc_stats.rx_dropped++;
+	fi->fc_stats.tx_dropped++;
 	dev->trans_start = jiffies;
 	netif_wake_queue(dev);
 }
@@ -2976,7 +2976,7 @@
 		fi->fc_stats.tx_packets++;
 	}
 	else
-		fi->fc_stats.rx_dropped++;
+		fi->fc_stats.tx_dropped++;
 	dev->trans_start = jiffies;
 	/* We free up the IP buffers in the OCI_interrupt handler.
 	 * status == 0 implies that the frame was not transmitted. So the
@@ -3374,8 +3374,8 @@
 		q = q->next;
 	}
 	DPRINTK1("Port Name does not match. Txing LOGO.");
-	return 0;
 	LEAVE("validate_login");
+       return 0;
 }
 
 static void add_to_address_cache(struct fc_info *fi, u_int *base_ptr)
@@ -3758,8 +3758,10 @@
 		sprintf(fi->name, "fc%d", count);
 
 		host = scsi_register(tmpt, sizeof(struct iph5526_hostdata));
-		if(host==NULL)
+		if(host==NULL) {
+			kfree(fc[count]);
 			return no_of_hosts;
+		}
 			
 		hostdata = (struct iph5526_hostdata *)host->hostdata;
 		memset(hostdata, 0 , sizeof(struct iph5526_hostdata));


--------------060100050202030408030403--
