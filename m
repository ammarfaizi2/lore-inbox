Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287711AbSAPP5s>; Wed, 16 Jan 2002 10:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288972AbSAPP5i>; Wed, 16 Jan 2002 10:57:38 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:50070 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S287711AbSAPP5X> convert rfc822-to-8bit; Wed, 16 Jan 2002 10:57:23 -0500
Subject: [PATCHLET] Tiny fixes for fastrouting
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru, davem@redhat.com
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF58C79499.EC73CC6E-ONC1256B43.00542D7F@de.ibm.com>
From: "Cornelia Huck" <COHUCK@de.ibm.com>
Date: Wed, 16 Jan 2002 16:57:27 +0100
X-MIMETrack: Serialize by Router on D12ML030/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 16/01/2002 16:57:29
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

the following patchlet fixes two things:

- The calculation of netdev_fastroute_obstacles should now be correct.
- A driver exploiting fastrouting compiled as a module will need
netdev_fastroute to be exported.

Patchlet should go fine into 2.4.18-pre4 and 2.5.3-pre1.

[Please cc me since I'm not subscribed to lkml]

diff -Naur linux.vanilla/net/core/dev.c linux/net/core/dev.c
--- linux.vanilla/net/core/dev.c   Wed Jan 16 14:23:32 2002
+++ linux/net/core/dev.c Wed Jan 16 14:28:13 2002
@@ -238,7 +238,7 @@

 #ifdef CONFIG_NET_FASTROUTE
     /* Hack to detect packet socket */
-    if (pt->data) {
+    if ((pt->data) && ((int)(pt->data)!=1)) {
          netdev_fastroute_obstacles++;
          dev_clear_fastroute(pt->dev);
     }
diff -Naur linux.vanilla/net/netsyms.c linux/net/netsyms.c
--- linux.vanilla/net/netsyms.c    Wed Jan 16 14:23:32 2002
+++ linux/net/netsyms.c  Wed Jan 16 14:25:43 2002
@@ -519,6 +519,10 @@
 EXPORT_SYMBOL(hippi_type_trans);
 #endif

+#ifdef CONFIG_NET_FASTROUTE
+EXPORT_SYMBOL(netdev_fastroute);
+#endif
+
 #ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(sysctl_wmem_max);
 EXPORT_SYMBOL(sysctl_rmem_max);

Mit freundlichen Grüßen/Regards
Cornelia Huck

Linux for zSeries Development
IBM Deutschland Entwicklung GmbH
Email: cohuck@de.ibm.com
Phone: ext. +49(0)7031/16-4837, int. *120-4837

