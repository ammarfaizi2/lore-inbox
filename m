Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRLEGAX>; Wed, 5 Dec 2001 01:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281124AbRLEGAD>; Wed, 5 Dec 2001 01:00:03 -0500
Received: from zok.sgi.com ([204.94.215.101]:1981 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S280967AbRLEF77>;
	Wed, 5 Dec 2001 00:59:59 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: eddantes@wanadoo.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug report 2.4.16: local symbols in discarded section .text.exit 
In-Reply-To: Your message of "Sun, 02 Dec 2001 22:40:05 BST."
             <3C0A9FB5.8040302@wanadoo.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 16:59:45 +1100
Message-ID: <4157.1007531985@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2001 22:40:05 +0100, 
eddantes@wanadoo.fr wrote:
>drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols
>in discarded section .text.exit'
>drivers/net/net.o(.data+0xb4): undefined reference to `local symbols in
>discarded section .text.exit'

The latest binutils will flag references to symbols in discarded
sections.  Tables that refer to code marked __devexit are now flagged
as an error when the code is built in, because __devexit code is
discarded.  Quick and dirty work around, while I think about a better
fix.

Index: 16.1/drivers/char/serial.c
--- 16.1/drivers/char/serial.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/b/c/22_serial.c 1.1.3.2.2.3.2.2.1.8.1.1 644)
+++ 16.1(w)/drivers/char/serial.c Wed, 05 Dec 2001 16:54:24 +1100 kaos (linux-2.4/b/c/22_serial.c 1.1.3.2.2.3.2.2.1.8.1.1 644)
@@ -4896,7 +4896,9 @@ MODULE_DEVICE_TABLE(pci, serial_pci_tbl)
 static struct pci_driver serial_pci_driver = {
        name:           "serial",
        probe:          serial_init_one,
+#ifdef MODULE
        remove:	       serial_remove_one,
+#endif
        id_table:       serial_pci_tbl,
 };
 
Index: 16.1/drivers/net/via-rhine.c
--- 16.1/drivers/net/via-rhine.c Sat, 10 Nov 2001 21:05:25 +1100 kaos (linux-2.4/h/c/19_via-rhine. 1.1.1.4.1.2.1.3.1.2.1.1.1.1 644)
+++ 16.1(w)/drivers/net/via-rhine.c Wed, 05 Dec 2001 16:57:23 +1100 kaos (linux-2.4/h/c/19_via-rhine. 1.1.1.4.1.2.1.3.1.2.1.1.1.1 644)
@@ -1667,7 +1667,9 @@ static struct pci_driver via_rhine_drive
 	name:		"via-rhine",
 	id_table:	via_rhine_pci_tbl,
 	probe:		via_rhine_init_one,
+#ifdef MODULE
 	remove:		via_rhine_remove_one,
+#endif
 };
 
 

