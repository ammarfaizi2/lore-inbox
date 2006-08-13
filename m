Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWHMT1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWHMT1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWHMT1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:27:25 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:1742 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751371AbWHMT1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:27:24 -0400
Date: Sun, 13 Aug 2006 21:27:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_NETDEVICES does not do anything
Message-ID: <20060813192723.GC21487@mars.ravnborg.org>
References: <Pine.LNX.4.61.0608100831580.10926@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608100831580.10926@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 08:34:30AM +0200, Jan Engelhardt wrote:
> Hello,
> 
> 
> when deselecting CONFIG_NETDEVICES, many selectable items (PHY device 
> support, Ethernet 10/100/1000/10000) stay in place. Is there a reason they 
> are lacking 'depends on NETDEVICES' or did I found a bug^W glitch?
It was changed by appended commit.
I do not see why the if/endif was removed - Paolo?

	Sam


commit 6967bd81d883ed325fd58840ee02a8da60458e6b
Author: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Date:   Fri Feb 3 01:45:21 2006 -0800

    [PATCH] Kbuild menu - hide empty NETDEVICES menu when NET is disabled
    
    Make the whole netdevices menu depend on NET, rather than having an empty
    submenu when networking is disabled.
    
    Indeed, almost the whole body of the menu was surrounded by if NETDEVICES,
    and what was outside depended on NETCONSOLE which is inside the menu.
    
    Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6a6a084..47c72a6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -4,9 +4,9 @@ # Network device configuration
 #
 
 menu "Network device support"
+	depends on NET
 
 config NETDEVICES
-	depends on NET
 	default y if UML
 	bool "Network device support"
 	---help---
@@ -24,9 +24,6 @@ config NETDEVICES
 
 	  If unsure, say Y.
 
-# All the following symbols are dependent on NETDEVICES - do not repeat
-# that for each of the symbols.
-if NETDEVICES
 
 config IFB
 	tristate "Intermediate Functional Block support"
@@ -2718,8 +2715,6 @@ config NETCONSOLE
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.
 
-endif #NETDEVICES
-
 config NETPOLL
 	def_bool NETCONSOLE
 

