Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUGICIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUGICIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUGICIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:08:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:17577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262744AbUGICHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:07:51 -0400
Date: Thu, 8 Jul 2004 19:06:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Panin <pazke@donpac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] 2.6.7-mm6, fix CRC16 misnaming
Message-Id: <20040708190634.2779f1cb.akpm@osdl.org>
In-Reply-To: <10892916781086@donpac.ru>
References: <10892916781086@donpac.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin <pazke@donpac.ru> wrote:
>
> As pointed by Thomas Sailer, crc16.c module contains CRC16-CCITT (x^16 + x^12 + x^5 + 1)
>  implementation, not IBM CRC16 (x^16 + x^15 + x^2 + 1) one. Looks like we need to rename
>  it accordingly and this patchset does exactly this.

Needs this:


drivers/net/hamradio/Kconfig:116:warning: 'select' used by config symbol 'BAYCOM_SER_FDX' refer to undefined symbol 'CRC16'
drivers/net/hamradio/Kconfig:136:warning: 'select' used by config symbol 'BAYCOM_SER_HDX' refer to undefined symbol 'CRC16'
drivers/net/hamradio/Kconfig:154:warning: 'select' used by config symbol 'BAYCOM_PAR' refer to undefined symbol 'CRC16'
drivers/net/hamradio/Kconfig:169:warning: 'select' used by config symbol 'BAYCOM_EPP' refer to undefined symbol 'CRC16'
net/irda/Kconfig:8:warning: 'select' used by config symbol 'IRDA' refer to undefined symbol 'CRC16'
drivers/net/Kconfig:1749:warning: 'select' used by config symbol 'VIA_VELOCITY' refer to undefined symbol 'CRC16'
drivers/net/Kconfig:2465:warning: 'select' used by config symbol 'PPP_ASYNC' refer to undefined symbol 'CRC16'
drivers/isdn/hisax/Kconfig:403:warning: 'select' used by config symbol 'HISAX_ST5481' refer to undefined symbol 'CRC16'
drivers/isdn/hisax/Kconfig:7:warning: 'select' used by config symbol 'ISDN_DRV_HISAX' refer to undefined symbol 'CRC16'
drivers/isdn/tpam/Kconfig:7:warning: 'select' used by config symbol 'ISDN_DRV_TPAM' refer to undefined symbol 'CRC16'

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/isdn/hisax/Kconfig   |    4 ++--
 25-akpm/drivers/isdn/tpam/Kconfig    |    2 +-
 25-akpm/drivers/net/Kconfig          |    4 ++--
 25-akpm/drivers/net/hamradio/Kconfig |    8 ++++----
 25-akpm/net/irda/Kconfig             |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff -puN drivers/net/hamradio/Kconfig~crc16-kconfig-touchups drivers/net/hamradio/Kconfig
--- 25/drivers/net/hamradio/Kconfig~crc16-kconfig-touchups	2004-07-08 19:06:03.962450720 -0700
+++ 25-akpm/drivers/net/hamradio/Kconfig	2004-07-08 19:06:03.973449048 -0700
@@ -113,7 +113,7 @@ config SCC_TRXECHO
 config BAYCOM_SER_FDX
 	tristate "BAYCOM ser12 fullduplex driver for AX.25"
 	depends on AX25
-	select CRC16
+	select CRC_CCITT
 	---help---
 	  This is one of two drivers for Baycom style simple amateur radio
 	  modems that connect to a serial interface. The driver supports the
@@ -133,7 +133,7 @@ config BAYCOM_SER_FDX
 config BAYCOM_SER_HDX
 	tristate "BAYCOM ser12 halfduplex driver for AX.25"
 	depends on AX25
-	select CRC16
+	select CRC_CCITT
 	---help---
 	  This is one of two drivers for Baycom style simple amateur radio
 	  modems that connect to a serial interface. The driver supports the
@@ -151,7 +151,7 @@ config BAYCOM_SER_HDX
 config BAYCOM_PAR
 	tristate "BAYCOM picpar and par96 driver for AX.25"
 	depends on PARPORT && AX25
-	select CRC16
+	select CRC_CCITT
 	---help---
 	  This is a driver for Baycom style simple amateur radio modems that
 	  connect to a parallel interface. The driver supports the picpar and
@@ -166,7 +166,7 @@ config BAYCOM_PAR
 config BAYCOM_EPP
 	tristate "BAYCOM epp driver for AX.25"
 	depends on PARPORT && AX25 && !64BIT
-	select CRC16
+	select CRC_CCITT
 	---help---
 	  This is a driver for Baycom style simple amateur radio modems that
 	  connect to a parallel interface. The driver supports the EPP
diff -puN net/irda/Kconfig~crc16-kconfig-touchups net/irda/Kconfig
--- 25/net/irda/Kconfig~crc16-kconfig-touchups	2004-07-08 19:06:03.964450416 -0700
+++ 25-akpm/net/irda/Kconfig	2004-07-08 19:06:03.973449048 -0700
@@ -5,7 +5,7 @@
 menuconfig IRDA
 	depends on NET
 	tristate "IrDA (infrared) subsystem support"
-	select CRC16
+	select CRC_CCITT
 	---help---
 	  Say Y here if you want to build support for the IrDA (TM) protocols.
 	  The Infrared Data Associations (tm) specifies standards for wireless
diff -puN drivers/net/Kconfig~crc16-kconfig-touchups drivers/net/Kconfig
--- 25/drivers/net/Kconfig~crc16-kconfig-touchups	2004-07-08 19:06:03.966450112 -0700
+++ 25-akpm/drivers/net/Kconfig	2004-07-08 19:06:03.976448592 -0700
@@ -1746,7 +1746,7 @@ config VIA_VELOCITY
 	tristate "VIA Velocity support"
 	depends on NET_PCI && PCI
 	select CRC32
-	select CRC16
+	select CRC_CCITT
 	select MII
 	help
 	  If you have a VIA "Velocity" based network card say Y here.
@@ -2462,7 +2462,7 @@ config PPP_FILTER
 config PPP_ASYNC
 	tristate "PPP support for async serial ports"
 	depends on PPP
-	select CRC16
+	select CRC_CCITT
 	---help---
 	  Say Y (or M) here if you want to be able to use PPP over standard
 	  asynchronous serial ports, such as COM1 or COM2 on a PC.  If you use
diff -puN drivers/isdn/hisax/Kconfig~crc16-kconfig-touchups drivers/isdn/hisax/Kconfig
--- 25/drivers/isdn/hisax/Kconfig~crc16-kconfig-touchups	2004-07-08 19:06:03.968449808 -0700
+++ 25-akpm/drivers/isdn/hisax/Kconfig	2004-07-08 19:06:03.977448440 -0700
@@ -4,7 +4,7 @@ menu "Passive cards"
 
 config ISDN_DRV_HISAX
 	tristate "HiSax SiemensChipSet driver support"
-	select CRC16
+	select CRC_CCITT
 	---help---
 	  This is a driver supporting the Siemens chipset on various
 	  ISDN-cards (like AVM A1, Elsa ISDN cards, Teles S0-16.0, Teles
@@ -400,7 +400,7 @@ comment "HiSax sub driver modules"
 config HISAX_ST5481
 	tristate "ST5481 USB ISDN modem (EXPERIMENTAL)"
 	depends on USB && EXPERIMENTAL
-	select CRC16
+	select CRC_CCITT
 	help
 	  This enables the driver for ST5481 based USB ISDN adapters,
 	  e.g. the BeWan Gazel 128 USB
diff -puN drivers/isdn/tpam/Kconfig~crc16-kconfig-touchups drivers/isdn/tpam/Kconfig
--- 25/drivers/isdn/tpam/Kconfig~crc16-kconfig-touchups	2004-07-08 19:06:03.969449656 -0700
+++ 25-akpm/drivers/isdn/tpam/Kconfig	2004-07-08 19:06:03.977448440 -0700
@@ -4,7 +4,7 @@
 config ISDN_DRV_TPAM
 	tristate "Auvertech TurboPAM support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ISDN_I4L && PCI
-	select CRC16
+	select CRC_CCITT
 	help
 	  This enables support for the Auvertech TurboPAM ISDN-card.
 	  For running this card, additional firmware is necessary, which has
_

