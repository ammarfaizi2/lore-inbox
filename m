Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbTIKR5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbTIKR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:57:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:52150 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261416AbTIKR5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:57:34 -0400
Date: Thu, 11 Sep 2003 10:57:56 -0700
From: Greg KH <greg@kroah.com>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.0-test5 usbserial oops
Message-ID: <20030911175755.GA13334@kroah.com>
References: <3F60B4AB.7060109@kmlinux.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F60B4AB.7060109@kmlinux.fjfi.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 07:45:15PM +0200, Jindrich Makovicka wrote:
> Hello,
> 
> I have a similar problem, here is the syslog with debug=1 set for visor 
> and usbserial. This occured after using a ppp connection. I am running 
> 2.4.0test5 with v4l2 patch from http://bytesex.org/v4l/.

Hm, can you try the following patch and let me know if it fixes the
problem for you?

thanks,

greg k-h

--- a/drivers/usb/serial/usb-serial.c	Wed Sep  3 08:47:22 2003
+++ b/drivers/usb/serial/usb-serial.c	Thu Sep 11 11:01:55 2003
@@ -871,8 +871,10 @@
 
 	/* the ports are cleaned up and released in port_release() */
 	for (i = 0; i < serial->num_ports; ++i)
-		if (serial->port[i]->dev.parent != NULL)
+		if (serial->port[i]->dev.parent != NULL) {
 			device_unregister(&serial->port[i]->dev);
+			serial->port[i] = NULL;
+		}
 
 	/* If this is a "fake" port, we have to clean it up here, as it will
 	 * not get cleaned up in port_release() as it was never registered with
