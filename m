Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268923AbRHPW2G>; Thu, 16 Aug 2001 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268929AbRHPW15>; Thu, 16 Aug 2001 18:27:57 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:44735 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268923AbRHPW1v> convert rfc822-to-8bit; Thu, 16 Aug 2001 18:27:51 -0400
Message-Id: <5.1.0.14.2.20010816232513.0461bae0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 16 Aug 2001 23:28:03 +0100
To: tpepper@vato.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.9 does not compile [better PATCH]
Cc: f5ibh <f5ibh@db0bm.ampr.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010816151051.A5232@cb.vato.org>
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>
 <200108162111.XAA07177@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:10 16/08/2001, tpepper@vato.org wrote:
>It looks like they are actually using a 3 argument min() function in the ntfs
>code.

No, we are not using a 3 argument min() macro in ntfs code. At least we 
weren't until someone decided to replace all existing max/min macros from 
the entire kernel with this new 3 argument version and in the process 
forgot to add the kernel.h include thus breaking ntfs compilation...

Oh well, we will have to live with it until Linus comes back.

>It seems happy with these three arg's and an include added so this patch 
>is pr÷bably preferable:
>
>diff -Naur linux-2.4.9/fs/ntfs/unistr.c.orig linux-2.4.9/fs/ntfs/unistr.c
>--- linux-2.4.9/fs/ntfs/unistr.c.orig   Thu Aug 16 14:35:03 2001
>+++ linux-2.4.9/fs/ntfs/unistr.c        Thu Aug 16 15:07:54 2001
>@@ -24,6 +24,7 @@
>  #include <linux/string.h>
>  #include <asm/byteorder.h>
>
>+#include "ntfstypes.h"

that should be +#include <linux/kernel.h>

Best regards,

Anton

>  #include "unistr.h"
>  #include "macros.h"
>
>@@ -96,7 +97,7 @@
>         __u32 cnt;
>         wchar_t c1, c2;
>
>-       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len); ++cnt)
>+       for (cnt = 0; cnt < min(__u32, name1_len, name2_len); ++cnt)
>         {
>                 c1 = le16_to_cpu(*name1++);
>                 c2 = le16_to_cpu(*name2++);
>
>Tim
>
>--
>*********************************************************
>*  tpepper@vato dot org             * Venimus, Vidimus, *
>*  http://www.vato.org/~tpepper     * Dolavimus         *
>*********************************************************
>
>
>On Thu 16 Aug at 23:11:40 +0200 f5ibh@db0bm.ampr.org done said:
>
> > unistr.c: In function `ntfs_collate_names':
> > unistr.c:99: warning: implicit declaration of function `min'
> > unistr.c:99: parse error before `unsigned'
> > unistr.c:99: parse error before `)'
> > unistr.c:97: warning: `c1' might be used uninitialized in this function
> > unistr.c: At top level:
> > unistr.c:118: parse error before `if'
> > unistr.c:123: warning: type defaults to `int' in declaration of `c1'
> > unistr.c:123: `name1' undeclared here (not in a function)
> > unistr.c:123: warning: data definition has no type or storage class
> > unistr.c:124: parse error before `if'
> > make[3]: *** [unistr.o] Erreur 1
> > make[3]: Leaving directory `/usr/src/kernel-sources-2.4.9/fs/ntfs'
> > make[2]: *** [_modsubdir_ntfs] Erreur 2
> > make[2]: Leaving directory `/usr/src/kernel-sources-2.4.9/fs'
> > make[1]: *** [_mod_fs] Erreur 2
> > make[1]: Leaving directory `/usr/src/kernel-sources-2.4.9'
> > make: *** [stamp-build] Erreur 2
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

