Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWHOA6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWHOA6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWHOA6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:58:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:13442 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965047AbWHOA6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:58:19 -0400
Date: Mon, 14 Aug 2006 17:57:49 -0700
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: o.bock@fh-wolfenbuettel.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/usb/misc/cypress_cy7c63.c: NULL dereference
Message-ID: <20060815005749.GA24238@suse.de>
References: <20060815000442.GB3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815000442.GB3543@stusta.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:04:42AM +0200, Adrian Bunk wrote:
> The Coverity Checker spotted the following obvious NULL dereference:
> 
> <--  snip  -->
> 
> ...
> static int cypress_probe(struct usb_interface *interface,
>                          const struct usb_device_id *id)
> {
> ...
>         if (dev == NULL) {
>                 dev_err(&dev->udev->dev, "Out of memory!\n");
>                 goto error;
>         }
> ...
> }
> ...
> 
> <--  snip  -->

Thanks for letting me know, the patch below should fix this.

greg k-h

------------

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: USB: fix bug in cypress_cy7c63.c driver

This was pointed out by Adrian Bunk <bunk@stusta.de>, as found by the
Coverity Checker.


Cc: Adrian Bunk <bunk@stusta.de>
Cc: Oliver Bock <o.bock@fh-wolfenbuettel.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/misc/cypress_cy7c63.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/usb/misc/cypress_cy7c63.c
+++ gregkh-2.6/drivers/usb/misc/cypress_cy7c63.c
@@ -208,7 +208,7 @@ static int cypress_probe(struct usb_inte
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL) {
-		dev_err(&dev->udev->dev, "Out of memory!\n");
+		dev_err(&interface->dev, "Out of memory!\n");
 		goto error;
 	}
 
