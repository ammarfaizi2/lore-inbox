Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTDXXlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTDXXhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:37:07 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30101 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264500AbTDXXeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:07 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1051228051504@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280511698@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:31 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.2, 2003/04/23 12:04:22-07:00, akpm@digeo.com

[PATCH] usb: minor usb stuff

- nail a couple of warnings

- usbnet is not compilable with gcc-2.95.3.  Fix.


 drivers/usb/class/usb-midi.c |    2 +-
 drivers/usb/net/kaweth.c     |    2 +-
 drivers/usb/net/usbnet.c     |    8 ++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/class/usb-midi.c b/drivers/usb/class/usb-midi.c
--- a/drivers/usb/class/usb-midi.c	Thu Apr 24 16:28:38 2003
+++ b/drivers/usb/class/usb-midi.c	Thu Apr 24 16:28:38 2003
@@ -820,7 +820,7 @@
 	struct list_head      *devs, *mdevs;
 	struct usb_midi_state *s;
 	struct usb_mididev    *m;
-	int flags;
+	unsigned long flags;
 	int succeed = 0;
 
 #if 0
diff -Nru a/drivers/usb/net/kaweth.c b/drivers/usb/net/kaweth.c
--- a/drivers/usb/net/kaweth.c	Thu Apr 24 16:28:39 2003
+++ b/drivers/usb/net/kaweth.c	Thu Apr 24 16:28:39 2003
@@ -744,7 +744,7 @@
 		}
 	}
 
-	private_header = __skb_push(skb, 2);
+	private_header = (u16 *)__skb_push(skb, 2);
 	*private_header = cpu_to_le16(skb->len-2);
 	kaweth->tx_skb = skb;
 
diff -Nru a/drivers/usb/net/usbnet.c b/drivers/usb/net/usbnet.c
--- a/drivers/usb/net/usbnet.c	Thu Apr 24 16:28:38 2003
+++ b/drivers/usb/net/usbnet.c	Thu Apr 24 16:28:39 2003
@@ -314,8 +314,12 @@
 			: (in_interrupt () ? "in_interrupt" : "can sleep"))
 
 #ifdef DEBUG
-#define devdbg(usbnet, fmt, arg...) \
-	printk(KERN_DEBUG "%s: " fmt "\n" , (usbnet)->net.name, ## arg)
+#define devdbg(usbnet, fmt, arg...)				\
+	do {							\
+		printk(KERN_DEBUG "%s:", (usbnet)->net.name);	\
+		printk(fmt, ## arg);				\
+		printk("\n");					\
+	} while (0)
 #else
 #define devdbg(usbnet, fmt, arg...) do {} while(0)
 #endif

