Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262284AbTCHW4W>; Sat, 8 Mar 2003 17:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbTCHW4W>; Sat, 8 Mar 2003 17:56:22 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48815 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262284AbTCHW4V>; Sat, 8 Mar 2003 17:56:21 -0500
Date: Sat, 08 Mar 2003 15:06:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] remove compile warning from serial console initcall
Message-ID: <469810000.1047164815@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This tiny patch removes the new compiler warning from my build - 
the new console_initcall mechanism seems to require int from
console_init ... I made serial8250_console_init look like con_init

diff -urpN -X /home/fletch/.diff.exclude 900-mjb2/drivers/serial/8250.c 999-serial_fix/drivers/serial/8250.c
--- 900-mjb2/drivers/serial/8250.c	Sat Mar  8 12:54:04 2003
+++ 999-serial_fix/drivers/serial/8250.c	Sat Mar  8 14:48:20 2003
@@ -1982,10 +1982,11 @@ static struct console serial8250_console
 	.index		= -1,
 };
 
-static void __init serial8250_console_init(void)
+static int __init serial8250_console_init(void)
 {
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
+	return 0;
 }
 console_initcall(serial8250_console_init);
 

