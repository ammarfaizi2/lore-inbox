Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbVIVHve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbVIVHve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVIVHuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:50:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:39347 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751451AbVIVHu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:50:27 -0400
Date: Thu, 22 Sep 2005 00:49:33 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       smurf@smurf.noris.de
Subject: [patch 15/18] usb/serial/option.c: Increase input buffer size
Message-ID: <20050922074933.GP15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-option-urb-buffer.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Urlichs <smurf@smurf.noris.de>

The card sometimes sends >2000 bytes in one single chunk. Ouch.

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/serial/option.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- scsi-2.6.orig/drivers/usb/serial/option.c	2005-09-21 17:29:40.000000000 -0700
+++ scsi-2.6/drivers/usb/serial/option.c	2005-09-21 17:29:50.000000000 -0700
@@ -26,6 +26,8 @@
                      killed end-of-line whitespace
   2005-07-15  v0.4.2 rename WLAN product to FUSION, add FUSION2
   2005-09-10  v0.4.3 added HUAWEI E600 card and Audiovox AirCard
+  2005-09-20  v0.4.4 increased recv buffer size: the card sometimes
+                     wants to send >2000 bytes.
 
   Work sponsored by: Sigos GmbH, Germany <info@sigos.de>
 
@@ -139,7 +141,7 @@
 
 #define N_IN_URB 4
 #define N_OUT_URB 1
-#define IN_BUFLEN 1024
+#define IN_BUFLEN 4096
 #define OUT_BUFLEN 128
 
 struct option_port_private {

--
