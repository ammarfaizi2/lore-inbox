Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758635AbWK1B22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635AbWK1B22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758638AbWK1B22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:28:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56326 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758635AbWK1B20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:28:26 -0500
Date: Tue, 28 Nov 2006 02:28:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill net/rxrpc/rxrpc_syms.c
Message-ID: <20061128012830.GS15364@stusta.de>
References: <20061126040416.GH15364@stusta.de> <30354.1164626485@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30354.1164626485@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 11:21:25AM +0000, David Howells wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch moves the EXPORT_SYMBOL's from net/rxrpc/rxrpc_syms.c to the 
> > files with the actual functions.
> 
> You can if you like.  Can you slap a blank line before each EXPORT_SYMBOL()
> though please?

Updated patch below.

> David

cu
Adrian


<--  snip  -->


This patch moves the EXPORT_SYMBOL's from net/rxrpc/rxrpc_syms.c to the
files with the actual functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/rxrpc/Makefile     |    1 -
 net/rxrpc/call.c       |   10 ++++++++++
 net/rxrpc/connection.c |    4 ++++
 net/rxrpc/rxrpc_syms.c |   34 ----------------------------------
 net/rxrpc/transport.c  |    8 ++++++++
 5 files changed, 22 insertions(+), 35 deletions(-)

--- linux-2.6.19-rc6-mm1/net/rxrpc/Makefile.old	2006-11-26 04:49:25.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/rxrpc/Makefile	2006-11-26 04:50:08.000000000 +0100
@@ -12,7 +12,6 @@
 	krxtimod.o \
 	main.o \
 	peer.o \
-	rxrpc_syms.o \
 	transport.o
 
 ifeq ($(CONFIG_PROC_FS),y)
--- linux-2.6.19-rc6-mm1/net/rxrpc/call.c.old	2006-11-26 04:50:51.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/rxrpc/call.c	2006-11-27 22:15:05.000000000 +0100
@@ -315,6 +315,8 @@
 	return ret;
 } /* end rxrpc_create_call() */
 
+EXPORT_SYMBOL(rxrpc_create_call);
+
 /*****************************************************************************/
 /*
  * create a new call record for incoming calls
@@ -466,6 +468,8 @@
 	_leave(" [destroyed]");
 } /* end rxrpc_put_call() */
 
+EXPORT_SYMBOL(rxrpc_put_call);
+
 /*****************************************************************************/
 /*
  * actually generate a normal ACK
@@ -924,6 +928,8 @@
 
 } /* end rxrpc_call_abort() */
 
+EXPORT_SYMBOL(rxrpc_call_abort);
+
 /*****************************************************************************/
 /*
  * process packets waiting for this call
@@ -1911,6 +1917,8 @@
 
 } /* end rxrpc_call_read_data() */
 
+EXPORT_SYMBOL(rxrpc_call_read_data);
+
 /*****************************************************************************/
 /*
  * write data to a call
@@ -2077,6 +2085,8 @@
 
 } /* end rxrpc_call_write_data() */
 
+EXPORT_SYMBOL(rxrpc_call_write_data);
+
 /*****************************************************************************/
 /*
  * flush outstanding packets to the network
--- linux-2.6.19-rc6-mm1/net/rxrpc/connection.c.old	2006-11-26 04:52:08.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/rxrpc/connection.c	2006-11-27 22:15:35.000000000 +0100
@@ -208,6 +208,8 @@
 	goto make_active;
 } /* end rxrpc_create_connection() */
 
+EXPORT_SYMBOL(rxrpc_create_connection);
+
 /*****************************************************************************/
 /*
  * lookup the connection for an incoming packet
@@ -412,6 +414,8 @@
 	_leave(" [killed]");
 } /* end rxrpc_put_connection() */
 
+EXPORT_SYMBOL(rxrpc_put_connection);
+
 /*****************************************************************************/
 /*
  * free a connection record
--- linux-2.6.19-rc6-mm1/net/rxrpc/transport.c.old	2006-11-26 04:52:43.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/rxrpc/transport.c	2006-11-27 22:15:57.000000000 +0100
@@ -147,6 +147,8 @@
 	return ret;
 } /* end rxrpc_create_transport() */
 
+EXPORT_SYMBOL(rxrpc_create_transport);
+
 /*****************************************************************************/
 /*
  * destroy a transport endpoint
@@ -197,6 +199,8 @@
 	_leave("");
 } /* end rxrpc_put_transport() */
 
+EXPORT_SYMBOL(rxrpc_put_transport);
+
 /*****************************************************************************/
 /*
  * add a service to a transport to be listened upon
@@ -232,6 +236,8 @@
 	return ret;
 } /* end rxrpc_add_service() */
 
+EXPORT_SYMBOL(rxrpc_add_service);
+
 /*****************************************************************************/
 /*
  * remove a service from a transport
@@ -249,6 +255,8 @@
 	_leave("");
 } /* end rxrpc_del_service() */
 
+EXPORT_SYMBOL(rxrpc_del_service);
+
 /*****************************************************************************/
 /*
  * INET callback when data has been received on the socket.
--- linux-2.6.19-rc6-mm1/net/rxrpc/rxrpc_syms.c	2006-09-20 05:42:06.000000000 +0200
+++ /dev/null	2006-09-19 00:45:31.000000000 +0200
@@ -1,34 +0,0 @@
-/* rxrpc_syms.c: exported Rx RPC layer interface symbols
- *
- * Copyright (C) 2002 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/module.h>
-
-#include <rxrpc/transport.h>
-#include <rxrpc/connection.h>
-#include <rxrpc/call.h>
-#include <rxrpc/krxiod.h>
-
-/* call.c */
-EXPORT_SYMBOL(rxrpc_create_call);
-EXPORT_SYMBOL(rxrpc_put_call);
-EXPORT_SYMBOL(rxrpc_call_abort);
-EXPORT_SYMBOL(rxrpc_call_read_data);
-EXPORT_SYMBOL(rxrpc_call_write_data);
-
-/* connection.c */
-EXPORT_SYMBOL(rxrpc_create_connection);
-EXPORT_SYMBOL(rxrpc_put_connection);
-
-/* transport.c */
-EXPORT_SYMBOL(rxrpc_create_transport);
-EXPORT_SYMBOL(rxrpc_put_transport);
-EXPORT_SYMBOL(rxrpc_add_service);
-EXPORT_SYMBOL(rxrpc_del_service);

