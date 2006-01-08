Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbWAHM72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbWAHM72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWAHM72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:59:28 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:61241 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932732AbWAHM71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:59:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=CEY+lnOeKsCzEJpkt+cvN88Rblgk9hKyyzBcE+ilZnaIELHZ882MNvA+5lonOvJ9jtG0BP1YMeGmGRi0OK8yG5vFB1lTeFqZE+1iGD2AWEltM3M0H0rDcKZe7uQrGvbKYfujE4k4iFcgNSTwNCe5+peUJ2rp134hid32rocP9aU=
Date: Sun, 8 Jan 2006 16:16:23 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable rio on 64-bit platforms
Message-ID: <20060108131622.GA23362@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/Kconfig         |    2 +-
 drivers/char/rio/rio_linux.c |    4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -282,7 +282,7 @@ config SX
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP && !64BIT
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
--- a/drivers/char/rio/rio_linux.c
+++ b/drivers/char/rio/rio_linux.c
@@ -56,10 +56,6 @@
 #include <linux/generic_serial.h>
 #include <asm/uaccess.h>
 
-#if BITS_PER_LONG != 32
-#  error FIXME: this driver only works on 32-bit platforms
-#endif
-
 #include "linux_compat.h"
 #include "typdef.h"
 #include "pkt.h"

