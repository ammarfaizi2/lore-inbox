Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSECMkY>; Fri, 3 May 2002 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSECMkY>; Fri, 3 May 2002 08:40:24 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:3883 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S288748AbSECMkX>;
	Fri, 3 May 2002 08:40:23 -0400
Date: Fri, 3 May 2002 14:40:19 +0200 (CEST)
From: Krzysiek Taraszka <dzimi@ep09.kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: PATCH: 2.2.21rc3 ppc isdn patch
Message-ID: <Pine.LNX.4.44.0205031435320.2298-200000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1473552907-1349931730-1020429619=:2298"
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1473552907-1349931730-1020429619=:2298
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi, I tried compile 2.2.21rc3 with ISDN on ppc machine and i had that 
messages:

In file included from 
/home/users/dzimi/rpm/BUILD/linux/include/linux/interrupt.h:52,
                 from hysdn_defs.h:19,
                 from hysdn_sched.c:20:
/home/users/dzimi/rpm/BUILD/linux/include/asm/hardirq.h:4: `NR_CPUS' 
undeclared
here (not in a function)
In file included from 
/home/users/dzimi/rpm/BUILD/linux/include/linux/interrupt.h:53,
                 from hysdn_defs.h:19,
                 from hysdn_sched.c:20:
/home/users/dzimi/rpm/BUILD/linux/include/asm/softirq.h:7: `NR_CPUS' 
undeclared
here (not in a function)
/home/users/dzimi/rpm/BUILD/linux/include/asm/softirq.h: In function 
`start_bh_atomic':
/home/users/dzimi/rpm/BUILD/linux/include/asm/softirq.h:77: warning: 
implicit declaration of function `smp_processor_id'
make[3]: *** [hysdn_sched.o] Error 1

Alan, my patch fix it.

>>-- cut here <<--

--- linux.orig/include/asm-ppc/atomic.h Sun Mar 25 18:31:08 2001
+++ linux/include/asm-ppc/atomic.h      Sun Apr  7 20:38:11 2002
@@ -6,6 +6,9 @@
 #define _ASM_PPC_ATOMIC_H_

 #ifdef __SMP__
+
+#include <asm/smp.h>
+
 typedef struct { volatile int counter; } atomic_t;
 #else
 typedef struct { int counter; } atomic_t;
diff -urN linux.orig/include/asm-ppc/hardirq.h 
linux/include/asm-ppc/hardirq.h
--- linux.orig/include/asm-ppc/hardirq.h        Sun Mar 25 18:31:09 2001
+++ linux/include/asm-ppc/hardirq.h     Sun Apr  7 20:38:49 2002
@@ -1,6 +1,8 @@
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H

+#include <linux/tasks.h>
+
 extern unsigned int ppc_local_irq_count[NR_CPUS];

 /*
>>---------<<


Krzysiek Taraszka

--1473552907-1349931730-1020429619=:2298
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.2.21-ppc-isdn.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0205031440190.2298@ep09.kernel.pl>
Content-Description: Patch
Content-Disposition: attachment; filename="2.2.21-ppc-isdn.patch"

ZGlmZiAtdXJOIGxpbnV4Lm9yaWcvaW5jbHVkZS9hc20tcHBjL2F0b21pYy5o
IGxpbnV4L2luY2x1ZGUvYXNtLXBwYy9hdG9taWMuaA0KLS0tIGxpbnV4Lm9y
aWcvaW5jbHVkZS9hc20tcHBjL2F0b21pYy5oCVN1biBNYXIgMjUgMTg6MzE6
MDggMjAwMQ0KKysrIGxpbnV4L2luY2x1ZGUvYXNtLXBwYy9hdG9taWMuaAlT
dW4gQXByICA3IDIwOjM4OjExIDIwMDINCkBAIC02LDYgKzYsOSBAQA0KICNk
ZWZpbmUgX0FTTV9QUENfQVRPTUlDX0hfDQogDQogI2lmZGVmIF9fU01QX18N
CisNCisjaW5jbHVkZSA8YXNtL3NtcC5oPg0KKw0KIHR5cGVkZWYgc3RydWN0
IHsgdm9sYXRpbGUgaW50IGNvdW50ZXI7IH0gYXRvbWljX3Q7DQogI2Vsc2UN
CiB0eXBlZGVmIHN0cnVjdCB7IGludCBjb3VudGVyOyB9IGF0b21pY190Ow0K
ZGlmZiAtdXJOIGxpbnV4Lm9yaWcvaW5jbHVkZS9hc20tcHBjL2hhcmRpcnEu
aCBsaW51eC9pbmNsdWRlL2FzbS1wcGMvaGFyZGlycS5oDQotLS0gbGludXgu
b3JpZy9pbmNsdWRlL2FzbS1wcGMvaGFyZGlycS5oCVN1biBNYXIgMjUgMTg6
MzE6MDkgMjAwMQ0KKysrIGxpbnV4L2luY2x1ZGUvYXNtLXBwYy9oYXJkaXJx
LmgJU3VuIEFwciAgNyAyMDozODo0OSAyMDAyDQpAQCAtMSw2ICsxLDggQEAN
CiAjaWZuZGVmIF9fQVNNX0hBUkRJUlFfSA0KICNkZWZpbmUgX19BU01fSEFS
RElSUV9IDQogDQorI2luY2x1ZGUgPGxpbnV4L3Rhc2tzLmg+DQorDQogZXh0
ZXJuIHVuc2lnbmVkIGludCBwcGNfbG9jYWxfaXJxX2NvdW50W05SX0NQVVNd
Ow0KIA0KIC8qDQo=
--1473552907-1349931730-1020429619=:2298--

