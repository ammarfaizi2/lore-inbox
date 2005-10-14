Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVJNBnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVJNBnD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 21:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVJNBnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 21:43:03 -0400
Received: from li2-47.members.linode.com ([69.56.173.47]:11025 "EHLO
	li2-47.members.linode.com") by vger.kernel.org with ESMTP
	id S932526AbVJNBnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 21:43:02 -0400
Date: Thu, 13 Oct 2005 21:42:56 -0400
From: Randall Nortman <linuxkernellist@wonderclown.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Regression in 2.6.13 in USB generic serial driver
Message-ID: <20051014014255.GN8982@li2-47.members.linode.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version 2.6.13 introduced a regression (vs. 2.6.12.6) in the
generic USB serial converter driver.  The regression manifests, as far
as I can tell, whenever you attempt to write to the device.  The
symptom is that the write never completes (write() returns 0, or
blocks).  I'm pretty sure this will happen with all hardware, but I
only have my hardware to test with (amd64 host interfacing to a
custom-built USB device based on an Atmel AT91SAM7X256 arm7tdmi chip's
built-in USB transceiver).

The patch (vs. vanilla 2.6.13.4) is rather straightforward:

===================================================================
diff -ru linux-2.6.13.4/drivers/usb/serial/generic.c linux-2.6.13.4-fixed/drivers/usb/serial/generic.c
--- linux-2.6.13.4/drivers/usb/serial/generic.c	2005-10-10 14:54:29.000000000 -0400
+++ linux-2.6.13.4-fixed/drivers/usb/serial/generic.c	2005-10-13 21:34:54.000000000 -0400
@@ -223,7 +223,7 @@
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (serial->num_bulk_out) {
-		if (port->write_urb_busy)
+		if (!(port->write_urb_busy))
 			room = port->bulk_out_size;
 	}
 
===================================================================

Please let me know if I'm missing something.  Otherwise, do I need to
do anything in particular to get a maintainer to accept the patch?
(I'm a long-time user, first-time patcher, so forgive my ignorance
about procedures.)

-- 
Randall
