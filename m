Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbTBKJeK>; Tue, 11 Feb 2003 04:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbTBKJeK>; Tue, 11 Feb 2003 04:34:10 -0500
Received: from so133005.bbo133.so-net.com.hk ([203.176.133.5]:5589 "EHLO
	anakin.wychk.org") by vger.kernel.org with ESMTP id <S267337AbTBKJeJ>;
	Tue, 11 Feb 2003 04:34:09 -0500
Date: Tue, 11 Feb 2003 17:33:22 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] asm/io.h: add missing define for alpha
Message-ID: <20030211093322.GA339@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=big5
Content-Disposition: inline

Hi all,


The following patch adds isa_eth_io_copy_and_sum define for alpha, which
has prevented the compilation of the AC3200 and ES3210 net driver for
a while now.

It compiles, but I have no hardware to test with.

Patch is against Marcelo's 2.4.21-pre4, status for 2.5 is unknown.


	-- G.

-- 
char p[] = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";



--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=big5
Content-Disposition: attachment; filename="io.h.patch"

--- linux-2.4.20/include/asm-alpha/io.h.orig	2003-02-10 17:55:23.000000000 +0100
+++ linux-2.4.20/include/asm-alpha/io.h	2003-02-10 18:28:48.000000000 +0100
@@ -457,7 +457,9 @@
 
 #define eth_io_copy_and_sum(skb,src,len,unused) \
   memcpy_fromio((skb)->data,(src),(len))
-
+#define isa_eth_io_copy_and_sum(skb,src,len,unused) \
+  isa_memcpy_fromio((skb)->data,(src),(len))
+ 
 static inline int
 check_signature(unsigned long io_addr, const unsigned char *signature,
 		int length)

--9jxsPFA5p3P2qPhR--
