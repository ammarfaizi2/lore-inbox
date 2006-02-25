Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWBYDlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWBYDlp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 22:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWBYDlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 22:41:45 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:5029 "EHLO gepetto.dc.ltu.se")
	by vger.kernel.org with ESMTP id S932562AbWBYDlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 22:41:44 -0500
Message-ID: <43FFD364.9050906@student.ltu.se>
Date: Sat, 25 Feb 2006 04:47:48 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: oss/sonicvibes.c defines its own hweight32
References: <20060224031002.0f7ff92a.akpm@osdl.org>
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and all

Just tried to compile the kernel with the 'allyesconfig' when I stumbled 
on this one (have not seen any reports on this one, otherwise sorry for 
the blotter):

  CHK     usr/initramfs_list
  CC      sound/oss/sonicvibes.o
sound/oss/sonicvibes.c:421: error: static declaration of ‘hweight32’ follows non-static declaration
include/asm-generic/bitops/hweight.h:6: error: previous declaration of ‘hweight32’ was here
make[2]: *** [sound/oss/sonicvibes.o] Error 1
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2


I am not sure why it tries to make its own hweight32() so I just 
disabled it:

--- a/sound/oss/sonicvibes.c	2006-02-24 23:14:11.000000000 +0100
+++ b/sound/oss/sonicvibes.c	2006-02-25 04:10:09.000000000 +0100
@@ -408,6 +408,7 @@ static inline unsigned ld2(unsigned int 
 	return r;
 }
 
+#if 0
 /*
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
@@ -425,6 +426,7 @@ static inline unsigned int hweight32(uns
         res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
         return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
 }
+#endif
 
 /* --------------------------------------------------------------------- */
 


BTW, I do not have the hardware, so it is just building-tested.

Best
Richard Knutsson

