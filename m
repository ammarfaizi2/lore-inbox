Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUDZOIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUDZOIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbUDZOHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:07:43 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:28579 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263881AbUDZOFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 10:05:24 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Mon, 26 Apr 2004 16:05:17 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr> <20040423231811.GA10398@kroah.com>
In-Reply-To: <20040423231811.GA10398@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404261605.17486.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nice, I've applied all 9 patches here (with the updated patch 8
> version).  Feel free to send me an update for the warning issue you and
> Oliver talked about if you want to.

Hi Greg, thanks for applying the patches.  The following patch goes on top.
Hopefully it will make Oliver happy!

Ciao,

Duncan.


Be assertive.

 devio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
+++ b/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
@@ -350,8 +350,8 @@
 	 * all pending I/O requests; 2.6 does that.
 	 */
 
-	if (ifnum < 8*sizeof(ps->ifclaimed))
-		clear_bit(ifnum, &ps->ifclaimed);
+	BUG_ON(ifnum >= 8*sizeof(ps->ifclaimed));
+	clear_bit(ifnum, &ps->ifclaimed);
 	usb_set_intfdata (intf, NULL);
 
 	/* force async requests to complete */
