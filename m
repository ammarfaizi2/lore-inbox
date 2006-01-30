Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWA3SXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWA3SXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 13:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWA3SXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 13:23:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18447 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751283AbWA3SXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 13:23:18 -0500
Date: Mon, 30 Jan 2006 19:23:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Gabriel C." <crazy@pimpmylinux.org>, linville@tuxdriver.com
Cc: linux-kernel@vger.kernel.org, da.crew@gmx.net, netdev@vger.kernel.org
Subject: [2.6 patch] PCMCIA=m, HOSTAP_CS=y is not a legal configuration
Message-ID: <20060130182317.GD3655@stusta.de>
References: <20060130133833.7b7a3f8e@zwerg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130133833.7b7a3f8e@zwerg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 01:38:33PM +0100, Gabriel C. wrote:

> Hello,

Hallo Gabriel,

> I got this compile error with 2.6.16-rc1-mm4 , config attached. 
> 
> 
>   LD      .tmp_vmlinux1
>...
> `sandisk_set_iobase':hostap_cs.c:(.text+0x801ad): undefined reference
> to `pcmcia_access_configuration_register' :hostap_cs.c:(.text+0x801f3):
> undefined reference to `pcmcia_access_configuration_register'
> drivers/built-in.o: In function
> `prism2_pccard_cor_sreset':hostap_cs.c:(.text+0x80254): undefined
> reference to
> `pcmcia_access_configuration_register' :hostap_cs.c:(.text+0x80289):
> undefined reference to
> `pcmcia_access_configuration_register' :hostap_cs.c:(.text+0x80325):
> undefined reference to `pcmcia_access_configuration_register'
> [more errors]
>...

thanks for your report, a patch is below.

> Gabriel 

cu
Adrian


<--  snip  -->


CONFIG_PCMCIA=m, CONFIG_HOSTAP_CS=y doesn't compile.

Reported by "Gabriel C." <crazy@pimpmylinux.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm4/drivers/net/wireless/hostap/Kconfig.old	2006-01-30 19:00:44.000000000 +0100
+++ linux-2.6.16-rc1-mm4/drivers/net/wireless/hostap/Kconfig	2006-01-30 19:01:04.000000000 +0100
@@ -75,7 +75,7 @@
 
 config HOSTAP_CS
 	tristate "Host AP driver for Prism2/2.5/3 PC Cards"
-	depends on PCMCIA!=n && HOSTAP
+	depends on PCMCIA && HOSTAP
 	---help---
 	Host AP driver's version for Prism2/2.5/3 PC Cards.
 

