Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSBIJr6>; Sat, 9 Feb 2002 04:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSBIJrt>; Sat, 9 Feb 2002 04:47:49 -0500
Received: from pop.gmx.net ([213.165.64.20]:55604 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288800AbSBIJrl>;
	Sat, 9 Feb 2002 04:47:41 -0500
From: Sebastian Roth <xsebbi@gmx.de>
Reply-To: xsebbi@gmx.de
Message-Id: <200202091029.30256@xsebbi.de>
To: davej@suse.de
Subject: [PATCH][2.5.3-dj4] Compile Error at 8139too.c
Date: Sat, 9 Feb 2002 10:48:44 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_89F9JTIRFV2Z5HUS4OSM"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_89F9JTIRFV2Z5HUS4OSM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi there,

just a compile error:

gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    
-DKBUILD_BASENAME=8139too  -c -o 8139too.o 8139too.c
8139too.c:167: redefinition of `debug'
8139too.c:164: `debug' previously defined here
make[3]: *** [8139too.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [_dir_drivers] Error 2

This patch solves the problem:

--- linux-2.5/drivers/net/8139too.c     Sat Feb  9 10:44:11 2002
+++ linux-beta/drivers/net/8139too.c    Sat Feb  9 10:44:50 2002
@@ -163,9 +163,6 @@
 /* bitmapped message enable number */
 static int debug = -1;
 
-/* bitmapped message enable number */
-static int debug = -1;
-
 /* Size of the in-memory receive ring. */
 #define RX_BUF_LEN_IDX 2       /* 0==8K, 1==16K, 2==32K, 3==64K */
 #define RX_BUF_LEN     (8192 << RX_BUF_LEN_IDX)

patch is against 2.5.3-dj4

Bye,
Sebastian




--------------Boundary-00=_89F9JTIRFV2Z5HUS4OSM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="8139patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="8139patch"

LS0tIGxpbnV4LTIuNS9kcml2ZXJzL25ldC84MTM5dG9vLmMJU2F0IEZlYiAgOSAxMDo0NDoxMSAy
MDAyCisrKyBsaW51eC1iZXRhL2RyaXZlcnMvbmV0LzgxMzl0b28uYwlTYXQgRmViICA5IDEwOjQ0
OjUwIDIwMDIKQEAgLTE2Myw5ICsxNjMsNiBAQAogLyogYml0bWFwcGVkIG1lc3NhZ2UgZW5hYmxl
IG51bWJlciAqLwogc3RhdGljIGludCBkZWJ1ZyA9IC0xOwogCi0vKiBiaXRtYXBwZWQgbWVzc2Fn
ZSBlbmFibGUgbnVtYmVyICovCi1zdGF0aWMgaW50IGRlYnVnID0gLTE7Ci0KIC8qIFNpemUgb2Yg
dGhlIGluLW1lbW9yeSByZWNlaXZlIHJpbmcuICovCiAjZGVmaW5lIFJYX0JVRl9MRU5fSURYCTIJ
LyogMD09OEssIDE9PTE2SywgMj09MzJLLCAzPT02NEsgKi8KICNkZWZpbmUgUlhfQlVGX0xFTgko
ODE5MiA8PCBSWF9CVUZfTEVOX0lEWCkK

--------------Boundary-00=_89F9JTIRFV2Z5HUS4OSM--
