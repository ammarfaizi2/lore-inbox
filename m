Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268903AbRHPWLG>; Thu, 16 Aug 2001 18:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbRHPWK4>; Thu, 16 Aug 2001 18:10:56 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:18191 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S268903AbRHPWKk>;
	Thu, 16 Aug 2001 18:10:40 -0400
From: tpepper@vato.org
Date: Thu, 16 Aug 2001 15:10:51 -0700
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [better PATCH]
Message-ID: <20010816151051.A5232@cb.vato.org>
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Thu, Aug 16, 2001 at 11:11:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like they are actually using a 3 argument min() function in the ntfs
code.  It seems happy with these three arg's and an include added so this patch is pr÷bably preferable:

diff -Naur linux-2.4.9/fs/ntfs/unistr.c.orig linux-2.4.9/fs/ntfs/unistr.c
--- linux-2.4.9/fs/ntfs/unistr.c.orig   Thu Aug 16 14:35:03 2001
+++ linux-2.4.9/fs/ntfs/unistr.c        Thu Aug 16 15:07:54 2001
@@ -24,6 +24,7 @@
 #include <linux/string.h>
 #include <asm/byteorder.h>
 
+#include "ntfstypes.h"
 #include "unistr.h"
 #include "macros.h"
 
@@ -96,7 +97,7 @@
        __u32 cnt;
        wchar_t c1, c2;
 
-       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len); ++cnt)
+       for (cnt = 0; cnt < min(__u32, name1_len, name2_len); ++cnt)
        {
                c1 = le16_to_cpu(*name1++);
                c2 = le16_to_cpu(*name2++);

Tim

--
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************


On Thu 16 Aug at 23:11:40 +0200 f5ibh@db0bm.ampr.org done said:

> unistr.c: In function `ntfs_collate_names':
> unistr.c:99: warning: implicit declaration of function `min'
> unistr.c:99: parse error before `unsigned'
> unistr.c:99: parse error before `)'
> unistr.c:97: warning: `c1' might be used uninitialized in this function
> unistr.c: At top level:
> unistr.c:118: parse error before `if'
> unistr.c:123: warning: type defaults to `int' in declaration of `c1'
> unistr.c:123: `name1' undeclared here (not in a function)
> unistr.c:123: warning: data definition has no type or storage class
> unistr.c:124: parse error before `if'
> make[3]: *** [unistr.o] Erreur 1
> make[3]: Leaving directory `/usr/src/kernel-sources-2.4.9/fs/ntfs'
> make[2]: *** [_modsubdir_ntfs] Erreur 2
> make[2]: Leaving directory `/usr/src/kernel-sources-2.4.9/fs'
> make[1]: *** [_mod_fs] Erreur 2
> make[1]: Leaving directory `/usr/src/kernel-sources-2.4.9'
> make: *** [stamp-build] Erreur 2
