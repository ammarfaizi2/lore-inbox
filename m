Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264329AbUE3Thd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUE3Thd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 15:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUE3Th1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 15:37:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29937 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264329AbUE3ThO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 15:37:14 -0400
Date: Sun, 30 May 2004 21:37:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>,
       Danny ter Haar <dth@dth.net>, wa1ter@myrealbox.com,
       dth@ncc1701.cistron.net, Netdev <netdev@oss.sgi.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Re: Gigabit Kconfig problems with yesterday's update
Message-ID: <20040530193706.GG13111@fs.tum.de>
References: <40B8A37D.1090802@myrealbox.com> <20040530134544.GE13111@fs.tum.de> <20040530143734.GA24627@dth.net> <20040530094120.61b22d2e.rddunlap@osdl.org> <40BA1F25.4080402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BA1F25.4080402@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 01:51:33PM -0400, Jeff Garzik wrote:

> NET_GIGE is rightly dependent on NET_ETHERNET, as it is a subset.
> 
> I wonder if the attached patch "fixes" peoples config problems :)
> 
> ===== drivers/net/Kconfig 1.74 vs edited =====
> --- 1.74/drivers/net/Kconfig	2004-05-27 16:42:40 -04:00
> +++ edited/drivers/net/Kconfig	2004-05-30 13:49:48 -04:00
> @@ -163,7 +163,7 @@
>  	depends on NETDEVICES
>  
>  config NET_ETHERNET
> -	bool "Ethernet (10 or 100Mbit)"
> +	bool "Ethernet (10/100/1000/10000 Mbit)"
>  	---help---
>  	  Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
>  	  type of Local Area Network (LAN) in universities and companies.


This is not sufficient since it's still under the
"Ethernet (10 or 100Mbit)" menu.

What about the patch below?

cu
Adrian

--- linux-2.6.7-rc2-full/drivers/net/Kconfig.old	2004-05-30 21:29:46.000000000 +0200
+++ linux-2.6.7-rc2-full/drivers/net/Kconfig	2004-05-30 21:34:42.000000000 +0200
@@ -159,11 +159,8 @@
 #	Ethernet
 #
 
-menu "Ethernet (10 or 100Mbit)"
-	depends on NETDEVICES
-
 config NET_ETHERNET
-	bool "Ethernet (10 or 100Mbit)"
+	bool "Ethernet (10/100/1000/10000 Mbit)"
 	---help---
 	  Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
 	  type of Local Area Network (LAN) in universities and companies.
@@ -188,6 +185,9 @@
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about Ethernet network cards. If unsure, say N.
 
+menu "Ethernet (10/100 Mbit)"
+	depends on NET_ETHERNET
+
 config MII
 	tristate "Generic Media Independent Interface device support"
 	depends on NET_ETHERNET
@@ -1875,7 +1875,7 @@
 #
 
 menu "Gigabit Ethernet (1000/10000 Mbit)"
-	depends on NETDEVICES
+	depends on NET_ETHERNET
 
 config NET_GIGE
 	bool "Gigabit Ethernet (1000/10000 Mbit) controller support"
