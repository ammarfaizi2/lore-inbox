Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317434AbSFHTn5>; Sat, 8 Jun 2002 15:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSFHTn5>; Sat, 8 Jun 2002 15:43:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:11527 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317434AbSFHTnz>;
	Sat, 8 Jun 2002 15:43:55 -0400
Date: Sat, 8 Jun 2002 21:46:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: davem@redhat.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Networking: ip_gre init corrected
Message-ID: <20020608214620.A4827@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Networking Maintainers.

While playing around with kbuild I stumbled over this warning:
/net/ipv4/ip_gre.c:123: warning: initialization makes integer from pointer without a cast

Looking into the source it seemed that an init function was not properly
initialised, probarly due to added members in net_device.

Attached patch fixes this, but I did not know how to test it.

	Sam

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ip_gre_init.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.471   -> 1.472  
#	   net/ipv4/ip_gre.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/08	sam@mars.ravnborg.org	1.472
# net/ipv4/ip_gre.c: Get rid of warning.
# _init function properly initialised.
# --------------------------------------------
#
diff -Nru a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
--- a/net/ipv4/ip_gre.c	Sat Jun  8 21:37:51 2002
+++ b/net/ipv4/ip_gre.c	Sat Jun  8 21:37:51 2002
@@ -120,11 +120,13 @@
 static int ipgre_fb_tunnel_init(struct net_device *dev);
 
 static struct net_device ipgre_fb_tunnel_dev = {
-	"gre0", 0x0, 0x0, 0x0, 0x0, 0, 0, 0, 0, 0, NULL, ipgre_fb_tunnel_init,
+	name:	"gre0",
+	init: 	ipgre_fb_tunnel_init
 };
 
 static struct ip_tunnel ipgre_fb_tunnel = {
-	NULL, &ipgre_fb_tunnel_dev, {0, }, 0, 0, 0, 0, 0, 0, 0, {"gre0", }
+	dev:	&ipgre_fb_tunnel_dev,
+	parms: { name:"gre0"}
 };
 
 /* Tunnel hash table */

--/9DWx/yDrRhgMJTb--
