Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268867AbRHPVlY>; Thu, 16 Aug 2001 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268858AbRHPVlP>; Thu, 16 Aug 2001 17:41:15 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:14095 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S268862AbRHPVk5>;
	Thu, 16 Aug 2001 17:40:57 -0400
From: tpepper@vato.org
Date: Thu, 16 Aug 2001 14:41:09 -0700
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
Message-ID: <20010816144109.A5094@cb.vato.org>
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Thu, Aug 16, 2001 at 11:11:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed here.  Looks like a pretty obvious goof to me.  Does the following
fix it for you?

--- linux-2.4.9/fs/ntfs/unistr.c.orig   Thu Aug 16 14:35:03 2001
+++ linux-2.4.9/fs/ntfs/unistr.c        Thu Aug 16 14:35:15 2001
@@ -96,7 +96,7 @@
        __u32 cnt;
        wchar_t c1, c2;
 
-       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len); ++cnt)
+       for (cnt = 0; cnt < min(name1_len, name2_len); ++cnt)
        {
                c1 = le16_to_cpu(*name1++);
                c2 = le16_to_cpu(*name2++);

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
