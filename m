Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTJMTqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 15:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTJMTqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 15:46:52 -0400
Received: from mail.kroah.org ([65.200.24.183]:54980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261901AbTJMTqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 15:46:51 -0400
Date: Mon, 13 Oct 2003 12:46:16 -0700
From: Greg KH <greg@kroah.com>
To: Tomas Konir <moje@vabo.cz>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7 USB and Palm Tungsten problem
Message-ID: <20031013194616.GA11679@kroah.com>
References: <Pine.LNX.4.58.0310131855060.2551@moje.vabo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310131855060.2551@moje.vabo.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 07:06:49PM -0400, Tomas Konir wrote:
> 
> Hi
> I tried 2.6.0-test7, but new USB problem found. I tried to synchronize the 
> palm Tungsten T over USB cradle. None happend, only short message about 
> palm connected in log. Plug out the palm, but the visor module remained 
> busy (count=1) and when i tried to rmmod uhci-hcd the rmmod stay in D 
> state.

Try the patch below.  It should fix the problem for you.  If not, please
let me know.

thanks,

greg k-h


# USB: fix visor driver to work with Palm OS 4+ devices
# For some reason, they do not like the reset_config calls anymore.

diff -Nru a/drivers/usb/serial/visor.c b/drivers/usb/serial/visor.c
--- a/drivers/usb/serial/visor.c	Mon Oct 13 12:45:25 2003
+++ b/drivers/usb/serial/visor.c	Mon Oct 13 12:45:25 2003
@@ -778,9 +778,6 @@
 			serial->dev->actconfig->desc.bConfigurationValue);
 		return -ENODEV;
 	}
-	dbg("%s - reset config", __FUNCTION__);
-	retval = usb_reset_configuration (serial->dev);
-
 
 	if (id->driver_info) {
 		startup = (void *)id->driver_info;
