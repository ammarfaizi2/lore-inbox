Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbRFAPnG>; Fri, 1 Jun 2001 11:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbRFAPm4>; Fri, 1 Jun 2001 11:42:56 -0400
Received: from ns.caldera.de ([212.34.180.1]:25236 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263217AbRFAPmj>;
	Fri, 1 Jun 2001 11:42:39 -0400
Date: Fri, 1 Jun 2001 17:42:32 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: ns558 bugfix / CSC ids
Message-ID: <20010601174232.A6493@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have added two CSC function ids to the ISAPNP joystick probing.
CSC cards use a lot of varying ids for the functions, but in my
set of data, 0010 and 0110 are always 'CTL'Game Controllers.

One bugfix: port->size must be set, or the release_region on rmmod ns558
fails badly.

Tested on IBM Netfinity 3500.

Ciao, Marcus

Index: drivers/char/joystick/ns558.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/char/joystick/ns558.c,v
retrieving revision 1.16
diff -u -r1.16 ns558.c
--- drivers/char/joystick/ns558.c	2001/06/01 11:33:11	1.16
+++ drivers/char/joystick/ns558.c	2001/06/01 15:31:09
@@ -178,6 +178,8 @@
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x7001), 0 },
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','T','L'), ISAPNP_DEVICE(0x7002), 0 },
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','S','C'), ISAPNP_DEVICE(0x0b35), 0 },
+	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','S','C'), ISAPNP_DEVICE(0x0010), 0 },
+	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('C','S','C'), ISAPNP_DEVICE(0x0110), 0 },
 	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID, ISAPNP_VENDOR('P','N','P'), ISAPNP_DEVICE(0xb02f), 0 },
 	{ 0, },
 };
@@ -217,6 +219,7 @@
 	port->next = next;
 	port->type = NS558_PNP;
 	port->gameport.io = ioport;
+	port->size = iolen;
 	port->dev = dev;
 
 	gameport_register_port(&port->gameport);
