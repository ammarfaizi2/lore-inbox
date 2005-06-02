Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFBUNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFBUNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFBULt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:11:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61447 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261316AbVFBUHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:07:05 -0400
Date: Thu, 2 Jun 2005 22:07:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jkmaline@cc.hut.fi, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, hostap@shmoo.com, netdev@oss.sgi.com
Subject: [-mm patch] fix recursive IPW2200 dependencies
Message-ID: <20050602200701.GG4992@stusta.de>
References: <20050601022824.33c8206e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601022824.33c8206e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:28:24AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc5-mm1:
>...
> +git-netdev-we18-ieee80211-wifi.patch
> 
>  Various things added and merged in netdev land.
>...

This results in recursive dependencies:
- IPW2200 depends on NET_RADIO
- IPW2200 selects IEEE80211
- IEEE80211 selects NET_RADIO


This patch fixes the IPW2200 dependencies in a way that they are similar 
to the IPW2100 dependencies.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc5-mm2-full/drivers/net/wireless/Kconfig.old	2005-06-02 22:04:02.000000000 +0200
+++ linux-2.6.12-rc5-mm2-full/drivers/net/wireless/Kconfig	2005-06-02 22:04:40.000000000 +0200
@@ -192,9 +192,8 @@
 
 config IPW2200
 	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
-	depends on NET_RADIO && PCI
+	depends on IEEE80211 && PCI
 	select FW_LOADER
-	select IEEE80211
 	---help---
           A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
 	  Connection adapters. 

