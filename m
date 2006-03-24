Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWCXQ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWCXQ4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWCXQ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:56:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44807 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751142AbWCXQ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:56:21 -0500
Date: Fri, 24 Mar 2006 17:56:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>, linville@tuxdriver.com
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: [2.6 patch] PCMCIA_SPECTRUM must select FW_LOADER
Message-ID: <20060324165619.GG22727@stusta.de>
References: <44241FF9.9070904@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44241FF9.9070904@ums.usu.ru>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 09:36:09PM +0500, Alexander E. Patrakov wrote:
> In linux-2.6.16, it is possible to compile spectrum_cs.ko without enabling 
> firmware loader. Result:
> 
> WARNING: /lib/modules/2.6.16/kernel/drivers/net/wireless/spectrum_cs.ko 
> needs unknown symbol request_firmware

Thanks for your report, a fix is below.

> Alexander E. Patrakov

cu
Adrian


<--  snip  -->


PCMCIA_SPECTRUM must select FW_LOADER.

Reported by "Alexander E. Patrakov" <patrakov@ums.usu.ru>.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm1-full/drivers/net/wireless/Kconfig.old	2006-03-24 17:45:05.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/net/wireless/Kconfig	2006-03-24 17:45:38.000000000 +0100
@@ -397,6 +397,7 @@
 config PCMCIA_SPECTRUM
 	tristate "Symbol Spectrum24 Trilogy PCMCIA card support"
 	depends on NET_RADIO && PCMCIA && HERMES
+	select FW_LOADER
 	---help---
 
 	  This is a driver for 802.11b cards using RAM-loadable Symbol

