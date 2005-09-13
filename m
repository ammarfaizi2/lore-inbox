Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVIMAej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVIMAej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVIMAej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:34:39 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:20356 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932344AbVIMAej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:34:39 -0400
Date: Tue, 13 Sep 2005 02:34:29 +0200
Message-Id: <200509130034.j8D0YTvA010397@wscnet.wsc.cz>
In-reply-to: <200509130202.57093.lion.vollnhals@web.de>
Subject: [PATCH] usb: bluetty fix old tty buffer using
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Lion Vollnhals <lion.vollnhals@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bluetty, after tty conversion there was an error in compilation.

Generated in 2.6.13-mm3 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
---

 bluetty.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c
+++ b/drivers/usb/class/bluetty.c
@@ -794,7 +794,7 @@ static void bluetooth_int_callback (stru
 	if (packet_size + EVENT_HDR_SIZE == bluetooth->int_packet_pos) {
 		for (i = 0; i < bluetooth->int_packet_pos; ++i) {
 			/* if we insert more than TTY_FLIPBUF_SIZE characters, we drop them */
-			if (bluetooth->tty->flip.count >= TTY_FLIPBUF_SIZE) {
+			if (!tty_buffer_request_room(bluetooth->tty, 1)) {
 				tty_flip_buffer_push(bluetooth->tty);
 			}
 			tty_insert_flip_char(bluetooth->tty, bluetooth->int_buffer[i], 0);
@@ -922,7 +922,7 @@ static void bluetooth_read_bulk_callback
 	if (packet_size + ACL_HDR_SIZE == bluetooth->bulk_packet_pos) {
 		for (i = 0; i < bluetooth->bulk_packet_pos; ++i) {
 			/* if we insert more than TTY_FLIPBUF_SIZE characters, we drop them. */
-			if (bluetooth->tty->flip.count >= TTY_FLIPBUF_SIZE) {
+			if (!tty_buffer_request_room(bluetooth->tty, 1)) {
 				tty_flip_buffer_push(bluetooth->tty);
 			}
 			tty_insert_flip_char(bluetooth->tty, bluetooth->bulk_buffer[i], 0);
