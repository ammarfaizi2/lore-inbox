Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSGSTmE>; Fri, 19 Jul 2002 15:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSGSTmD>; Fri, 19 Jul 2002 15:42:03 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:56584 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316969AbSGSTmC>;
	Fri, 19 Jul 2002 15:42:02 -0400
Date: Fri, 19 Jul 2002 12:43:26 -0700
From: Greg KH <greg@kroah.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB] uhci-hcd oops on APM resume (2.5.23-26)
Message-ID: <20020719194326.GA23137@kroah.com>
References: <Pine.LNX.4.44.0207182241510.4647-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207182241510.4647-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 18:42:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:28:23PM -0700, Craig Kulesa wrote:
> 
> 
> Looks fine.  Works great!  Upon the first APM suspend:

Hm, does this patch from Jan Harkes solve the uhci-hcd resume problem
for you?

thanks,

greg k-h

--- linux-2.5.24.orig/drivers/usb/host/uhci-hcd.c	Fri Jun 21 14:56:12 2002
+++ linux-2.5.24/drivers/usb/host/uhci-hcd.c	Sun Jul  7 01:18:44 2002
@@ -2074,6 +2074,8 @@
 
 	/* Run and mark it configured with a 64-byte max packet */
 	outw(USBCMD_RS | USBCMD_CF | USBCMD_MAXP, io_addr + USBCMD);
+
+	uhci->hcd.state = USB_STATE_READY;
 }
 
 #ifdef CONFIG_PROC_FS
@@ -2364,8 +2366,6 @@
 
 	/* disable legacy emulation */
 	pci_write_config_word(dev, USBLEGSUP, USBLEGSUP_DEFAULT);
-
-        hcd->state = USB_STATE_READY;
 
 	usb_connect(uhci->rh_dev);
         uhci->rh_dev->speed = USB_SPEED_FULL;
