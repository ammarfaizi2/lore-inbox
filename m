Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbULCJIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbULCJIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbULCJIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:08:12 -0500
Received: from main.gmane.org ([80.91.229.2]:10472 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262104AbULCJGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:06:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: [PATCH hostap] fix Kconfig typos and missing select CRYPTO (was:
 2.6.10-rc2-mm4)
Date: Fri, 03 Dec 2004 01:06:28 -0800
Message-ID: <41B02C94.9090700@triplehelix.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000907090501030104020309"
X-Complaints-To: usenet@sea.gmane.org
Cc: hostap@shmoo.com, jgarzik@pobox.com
X-Gmane-NNTP-Posting-Host: adsl-68-126-237-170.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907090501030104020309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/

   CC [M]  drivers/net/wireless/hostap/hostap_crypt_wep.o
drivers/net/wireless/hostap/hostap_crypt_wep.c:24:2: #error 
CONFIG_CRYPTO is required to build this module.
make[4]: *** [drivers/net/wireless/hostap/hostap_crypt_wep.o] Error 1
make[3]: *** [drivers/net/wireless/hostap] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Here's a patchlet that fixes some Kconfig typos and adds missing select 
CRYPTO for each hostap_crypt_* option.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

-- 
Joshua Kwan

--------------000907090501030104020309
Content-Type: text/x-patch;
 name="hostap-kconfig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hostap-kconfig.patch"

--- linux-2.6.9/drivers/net/wireless/hostap/Kconfig~	2004-12-03 00:58:27.000000000 -0800
+++ linux-2.6.9/drivers/net/wireless/hostap/Kconfig	2004-12-03 00:59:01.000000000 -0800
@@ -25,29 +25,32 @@
 config HOSTAP_WEP
 	tristate "IEEE 802.11 WEP encryption"
 	depends on HOSTAP
+	select CRYPTO
 	---help---
 	Software implementation of IEEE 802.11 WEP encryption.
 
 	This can be compiled as a modules and it will be called
-	"hostap_cryp_wep.ko".
+	"hostap_crypt_wep.ko".
 
 config HOSTAP_TKIP
 	tristate "IEEE 802.11 TKIP encryption"
 	depends on HOSTAP
+	select CRYPTO
 	---help---
 	Software implementation of IEEE 802.11 TKIP encryption.
 
 	This can be compiled as a modules and it will be called
-	"hostap_cryp_tkip.ko".
+	"hostap_crypt_tkip.ko".
 
 config HOSTAP_CCMP
 	tristate "IEEE 802.11 CCMP encryption"
 	depends on HOSTAP
+	select CRYPTO
 	---help---
 	Software implementation of IEEE 802.11 CCMP encryption.
 
 	This can be compiled as a modules and it will be called
-	"hostap_cryp_ccmp.ko".
+	"hostap_crypt_ccmp.ko".
 
 config HOSTAP_FIRMWARE
 	bool "Support downloading firmware images with Host AP driver"

--------------000907090501030104020309--

