Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135444AbRD0KE7>; Fri, 27 Apr 2001 06:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135464AbRD0KEt>; Fri, 27 Apr 2001 06:04:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47113 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S135444AbRD0KEg>; Fri, 27 Apr 2001 06:04:36 -0400
Message-ID: <3AE9415D.A6F65CAC@evision-ventures.com>
Date: Fri, 27 Apr 2001 11:52:29 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH for 2.4.3 - tinny mount code cleanup (kernel 0.97 
 compatibility)
In-Reply-To: <UTC200104261723.TAA20960.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     From: Martin Dalecki <dalecki@evision-ventures.com>
> 
>     The attached patch is fixing georgeous "backward compatibility"
>     in the mount system command. It is removing two useless defines in
>     the kernel headers and finally doubles the number of possible
>     flags for the mount command.
> 
>     Please apply.
> 
> You have it all backwards. Your patch halves the number of
> possible flags. The present kernel can use 32 (or 31) flags.
> 
>     @@ -1317,10 +1313,6 @@
>          struct super_block *sb;
>          int retval = 0;
> 
>     -    /* Discard magic */
>     -    if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
>     -        flags &= ~MS_MGC_MSK;
>     -
>          /* Basic sanity checks */
> 
>          if (!dir_name || !*dir_name || !memchr(dir_name, 0, PAGE_SIZE))
> 
> You see what this code does: if the top half has this old magic
> (as it has today in 100% of all Linux installations),
> then the top half is ignored.
> If the value is non-conventional, it can be used to mean something.
> 
> Maybe you did not realize that mount still puts that value there?

Oops typo in find ./ ... grep on my side  maybe?

Anyway at least the comment there is at best missleading...

> The mount we use today will be around for many years to come.
> This "discard magic" part cannot be removed within five years.
> 
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
