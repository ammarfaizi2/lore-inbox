Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWHCP7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWHCP7a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWHCP7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:59:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44046 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964831AbWHCP73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:59:29 -0400
Date: Thu, 3 Aug 2006 17:59:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org,
       b.buschinski@web.de
Subject: [2.6 patch] DVB_CORE must select I2C
Message-ID: <20060803155925.GA25692@stusta.de>
References: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc2-mm1:
>...
> +dvb-core-needs-i2c.patch
>...
>  DVB fixes
>...

This means people who observed a compile error will now have the DVB 
support silently removed from their kernel.

Please replace it with the patch below.

cu
Adrian


<--  snip  -->


DVB_CORE=y, I2C=n resulted in the following compile error reported by 
Bernd Buschinski in kernel Bugzilla #6843:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `dvb_pll_sleep':
dvb-pll.c:(.text+0x80020): undefined reference to `i2c_transfer'
drivers/built-in.o: In function `dvb_pll_set_params':
dvb-pll.c:(.text+0x80326): undefined reference to `i2c_transfer'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc2-mm1-modular/drivers/media/dvb/dvb-core/Kconfig.old	2006-08-03 17:53:54.000000000 +0200
+++ linux-2.6.18-rc2-mm1-modular/drivers/media/dvb/dvb-core/Kconfig	2006-08-03 17:54:06.000000000 +0200
@@ -1,6 +1,7 @@
 config DVB_CORE
 	tristate "DVB Core Support"
 	depends on DVB
+	select I2C
 	select CRC32
 	help
 	  DVB core utility functions for device handling, software fallbacks etc.

