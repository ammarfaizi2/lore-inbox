Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRHQElC>; Fri, 17 Aug 2001 00:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbRHQEkx>; Fri, 17 Aug 2001 00:40:53 -0400
Received: from v116b.studby.ntnu.no ([129.241.151.116]:51685 "EHLO burken")
	by vger.kernel.org with ESMTP id <S269671AbRHQEki>;
	Fri, 17 Aug 2001 00:40:38 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Harald Skoglund <haraldms@confuzius.net>
Reply-To: haraldms@confuzius.net
To: Dirk Wetter <dirkw@rentec.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ntfs module doesn't compile in 2.4.9
Date: Fri, 17 Aug 2001 06:41:25 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0108162314370.3551-100000@monster-m.rentec.com>
In-Reply-To: <Pine.LNX.4.33.0108162314370.3551-100000@monster-m.rentec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E15XbR7-0001aS-00@burken>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm shure this is just a matter of adding
#include <linux/kernel.h> to 
fs/ntfs/unistr.c file

anyway i did so and it compiled fine for me.
But really don't have a clue kernelhacking =)

On Friday 17 August 2001 05:20, Dirk Wetter wrote:
> hi,
>
> i fixed it for myself by redoing the changes (don't know what the
> first arg of min is supposed to be):
>
> --- fs/ntfs/unistr.c.OLD        Thu Aug 16 22:26:06 2001
> +++ fs/ntfs/unistr.c    Thu Aug 16 23:00:36 2001
> @@ -96,7 +96,7 @@
>         __u32 cnt;
>         wchar_t c1, c2;
>
> -       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len); ++cnt)
> +       for (cnt = 0; cnt < min(name1_len, name2_len); ++cnt)
>         {
>                 c1 = le16_to_cpu(*name1++);
>                 c2 = le16_to_cpu(*name2++);
>
> --- fs/ntfs/macros.h.OLD        Thu Aug 16 23:07:50 2001
> +++ fs/ntfs/macros.h    Thu Aug 16 23:08:04 2001
> @@ -11,6 +11,12 @@
>  #define NTFS_INO2VOL(ino)      (&((ino)->i_sb->u.ntfs_sb))
>  #define NTFS_LINO2NINO(ino)     (&((ino)->u.ntfs_i))
>
> +/* Classical min and max macros still missing in standard headers... */
> +#ifndef min
> +#define min(a,b)        ((a) <= (b) ? (a) : (b))
> +#define max(a,b)        ((a) >= (b) ? (a) : (b))
> +#endif
> +
>  #define IS_MAGIC(a,b)          (*(int*)(a) == *(int*)(b))
>  #define IS_MFT_RECORD(a)       IS_MAGIC((a),"FILE")
>  #define IS_INDEX_RECORD(a)     IS_MAGIC((a),"INDX")
>
>
>
>
> 	~dirkw
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Harald Skoglund
--Er ikke tøff nok til å ha sig.
