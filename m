Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSFDOYp>; Tue, 4 Jun 2002 10:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSFDOYo>; Tue, 4 Jun 2002 10:24:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35595 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312254AbSFDOYl>;
	Tue, 4 Jun 2002 10:24:41 -0400
Date: Tue, 4 Jun 2002 15:24:42 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] Remove SERIAL_IO_GSC
Message-ID: <20020604152442.P10366@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We never needed this, and it should be removed -- I recently saw someone
copy it blindly into another file.

diff -urNX build-tools/dontdiff linux-upstream/drivers/char/serial.c linux-pa/drivers/char/serial.c
--- linux-upstream/drivers/char/serial.c	Tue Jun  4 07:58:09 2002
+++ linux-pa/drivers/char/serial.c	Mon Feb 25 17:44:54 2002
@@ -418,10 +426,6 @@
 	case SERIAL_IO_MEM:
 		return readb((unsigned long) info->iomem_base +
 			     (offset<<info->iomem_reg_shift));
-#ifdef CONFIG_SERIAL_GSC
-	case SERIAL_IO_GSC:
-		return gsc_readb(info->iomem_base + offset);
-#endif
 	default:
 		return inb(info->port + offset);
 	}
@@ -441,11 +445,6 @@
 		writeb(value, (unsigned long) info->iomem_base +
 			      (offset<<info->iomem_reg_shift));
 		break;
-#ifdef CONFIG_SERIAL_GSC
-	case SERIAL_IO_GSC:
-		gsc_writeb(value, info->iomem_base + offset);
-		break;
-#endif
 	default:
 		outb(value, info->port+offset);
 	}
diff -urNX build-tools/dontdiff linux-upstream/include/linux/serial.h linux-pa/include/linux/serial.h
--- linux-upstream/include/linux/serial.h	Tue Jun  4 07:59:51 2002
+++ linux-pa/include/linux/serial.h	Thu Nov 29 08:50:01 2001
@@ -80,7 +80,6 @@
 #define SERIAL_IO_PORT	0
 #define SERIAL_IO_HUB6	1
 #define SERIAL_IO_MEM	2
-#define SERIAL_IO_GSC	3
 
 struct serial_uart_config {
 	char	*name;

-- 
Revolutions do not require corporate support.
