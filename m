Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbTGULGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269670AbTGULGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:06:17 -0400
Received: from c-cca870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.204]:4480
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S269661AbTGULGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:06:16 -0400
To: linux-kernel@vger.kernel.org
Subject: AX8817x (USB ethernet) problem in 2.6.0-test1
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 21 Jul 2003 13:21:08 +0200
Message-ID: <yw1x1xwkgm6z.fsf@zaphod.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My Netgear FA120 USB2 ethernet adaptor isn't working properly with
Linux 2.6.0-test1.  First off, I had to modify it slightly (patch
below) to make it work at all with USB2.  Now I can send data at the
full expected speed (~11 MB/s).  The problem is that receiving is only
200 kb/s.  This is obviously annoying.  For the record, it works
perfectly with 2.4.21-pre5 and ax8817x.c version 0.9.7.  Any ideas?


Index: drivers/usb/net/ax8817x.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/usb/net/ax8817x.c,v
retrieving revision 1.2
diff -u -r1.2 ax8817x.c
--- drivers/usb/net/ax8817x.c	21 Jun 2003 16:20:14 -0000	1.2
+++ drivers/usb/net/ax8817x.c	21 Jul 2003 09:42:58 -0000
@@ -1238,7 +1238,7 @@
 
 	usb_fill_int_urb(ax_info->int_urb, usb, usb_rcvintpipe(usb, 1),
 			 ax_info->int_buf, 8, ax_int_callback, ax_info,
-			 100);
+			 usb->speed == USB_SPEED_HIGH? 8: 100);
 
 	ret = usb_submit_urb(ax_info->int_urb, GFP_ATOMIC);
 	if (ret < 0) {


-- 
Måns Rullgård
mru@users.sf.net
