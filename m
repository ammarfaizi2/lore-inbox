Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbULDWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbULDWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 17:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULDWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 17:18:56 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:49025 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261178AbULDWSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 17:18:53 -0500
Message-ID: <41B237C6.9030404@rjmx.net>
Date: Sat, 04 Dec 2004 17:18:46 -0500
From: Ron Murray <rjmx@rjmx.net>
Reply-To: rjmx@rjmx.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041121)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CS461x gameport code isn't being included in build
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I've found a typo in drivers/input/gameport/Makefile in kernel
2.6.9 which effectively prevents the CS461x gameport code from
being included. Here's the diff:

--- linux-2.6.9/drivers/input/gameport/Makefile.orig	2004-10-18 
17:53:06.000000000 -0400
+++ linux-2.6.9/drivers/input/gameport/Makefile	2004-12-04 
16:51:12.000000000 -0500
@@ -5,7 +5,7 @@
  # Each configuration option enables a list of files.

  obj-$(CONFIG_GAMEPORT)		+= gameport.o
-obj-$(CONFIG_GAMEPORT_CS461X)	+= cs461x.o
+obj-$(CONFIG_GAMEPORT_CS461x)	+= cs461x.o
  obj-$(CONFIG_GAMEPORT_EMU10K1)	+= emu10k1-gp.o
  obj-$(CONFIG_GAMEPORT_FM801)	+= fm801-gp.o
  obj-$(CONFIG_GAMEPORT_L4)	+= lightning.o



    Note: the change is to a lower-case 'x' in
'CONFIG_GAMEPORT_CS461x'. It's hard to see.

    Kconfig in the same directory has


 >> config GAMEPORT_CS461x
 >> 	tristate "Crystal SoundFusion gameport support"
 >> 	depends on GAMEPORT


    This patch brings the Makefile into line with the spelling in
Kconfig.

Signed-off-by: Ron Murray <rjmx@rjmx.net>

  .....Ron

-- 
Ron Murray   (rjmx@rjmx.net)
http://www.rjmx.net/~ron
GPG Public Key Fingerprint: F2C1 FC47 5EF7 0317 133C  D66B 8ADA A3C4 
D86C 74DE
