Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUEQQeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUEQQeB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUEQQeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:34:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:61584 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261880AbUEQQd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:33:59 -0400
Date: Mon, 17 May 2004 09:32:07 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm3: USB console.c doesn't compile
Message-ID: <20040517163207.GB28629@kroah.com>
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040516183849.GO22742@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516183849.GO22742@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 08:38:49PM +0200, Adrian Bunk wrote:
> The following compile error comes from Linus' tree:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/usb/serial/console.o
> drivers/usb/serial/console.c: In function `usb_console_setup':
> drivers/usb/serial/console.c:140: warning: implicit declaration of function `serial_paranoia_check'
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.init.text+0x698c8): In function `usb_console_setup':
> : undefined reference to `serial_paranoia_check'
> make: *** [.tmp_vmlinux1] Error 1

Oops, forgot that one, sorry.  Here's a patch that fixes it, and I'll
forward it on to Linus later today.

thanks,

greg k-h


diff -Nru a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
--- a/drivers/usb/serial/console.c	Mon May 17 09:31:11 2004
+++ b/drivers/usb/serial/console.c	Mon May 17 09:31:11 2004
@@ -137,7 +137,7 @@
 
 	/* grab the first serial port that happens to be connected */
 	serial = usb_serial_get_by_index(0);
-	if (serial_paranoia_check (serial, __FUNCTION__)) {
+	if (serial == NULL) {
 		/* no device is connected yet, sorry :( */
 		err ("No USB device connected to ttyUSB0");
 		return -ENODEV;
