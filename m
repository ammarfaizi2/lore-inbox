Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270905AbRHSXIU>; Sun, 19 Aug 2001 19:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270907AbRHSXIK>; Sun, 19 Aug 2001 19:08:10 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:33504 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S270905AbRHSXH7>;
	Sun, 19 Aug 2001 19:07:59 -0400
Message-Id: <5.1.0.14.2.20010820000309.02724d20@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 20 Aug 2001 00:04:27 +0100
To: Joachim Herb <herb@leo.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Compilation error in ntfs driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B8040BF.F1B24374@leo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Yes, known problem, but wrong fix. Correct fix is to add the line:

#include <linux/kernel.h>

to the includes in fs/ntfs/unistr.c

Best regards,

Anton

At 23:42 19/08/01, Joachim Herb wrote:
>Hello,
>
>I think I have found a compilation error in the ntfs driver in file
>unistr.c:
>make -C ntfs modules
>make[2]: Entering directory `/usr/src/linux-2.4.7/fs/ntfs'
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall
>-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
>-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
>-march=athlon  -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o
>unistr.o unistr.c
>unistr.c: In function `ntfs_collate_names':
>unistr.c:99: warning: implicit declaration of function `min'
>unistr.c:99: parse error before `unsigned'
>unistr.c:99: parse error before `)'
>unistr.c:97: warning: `c1' might be used uninitialized in this function
>unistr.c: At top level:
>unistr.c:118: parse error before `if'
>unistr.c:123: warning: type defaults to `int' in declaration of `c1'
>unistr.c:123: `name1' undeclared here (not in a function)
>unistr.c:123: warning: data definition has no type or storage class
>unistr.c:124: parse error before `if'
>
>The problem is the following part of the 2.4.9 patch:
>diff -u --recursive --new-file v2.4.8/linux/fs/ntfs/unistr.c
>linux/fs/ntfs/unistr.c
>--- v2.4.8/linux/fs/ntfs/unistr.c       Wed Jul 25 17:10:24 2001
>+++ linux/fs/ntfs/unistr.c      Wed Aug 15 01:22:17 2001
>@@ -96,7 +96,7 @@
>         __u32 cnt;
>         wchar_t c1, c2;
>
>-       for (cnt = 0; cnt < min(name1_len, name2_len); ++cnt)
>+       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len);
>++cnt)
>         {
>                 c1 = le16_to_cpu(*name1++);
>                 c2 = le16_to_cpu(*name2++);
>
>Simply remove it again, i.e. remove the "unsigned int, ", and the file
>compiles (with one warning).
>
>Joachim
>--
>Joachim Herb
>mailto:herb@leo.org
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

