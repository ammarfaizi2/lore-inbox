Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268664AbTCCTp5>; Mon, 3 Mar 2003 14:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268742AbTCCTp5>; Mon, 3 Mar 2003 14:45:57 -0500
Received: from camus.xss.co.at ([194.152.162.19]:34062 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S268664AbTCCTpy>;
	Mon, 3 Mar 2003 14:45:54 -0500
Message-ID: <3E63B356.6000801@xss.co.at>
Date: Mon, 03 Mar 2003 20:56:06 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.21-pre5]: make xconfig fails on drivers/net/Config.in
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090403020402010505040102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090403020402010505040102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

As the subject says: "make xconfig" complains about an
"unknown command" in drivers/net/Config.in

root@install:/usr/src/linux-2.4.21-pre5 {506} $ make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.21-pre5-ac1/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/net/Config.in: 188: unknown command
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.21-pre5-ac1/scripts'
make: *** [xconfig] Error 2

It turns out, "make xconfig" doesn't know the token "define_mbool",
used in this file. "make menuconfig" works without complaints...

The attached patch makes it work even with "make xconfig"
(changes "define_mbool" to "define_bool"), though I don't
know if this maintains the intended behaviour. Please check.

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Y7MfxJmyeGcXPhERAu5HAJ9LrCFw7VSxE63YDTICNEkcrnJWLQCdFtiF
BmO0DBhqFT+HVr0Da1Eq9EQ=
=clCd
-----END PGP SIGNATURE-----

--------------090403020402010505040102
Content-Type: text/plain;
 name="Config.in.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Config.in.diff"

--- linux-2.4.21-pre5/drivers/net/Config.in.orig	Mon Mar  3 20:26:07 2003
+++ linux-2.4.21-pre5/drivers/net/Config.in	Mon Mar  3 20:26:23 2003
@@ -185,7 +185,7 @@
       dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102 $CONFIG_PCI
       dep_tristate '    EtherExpressPro/100 support (eepro100, original Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI
       if [ "$CONFIG_VISWS" = "y" ]; then
-         define_mbool CONFIG_EEPRO100_PIO y
+         define_bool CONFIG_EEPRO100_PIO y
       else
          dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO $CONFIG_EEPRO100
       fi  

--------------090403020402010505040102--

