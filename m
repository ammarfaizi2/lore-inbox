Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWDEACw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWDEACw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWDEACJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:02:09 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:52930
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750959AbWDEABy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:54 -0400
Date: Tue, 4 Apr 2006 17:01:11 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linville@tuxdriver.com, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/26] AIRO{,_CS} <-> CRYPTO fixes
Message-ID: <20060405000111.GW27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="airo-_cs-crypto-fixes.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CRYPTO is a helper variable, and to make it easier for users, it should 
therefore select'ed and not be listed in the dependencies.

drivers/net/wireless/airo.c requires CONFIG_CRYPTO for compilations.

Therefore, AIRO_CS also has to select CRYPTO.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/wireless/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.16.1.orig/drivers/net/wireless/Kconfig
+++ linux-2.6.16.1/drivers/net/wireless/Kconfig
@@ -239,7 +239,8 @@ config IPW2200_DEBUG
 
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
-	depends on NET_RADIO && ISA_DMA_API && CRYPTO && (PCI || BROKEN)
+ 	depends on NET_RADIO && ISA_DMA_API && (PCI || BROKEN)
+	select CRYPTO
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet ISA and
 	  PCI 802.11 wireless cards.
@@ -388,6 +389,7 @@ config PCMCIA_SPECTRUM
 config AIRO_CS
 	tristate "Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards"
 	depends on NET_RADIO && PCMCIA && (BROKEN || !M32R)
+	select CRYPTO
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet PCMCIA
 	  802.11 wireless cards.  This driver is the same as the Aironet

--
