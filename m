Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSKDOwc>; Mon, 4 Nov 2002 09:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSKDOwc>; Mon, 4 Nov 2002 09:52:32 -0500
Received: from ns.sysgo.de ([213.68.67.98]:13310 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S264729AbSKDOwb>;
	Mon, 4 Nov 2002 09:52:31 -0500
Date: Mon, 4 Nov 2002 15:54:50 +0100
From: Soewono Effendi <SEffendi@sysgo.de>
To: linux-kernel mlist <linux-kernel@vger.kernel.org>
Subject: [PATCH] error compiling v2.5.45 using xtreme minimal .config
Message-Id: <20021104155450.2d0ddf6b.SEffendi@sysgo.de>
Organization: SYSGO Real-Time Solutions GmbH
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__4_Nov_2002_15:54:50_+0100_082263a8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__4_Nov_2002_15:54:50_+0100_082263a8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,


this patch fixes the problem described in my earlier email.
kernel-v2.5.45 failed to build if configured without networking support.

--- /usr/src/linux-2.5.45/net/socket.c  Mon Nov  4 12:12:19 2002
+++ linux-2.5.45/net/socket.c   Mon Nov  4 15:49:12 2002
@@ -74,7 +74,6 @@
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
-#include <linux/wireless.h>
 #include <linux/divert.h>

 #if defined(CONFIG_KMOD) && defined(CONFIG_NET)
--- /usr/src/linux-2.5.45/net/core/skbuff.c     Mon Nov  4 12:12:19 2002
+++ linux-2.5.45/net/core/skbuff.c      Mon Nov  4 15:36:49 2002
@@ -324,7 +324,12 @@
        }

        dst_release(skb->dst);
+#ifdef CONFIG_INET
        secpath_put(skb->sp);
+#else
+       if (skb->sp)
+               atomic_dec(&skb->sp->refcnt);
+#endif
        if(skb->destructor) {
                if (in_irq())
                        printk(KERN_WARNING "Warning: kfree_skb on "


Best regards,
>> S. Effendi


--Multipart_Mon__4_Nov_2002_15:54:50_+0100_082263a8
Content-Type: application/octet-stream;
 name="no_networking.patch"
Content-Disposition: attachment;
 filename="no_networking.patch"
Content-Transfer-Encoding: base64

LS0tIC91c3Ivc3JjL2xpbnV4LTIuNS40NS9uZXQvc29ja2V0LmMJTW9uIE5vdiAgNCAxMjoxMjox
OSAyMDAyCisrKyBsaW51eC0yLjUuNDUvbmV0L3NvY2tldC5jCU1vbiBOb3YgIDQgMTU6NDk6MTIg
MjAwMgpAQCAtNzQsNyArNzQsNiBAQAogI2luY2x1ZGUgPGxpbnV4L2NhY2hlLmg+CiAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgvaGlnaG1lbS5oPgotI2luY2x1ZGUg
PGxpbnV4L3dpcmVsZXNzLmg+CiAjaW5jbHVkZSA8bGludXgvZGl2ZXJ0Lmg+CiAKICNpZiBkZWZp
bmVkKENPTkZJR19LTU9EKSAmJiBkZWZpbmVkKENPTkZJR19ORVQpCi0tLSAvdXNyL3NyYy9saW51
eC0yLjUuNDUvbmV0L2NvcmUvc2tidWZmLmMJTW9uIE5vdiAgNCAxMjoxMjoxOSAyMDAyCisrKyBs
aW51eC0yLjUuNDUvbmV0L2NvcmUvc2tidWZmLmMJTW9uIE5vdiAgNCAxNTozNjo0OSAyMDAyCkBA
IC0zMjQsNyArMzI0LDEyIEBACiAJfQogCiAJZHN0X3JlbGVhc2Uoc2tiLT5kc3QpOworI2lmZGVm
IENPTkZJR19JTkVUCiAJc2VjcGF0aF9wdXQoc2tiLT5zcCk7CisjZWxzZQorCWlmIChza2ItPnNw
KQorCQlhdG9taWNfZGVjKCZza2ItPnNwLT5yZWZjbnQpOworI2VuZGlmCiAJaWYoc2tiLT5kZXN0
cnVjdG9yKSB7CiAJCWlmIChpbl9pcnEoKSkKIAkJCXByaW50ayhLRVJOX1dBUk5JTkcgIldhcm5p
bmc6IGtmcmVlX3NrYiBvbiAiCg==

--Multipart_Mon__4_Nov_2002_15:54:50_+0100_082263a8--
