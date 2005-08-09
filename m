Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbVHIAlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbVHIAlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVHIAlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:41:06 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25361 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932271AbVHIAlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:41:04 -0400
Date: Tue, 9 Aug 2005 02:41:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jiri Slaby <jirislaby@gmail.com>, jgarzik@pobox.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Subject: [-mm patch] SIS190 must select MII
Message-ID: <20050809004100.GS4006@stusta.de>
References: <42F7F837.6080800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F7F837.6080800@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 02:26:31AM +0200, Jiri Slaby wrote:
> Hello, i find out this problem:
> #make O=../bu allmodconfig
> ...
> #make O=../bu all
> ...
>  LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x63c87): In function `sis190_get_settings':
> /l/latest/xxx/drivers/net/sis190.c:1656: undefined reference to 
> `mii_ethtool_gset'
>...

Obvious bug in git-netdev-sis190.patch, fix below.

cu
Adrian


<--  snip  -->


SIS190 must select MII since it's using it.

While I was editing the Kconfig entry, I also converted the spaces to 
tabs.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc5-mm1-full/drivers/net/Kconfig.old	2005-08-09 02:32:14.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/drivers/net/Kconfig	2005-08-09 02:33:12.000000000 +0200
@@ -1924,14 +1924,15 @@
 	  If in doubt, say Y.
 
 config SIS190
-      tristate "SiS190 gigabit ethernet support"
-      depends on PCI
-      select CRC32
-      ---help---
-        Say Y here if you have a SiS 190 PCI Gigabit Ethernet adapter.
+	tristate "SiS190 gigabit ethernet support"
+	depends on PCI
+	select CRC32
+	select MII
+	---help---
+	  Say Y here if you have a SiS 190 PCI Gigabit Ethernet adapter.
 
-        To compile this driver as a module, choose M here: the module
-        will be called sis190.  This is recommended.
+	  To compile this driver as a module, choose M here: the module
+	  will be called sis190.  This is recommended.
 
 config SKGE
 	tristate "New SysKonnect GigaEthernet support (EXPERIMENTAL)"

