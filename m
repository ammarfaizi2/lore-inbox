Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274882AbTHAKqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270717AbTHAKqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:46:14 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:56337 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272498AbTHAKoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:24 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] Cleanup PPP menu and give it a submenu
Date: Fri, 1 Aug 2003 12:40:11 +0200
User-Agent: KMail/1.5.2
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200307312224.35056.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LOkK/8OsIo3bX9O"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_LOkK/8OsIo3bX9O
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

I've been getting complaints about the menu structure from the linux kernel 
config subsystem for a _long time_. Now let's clean up the PPP menu and give 
it a submenu. We are getting close that the menu will look more cleaner :)

More cleanups for different menu's are following.

Please apply for 2.4.22-pre10. Thank you :)

If you accept this one, some other arches have this stuff in 
arch/<arch>/Config.in which is bad anyway, but it needs a cleanup of the menu 
structure also, so I'll send a patch for them too.

ciao, Marc

--Boundary-00=_LOkK/8OsIo3bX9O
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-ppp-menu-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-ppp-menu-cleanup.patch"

diff -Naurp a/drivers/net/Config.in b/drivers/net/Config.in
--- a/drivers/net/Config.in	2003-01-03 18:39:27.000000000 +0100
+++ b/drivers/net/Config.in	2003-01-04 16:38:46.000000000 +0100
@@ -300,6 +300,15 @@ fi
 
 dep_tristate 'PLIP (parallel port) support' CONFIG_PLIP $CONFIG_PARPORT
 
+tristate 'SLIP (serial line) support' CONFIG_SLIP
+if [ "$CONFIG_SLIP" != "n" ]; then
+   bool '  CSLIP compressed headers' CONFIG_SLIP_COMPRESSED
+   bool '  Keepalive and linefill' CONFIG_SLIP_SMART
+   bool '  Six bit SLIP encapsulation' CONFIG_SLIP_MODE_SLIP6
+fi
+
+mainmenu_option next_comment
+comment 'PPP (point-to-point protocol) support'
 tristate 'PPP (point-to-point protocol) support' CONFIG_PPP
 if [ ! "$CONFIG_PPP" = "n" ]; then
    dep_bool '  PPP multilink support (EXPERIMENTAL)' CONFIG_PPP_MULTILINK $CONFIG_EXPERIMENTAL
@@ -315,13 +315,7 @@ if [ ! "$CONFIG_PPP" = "n" ]; then
       dep_tristate '  PPP over ATM (EXPERIMENTAL)' CONFIG_PPPOATM $CONFIG_PPP $CONFIG_ATM
    fi
 fi
-
-tristate 'SLIP (serial line) support' CONFIG_SLIP
-if [ "$CONFIG_SLIP" != "n" ]; then
-   bool '  CSLIP compressed headers' CONFIG_SLIP_COMPRESSED
-   bool '  Keepalive and linefill' CONFIG_SLIP_SMART
-   bool '  Six bit SLIP encapsulation' CONFIG_SLIP_MODE_SLIP6
-fi
+endmenu
 
 mainmenu_option next_comment
 comment 'Wireless LAN (non-hamradio)'

--Boundary-00=_LOkK/8OsIo3bX9O--


