Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbTGLNj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTGLNj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:39:57 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:42421 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S265667AbTGLNjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:39:54 -0400
Date: Sat, 12 Jul 2003 07:49:19 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: linux-2.4.22-pre5 drm/agpsupport unresolved symbols (fwd)
Message-ID: <Pine.LNX.4.44.0307120747530.1986-200000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1197356979-1876980671-1058017759=:1986"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1197356979-1876980671-1058017759=:1986
Content-Type: TEXT/PLAIN; charset=US-ASCII

[And now for the patch, sorry forgot to attach it... *sigh*]

The attached patch fixes the following compile error when building
agpsupport as a module.  This is against 2.4.22pre5.

Marcelo, please apply as it's a very simple patch the adds the symbol to an
enum in include/linux/agp_backend.h and adds a missed break statement in
drm-4.0/agpsupport.c.

**********
gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/kernel-2.4.22pre5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/redhat/BUILD/kernel-2.4.22pre5/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=agpsupport  -c -o agpsupport.o agpsupport.c
agpsupport.c: In function `drm_agp_bind':
agpsupport.c:215: warning: concatenation of string literals with __FUNCTION__ is deprecated
agpsupport.c: In function `drm_agp_init':
agpsupport.c:280: `VIA_APOLLO_P4X400' undeclared (first use in this function)
agpsupport.c:280: (Each undeclared identifier is reported only once
agpsupport.c:280: for each function it appears in.)
make[3]: *** [agpsupport.o] Error 1
make[3]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.22pre5/drivers/char/drm-4.0'
make[2]: *** [_modsubdir_drm-4.0] Error 2
make[2]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.22pre5/drivers/char'
make[1]: *** [_modsubdir_char] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.4.22pre5/drivers'
make: *** [_mod_drivers] Error 2
******************

Thanks and regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  





---1197356979-1876980671-1058017759=:1986
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.4.22pre5-drm-compile.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0307120749190.1986@cafe.hardrock.org>
Content-Description: patch
Content-Disposition: attachment; filename="2.4.22pre5-drm-compile.patch"

LS0tIGxpbnV4LTIuNC4yMnByZTUvaW5jbHVkZS9saW51eC9hZ3BfYmFja2Vu
ZC5ofgkyMDAzLTA3LTEyIDE0OjM2OjU0LjAwMDAwMDAwMCArMDcwMA0KKysr
IGxpbnV4LTIuNC4yMnByZTUvaW5jbHVkZS9saW51eC9hZ3BfYmFja2VuZC5o
CTIwMDMtMDctMTIgMTQ6MzY6NTQuMDAwMDAwMDAwICswNzAwDQpAQCAtNjYs
NiArNjYsNyBAQA0KIAlWSUFfQVBPTExPX0tNMjY2LA0KIAlWSUFfQVBPTExP
X0tUNDAwLA0KIAlWSUFfQVBPTExPX1A0TTI2NiwNCisJVklBX0FQT0xMT19Q
NFg0MDAsDQogCVNJU19HRU5FUklDLA0KIAlBTURfR0VORVJJQywNCiAJQU1E
X0lST05HQVRFLA0KLS0tIGxpbnV4LTIuNC4yMnByZTUvZHJpdmVycy9jaGFy
L2RybS00LjAvYWdwc3VwcG9ydC5jfgkyMDAzLTA3LTEyIDE0OjM2OjU5LjAw
MDAwMDAwMCArMDcwMA0KKysrIGxpbnV4LTIuNC4yMnByZTUvZHJpdmVycy9j
aGFyL2RybS00LjAvYWdwc3VwcG9ydC5jCTIwMDMtMDctMTIgMTQ6MzY6NTku
MDAwMDAwMDAwICswNzAwDQpAQCAtMjc4LDYgKzI3OCw3IEBADQogCQljYXNl
IFZJQV9BUE9MTE9fS1Q0MDA6ICBoZWFkLT5jaGlwc2V0ID0gIlZJQSBBcG9s
bG8gS1Q0MDAiOw0KIAkJCWJyZWFrOw0KIAkJY2FzZSBWSUFfQVBPTExPX1A0
WDQwMDoJaGVhZC0+Y2hpcHNldCA9ICJWSUEgQXBvbGxvIFA0WDQwMCI7DQor
CQkJYnJlYWs7DQogI2VuZGlmDQogDQogCQljYXNlIFZJQV9BUE9MTE9fUFJP
OiAJaGVhZC0+Y2hpcHNldCA9ICJWSUEgQXBvbGxvIFBybyI7DQo=
---1197356979-1876980671-1058017759=:1986--
