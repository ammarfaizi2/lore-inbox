Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314089AbSDKPPC>; Thu, 11 Apr 2002 11:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314088AbSDKPPB>; Thu, 11 Apr 2002 11:15:01 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:40091 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314089AbSDKPOL>; Thu, 11 Apr 2002 11:14:11 -0400
Message-ID: <3CB5A82B.80C942A0@in.ibm.com>
Date: Thu, 11 Apr 2002 20:43:47 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [brokenpatch] page accounting
In-Reply-To: <3CB41BA7.DAC3A785@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> The patch implements per-CPU accounting of the global number
> of locked, diry and pagecache pages.
> 
> -#define PG_locked               0      /* Page is locked. Don't touch. */
> +
> +/*
> + * Don't use the *_dontuse flags.  Use the macros.  Otherwise
> + * you'll break locked- and dirty-page accounting.
> + */
> +#define PG_locked_dontuse       0      /* Page is locked. Don't touch. */
>  #define PG_error                1
>  #define PG_referenced           2
>  #define PG_uptodate             3
> -#define PG_dirty                4
> +#define PG_dirty_dontuse        4
>  #define PG_unused               5
>  #define PG_lru                  6
>  #define PG_active               7
> -#define PG_slab                         8
> -#define PG_skip                        10
> +#define PG_slab                         8      /* kill me if needed: slab debug */

A little plea for mercy for this tiny bit :)
Could we keep PG_slab around unless its really causing trouble ? It
makes life easier for some things we do ... Also its rather nice that
today as a result of a wide usage of
slab infrastructure in the kernel, one can easily/directly interpret the
contents of 
almost any arbitrary memory location in the kernel, if its a slab page,
as one knows what type of data it contains. 


> +#define PG_skip                        10      /* kill me now: obsolete */
>  #define PG_highmem             11
>  #define PG_checked             12      /* kill me in 2.5.<early>. */
>  #define PG_arch_1              13
>  #define PG_reserved            14
>  #define PG_launder             15      /* written out by VM pressure.. */
> -
>  #define PG_private             16      /* Has something at ->private */
>
