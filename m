Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136574AbREBB5D>; Tue, 1 May 2001 21:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136572AbREBB4x>; Tue, 1 May 2001 21:56:53 -0400
Received: from viper.haque.net ([66.88.179.82]:40078 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S136590AbREBB4j>;
	Tue, 1 May 2001 21:56:39 -0400
Message-ID: <3AEF694A.6B1D7602@haque.net>
Date: Tue, 01 May 2001 21:56:26 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tpepper@vato.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.4 breaks VMware
In-Reply-To: <20010501184240.A28442@cb.vato.org>
Content-Type: multipart/mixed;
 boundary="------------5F879115CBA770D6E4A81515"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5F879115CBA770D6E4A81515
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

tpepper@vato.org wrote:
> This patch replaces a wee bit of code vmware wanted in include/linux/skbuff.h
> although I'm guessing it was removed for a reason and vmware should be patched
> to use the new method.
> 

Better to patch vmware rather than the kernel. Here's a patch thet
should be applied to source files in
/usr/lib/vmware/modules/source/vmnet.tar


-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------5F879115CBA770D6E4A81515
Content-Type: text/plain; charset=us-ascii;
 name="vmnet-skbuff.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmnet-skbuff.diff"

diff -urw vmnet-only/vnetInt.h vmnet-only-patched/vnetInt.h
--- vmnet-only/vnetInt.h	Wed Nov  1 20:48:28 2000
+++ vmnet-only-patched/vnetInt.h	Tue Apr 17 23:29:47 2001
@@ -16,9 +16,15 @@
 #  define KFREE_SKB(skb, type)		kfree_skb(skb)
 #  define DEV_KFREE_SKB(skb, type)	dev_kfree_skb(skb)
 #  define SKB_INCREF(skb)		atomic_inc(&(skb)->users)
+#  ifdef KERNEL_2_4_0
+#    define SKB_IS_CLONE_OF(clone, skb)    ( \
+         skb_cloned(clone) \
+     )
+#  else
 #  define SKB_IS_CLONE_OF(clone, skb)	( \
       skb_datarefp(clone) == skb_datarefp(skb) \
    )
+#  endif
 #  define SK_ALLOC(pri)			sk_alloc(0, pri, 1)
 #  define DEV_QUEUE_XMIT(skb, dev, pri)	( \
       (skb)->dev = (dev), \

--------------5F879115CBA770D6E4A81515--

