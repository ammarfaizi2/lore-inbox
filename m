Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVJNEUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVJNEUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVJNEUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:20:33 -0400
Received: from li2-47.members.linode.com ([69.56.173.47]:6930 "EHLO
	li2-47.members.linode.com") by vger.kernel.org with ESMTP
	id S1751166AbVJNEUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:20:33 -0400
Date: Fri, 14 Oct 2005 00:20:08 -0400
From: Randall Nortman <linuxkernellist@wonderclown.com>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] usbserial: Regression in USB generic serial driver
Message-ID: <20051014042007.GO8982@li2-47.members.linode.com>
Mail-Followup-To: gregkh@suse.de, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20051014014255.GN8982@li2-47.members.linode.com> <20051014015908.GR7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014015908.GR7991@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version 2.6.13 introduced a regression in the generic USB
serial converter driver (usbserial.o, drivers/usb/serial/generic.c).
The bug manifests, as far as I can tell, whenever you attempt to write
to the device -- the write will never complete (write() returns 0, or
blocks).

Signed-off-by: Randall Nortman <oss@wonderclown.org>
---
I'm sending this a second time, after reading up on the right way to
submit a patch (much thanks to Chris Wright).  Now we see if I'm
capable of following instructions properly.

diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -223,7 +223,7 @@ int usb_serial_generic_write_room (struc
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (serial->num_bulk_out) {
-		if (port->write_urb_busy)
+		if (!(port->write_urb_busy))
 			room = port->bulk_out_size;
 	}
 
