Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSJCPMh>; Thu, 3 Oct 2002 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbSJCPMh>; Thu, 3 Oct 2002 11:12:37 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:6833 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261427AbSJCPMd>;
	Thu, 3 Oct 2002 11:12:33 -0400
Message-ID: <3D9C5FAE.60008@colorfullife.com>
Date: Thu, 03 Oct 2002 17:18:06 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.40-ac1
References: <3D9C5827.70703@colorfullife.com> <20021003.075034.12648168.davem@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------030408070204040006010808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030408070204040006010808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
>    
> How about a 64-bit system where set_bit works on 64-bit longs
> and not 32-bit ones?  That is why the current code there is broken.
 >

There should bit nonatomic bit ops for every byte width.

http://marc.theaimsgroup.com/?l=linux-kernel&m=99167415926343&w=2

I even sent you the patch proposal, but never got a reply.

Patch again attached, but untested.
--
	Manfred

--------------030408070204040006010808
Content-Type: text/plain;
 name="patch-bitops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-bitops"

--- 2.4/include/linux/bitops.h	Sat Apr 28 00:48:19 2001
+++ build-2.4/include/linux/bitops.h	Tue Jun  5 19:40:43 2001
@@ -68,5 +68,27 @@
 
 #include <asm/bitops.h>
 
+#ifdef __KERNEL__
+#include <linux/types.h>
+#define BUILD_SET_BIT(n) \
+static inline void __set_bit_##n(int offset, u##n *data) \
+{ \
+	data[offset/n] |= (1 << (offset%n)); \
+}
+
+#ifndef _HAVE_ARCH_SET_BIT_8
+BUILD_SET_BIT(8)
+#endif
+#ifndef _HAVE_ARCH_SET_BIT_16
+BUILD_SET_BIT(16)
+#endif
+#ifndef _HAVE_ARCH_SET_BIT_32
+BUILD_SET_BIT(32)
+#endif
+#ifndef _HAVE_ARCH_SET_BIT_64
+BUILD_SET_BIT(64)
+#endif
+#undef BUILD_SET_BIT
+#endif
 
 #endif

--------------030408070204040006010808--

