Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261753AbSJHXmn>; Tue, 8 Oct 2002 19:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJHXlJ>; Tue, 8 Oct 2002 19:41:09 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:52233 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261429AbSJHXPy>;
	Tue, 8 Oct 2002 19:15:54 -0400
Date: Tue, 8 Oct 2002 16:17:47 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008231747.GD11337@kroah.com>
References: <20021008231511.GA11337@kroah.com> <20021008231557.GB11337@kroah.com> <20021008231646.GC11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008231646.GC11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.14 -> 1.573.92.15
#	drivers/usb/serial/pl2303.c	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/07	greg@kroah.com	1.573.92.15
# [PATCH] USB: fix ctsrts handling in pl2303 driver.
# 
# Thanks to the prolific engineers for pointing this out to me.
# --------------------------------------------
#
diff -Nru a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
--- a/drivers/usb/serial/pl2303.c	Tue Oct  8 15:53:47 2002
+++ b/drivers/usb/serial/pl2303.c	Tue Oct  8 15:53:47 2002
@@ -358,7 +358,7 @@
 
 	if (cflag & CRTSCTS) {
 		i = usb_control_msg (serial->dev, usb_sndctrlpipe (serial->dev, 0),
-				     VENDOR_WRITE_REQUEST_TYPE, VENDOR_WRITE_REQUEST_TYPE,
+				     VENDOR_WRITE_REQUEST, VENDOR_WRITE_REQUEST_TYPE,
 				     0x0, 0x41, NULL, 0, 100);
 		dbg ("0x40:0x1:0x0:0x41  %d", i);
 	}
