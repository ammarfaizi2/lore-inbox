Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTBLK5J>; Wed, 12 Feb 2003 05:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTBLK4C>; Wed, 12 Feb 2003 05:56:02 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:32393 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267070AbTBLKzP>;
	Wed, 12 Feb 2003 05:55:15 -0500
Date: Wed, 12 Feb 2003 12:04:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Give preferential treatment to gameport at 0x201 [9/14]
Message-ID: <20030212120454.H1563@ucw.cz>
References: <20030212115954.A1268@ucw.cz> <20030212120038.A1563@ucw.cz> <20030212120119.B1563@ucw.cz> <20030212120154.C1563@ucw.cz> <20030212120242.D1563@ucw.cz> <20030212120321.E1563@ucw.cz> <20030212120359.F1563@ucw.cz> <20030212120427.G1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030212120427.G1563@ucw.cz>; from vojtech@suse.cz on Wed, Feb 12, 2003 at 12:04:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1012, 2003-02-12 11:03:11+01:00, vojtech@suse.cz
  input: Give preferential treatment to gameport at 0x201, and use
    the odd addresses for access.


 ns558.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

===================================================================

diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	Wed Feb 12 11:56:47 2003
+++ b/drivers/input/gameport/ns558.c	Wed Feb 12 11:56:47 2003
@@ -46,7 +46,7 @@
 #define NS558_ISA	1
 #define NS558_PNP	2
 
-static int ns558_isa_portlist[] = { 0x200, 0x201, 0x202, 0x203, 0x204, 0x205, 0x207, 0x209,
+static int ns558_isa_portlist[] = { 0x201, 0x200, 0x202, 0x203, 0x204, 0x205, 0x207, 0x209,
 				    0x20b, 0x20c, 0x20e, 0x20f, 0x211, 0x219, 0x101, 0 };
 
 struct ns558 {
@@ -140,7 +140,7 @@
 	
 	port->type = NS558_ISA;
 	port->size = (1 << i);
-	port->gameport.io = io & (-1 << i);
+	port->gameport.io = io;
 	port->gameport.phys = port->phys;
 	port->gameport.name = port->name;
 	port->gameport.id.bustype = BUS_ISA;
@@ -148,7 +148,7 @@
 	sprintf(port->phys, "isa%04x/gameport0", io & (-1 << i));
 	sprintf(port->name, "NS558 ISA");
 
-	request_region(port->gameport.io, (1 << i), "ns558-isa");
+	request_region(io & (-1 << i), (1 << i), "ns558-isa");
 
 	gameport_register_port(&port->gameport);
 
@@ -275,7 +275,7 @@
 				/* fall through */
 #endif
 			case NS558_ISA:
-				release_region(port->gameport.io, port->size);
+				release_region(port->gameport.io & ~(port->size - 1), port->size);
 				break;
 		
 			default:
