Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUIJSYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUIJSYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUIJSYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:24:39 -0400
Received: from pD9FF120F.dip.t-dialin.net ([217.255.18.15]:6660 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S267632AbUIJSYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:24:35 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.9-rc1-mm4, visor.c, Badness in usb_unlink_urb
Date: Fri, 10 Sep 2004 20:24:31 +0200
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>
References: <20040910082601.GA32746@gamma.logic.tuwien.ac.at> <200409101148.37587.petkov@uni-muenster.de> <20040910140152.GA15589@kroah.com>
In-Reply-To: <20040910140152.GA15589@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409102024.32082.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
I'll be happy to tackle the other drivers. Question: Does usb_unlink_urb have 
to be replaced only for synchronious unlinking and if so, is the wrapping 
function responsible for checking the URB_ASYNC_UNLINK transfer flag? Here's 
a patch:

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- linux-2.6.9-rc1-mm/drivers/usb/class/audio.c.orig 2004-09-10 20:05:17.000000000 +0200
+++ linux-2.6.9-rc1-mm/drivers/usb/class/audio.c 2004-09-10 20:23:12.000000000 +0200
@@ -635,13 +635,13 @@ static void usbin_stop(struct usb_audiod
   spin_unlock_irqrestore(&as->lock, flags);
   if (notkilled && signal_pending(current)) {
    if (i & FLG_URB0RUNNING)
-    usb_unlink_urb(u->durb[0].urb);
+    usb_kill_urb(u->durb[0].urb);
    if (i & FLG_URB1RUNNING)
-    usb_unlink_urb(u->durb[1].urb);
+    usb_kill_urb(u->durb[1].urb);
    if (i & FLG_SYNC0RUNNING)
-    usb_unlink_urb(u->surb[0].urb);
+    usb_kill_urb(u->surb[0].urb);
    if (i & FLG_SYNC1RUNNING)
-    usb_unlink_urb(u->surb[1].urb);
+    usb_kill_urb(u->surb[1].urb);
    notkilled = 0;
   }
  }
@@ -1114,13 +1114,13 @@ static void usbout_stop(struct usb_audio
   spin_unlock_irqrestore(&as->lock, flags);
   if (notkilled && signal_pending(current)) {
    if (i & FLG_URB0RUNNING)
-    usb_unlink_urb(u->durb[0].urb);
+    usb_kill_urb(u->durb[0].urb);
    if (i & FLG_URB1RUNNING)
-    usb_unlink_urb(u->durb[1].urb);
+    usb_kill_urb(u->durb[1].urb);
    if (i & FLG_SYNC0RUNNING)
-    usb_unlink_urb(u->surb[0].urb);
+    usb_kill_urb(u->surb[0].urb);
    if (i & FLG_SYNC1RUNNING)
-    usb_unlink_urb(u->surb[1].urb);
+    usb_kill_urb(u->surb[1].urb);
    notkilled = 0;
   }
  }

