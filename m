Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUH0OMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUH0OMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUH0OMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:12:37 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:46260 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265211AbUH0OMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:12:31 -0400
Date: Fri, 27 Aug 2004 15:12:30 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: drm fixup 1/2 - missing bus_address assignment
Message-ID: <Pine.LNX.4.58.0408271510530.32411@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a series of two minor patches for the DRM, one fixes a missing
bus_address and the other from Arjan optimises some access in the i8x0
drivers..


Patch from Tom Arbuckle for missing bus_address

Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Sat Aug 28 00:02:27 2004
+++ b/drivers/char/drm/drm_bufs.h	Sat Aug 28 00:02:28 2004
@@ -691,6 +691,7 @@
 			buf->used    = 0;
 			buf->offset  = (dma->byte_count + byte_count + offset);
 			buf->address = (void *)(page + offset);
+			buf->bus_address = virt_to_bus(buf->address);
 			buf->next    = NULL;
 			buf->waiting = 0;
 			buf->pending = 0;
