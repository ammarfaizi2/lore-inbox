Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRHPWVh>; Thu, 16 Aug 2001 18:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268926AbRHPWV0>; Thu, 16 Aug 2001 18:21:26 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:31423 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268908AbRHPWVO>; Thu, 16 Aug 2001 18:21:14 -0400
Message-Id: <5.1.0.14.2.20010816231824.00a94b70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 16 Aug 2001 23:21:17 +0100
To: tpepper@vato.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.9 does not compile [PATCH]
Cc: f5ibh <f5ibh@db0bm.ampr.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010816144109.A5094@cb.vato.org>
In-Reply-To: <200108162111.XAA07177@db0bm.ampr.org>
 <200108162111.XAA07177@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong fix. Jules Colding already sent correct one (an hour ago or so).

At 22:41 16/08/2001, tpepper@vato.org wrote:
>Confirmed here.  Looks like a pretty obvious goof to me.

Yes. Someone forgot to add kernel.h include after they removed the ntfs 
specific macros... Grr...

>   Does the following fix it for you?
>
>--- linux-2.4.9/fs/ntfs/unistr.c.orig   Thu Aug 16 14:35:03 2001
>+++ linux-2.4.9/fs/ntfs/unistr.c        Thu Aug 16 14:35:15 2001
>@@ -96,7 +96,7 @@
>         __u32 cnt;
>         wchar_t c1, c2;
>
>-       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len); ++cnt)
>+       for (cnt = 0; cnt < min(name1_len, name2_len); ++cnt)

This won't fix it because the min macro still will not exist.

Anton

>         {
>                 c1 = le16_to_cpu(*name1++);
>                 c2 = le16_to_cpu(*name2++);
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

