Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXB2m>; Sat, 23 Dec 2000 20:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLXB2d>; Sat, 23 Dec 2000 20:28:33 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:40201 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S129458AbQLXB2Y>; Sat, 23 Dec 2000 20:28:24 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0test13pre4-ac2 fix for CONFIG_SOUND_YMFPCI problem
Date: Sat, 23 Dec 2000 17:58:57 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_92S1NP3Y91PGMDCD26J0"
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <00122317585703.07144@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_92S1NP3Y91PGMDCD26J0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

With 2.4.0-test13-pre4-ac2, I get the following error with make xconfig:

make[1]: Leaving directory `/usr/src/linux-2.4.0-test13-pre4-ac2/scripts'
wish -f scripts/kconfig.tk
ERROR - Attempting to write value for unconfigured variable 
(CONFIG_SOUND_YMFPCI).

It appears that in the 2.4.0test13pre4-ac2 patch, the method of configuring
CONFIG_SOUND_YMFPCI was changed by adding a 
dep_tristate '  Yamaha PCI native mode support (EXPERIMENTAL)' and an
if test at lines 82-84 of drivers/sound/Config.in.

However, the old code with a
dep_tristate '    Yamaha YMF7xx PCI audio (native mode) (EXPERIMENTAL)'
and associated if test at lines 149-151 remained in the Config.in file.

It seems that these two sections of code are interferring with each other.

The following patch removes the older section of code associated with
CONFIG_SOUND_YMFPCI.

Due to the very long lines, this patch may suffer readability due to 
wraparounds, so I will attach a copy.

Steven

diff -u linux/drivers/sound/Config.in.orig linux/drivers/sound/Config.in
--- linux/drivers/sound/Config.in.orig  Sat Dec 23 14:30:53 2000
+++ linux/drivers/sound/Config.in       Sat Dec 23 17:28:28 2000
@@ -146,9 +146,6 @@
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 
$CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2, SA3, and SAx based PnP cards' 
CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha YMF7xx PCI audio (legacy mode)' 
CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
-   if [ "$CONFIG_SOUND_YMPCI" = "n" ]; then
-      dep_tristate '    Yamaha YMF7xx PCI audio (native mode) 
(EXPERIMENTAL)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI 
$CONFIG_EXPERIMENTAL
-   fi
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 
$CONFIG_SOUND_OSS
   
    dep_tristate '    Gallant Audio Cards (SC-6000 and SC-6600 based)' 
CONFIG_SOUND_AEDSP16 $CONFIG_SOUND_OSS



--------------Boundary-00=_92S1NP3Y91PGMDCD26J0
Content-Type: text/plain;
  name="ymfpci-patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ymfpci-patch"

ZGlmZiAtdSBsaW51eC9kcml2ZXJzL3NvdW5kL0NvbmZpZy5pbi5vcmlnIGxpbnV4L2RyaXZlcnMv
c291bmQvQ29uZmlnLmluCi0tLSBsaW51eC9kcml2ZXJzL3NvdW5kL0NvbmZpZy5pbi5vcmlnCVNh
dCBEZWMgMjMgMTQ6MzA6NTMgMjAwMAorKysgbGludXgvZHJpdmVycy9zb3VuZC9Db25maWcuaW4J
U2F0IERlYyAyMyAxNzoyODoyOCAyMDAwCkBAIC0xNDYsOSArMTQ2LDYgQEAKICAgIGRlcF90cmlz
dGF0ZSAnICAgIFlhbWFoYSBPUEwzLVNBMSBhdWRpbyBjb250cm9sbGVyJyBDT05GSUdfU09VTkRf
T1BMM1NBMSAkQ09ORklHX1NPVU5EX09TUwogICAgZGVwX3RyaXN0YXRlICcgICAgWWFtYWhhIE9Q
TDMtU0EyLCBTQTMsIGFuZCBTQXggYmFzZWQgUG5QIGNhcmRzJyBDT05GSUdfU09VTkRfT1BMM1NB
MiAkQ09ORklHX1NPVU5EX09TUwogICAgZGVwX3RyaXN0YXRlICcgICAgWWFtYWhhIFlNRjd4eCBQ
Q0kgYXVkaW8gKGxlZ2FjeSBtb2RlKScgQ09ORklHX1NPVU5EX1lNUENJICRDT05GSUdfU09VTkRf
T1NTICRDT05GSUdfUENJCi0gICBpZiBbICIkQ09ORklHX1NPVU5EX1lNUENJIiA9ICJuIiBdOyB0
aGVuCi0gICAgICBkZXBfdHJpc3RhdGUgJyAgICBZYW1haGEgWU1GN3h4IFBDSSBhdWRpbyAobmF0
aXZlIG1vZGUpIChFWFBFUklNRU5UQUwpJyBDT05GSUdfU09VTkRfWU1GUENJICRDT05GSUdfU09V
TkRfT1NTICRDT05GSUdfUENJICRDT05GSUdfRVhQRVJJTUVOVEFMCi0gICBmaQogICAgZGVwX3Ry
aXN0YXRlICcgICAgNjg1MCBVQVJUIHN1cHBvcnQnIENPTkZJR19TT1VORF9VQVJUNjg1MCAkQ09O
RklHX1NPVU5EX09TUwogICAKICAgIGRlcF90cmlzdGF0ZSAnICAgIEdhbGxhbnQgQXVkaW8gQ2Fy
ZHMgKFNDLTYwMDAgYW5kIFNDLTY2MDAgYmFzZWQpJyBDT05GSUdfU09VTkRfQUVEU1AxNiAkQ09O
RklHX1NPVU5EX09TUwo=

--------------Boundary-00=_92S1NP3Y91PGMDCD26J0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
