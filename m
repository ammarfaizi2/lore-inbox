Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSFNXLC>; Fri, 14 Jun 2002 19:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFNXLB>; Fri, 14 Jun 2002 19:11:01 -0400
Received: from www.transvirtual.com ([206.14.214.140]:25868 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S313767AbSFNXK7>; Fri, 14 Jun 2002 19:10:59 -0400
Date: Fri, 14 Jun 2002 16:10:51 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: A Guy Called Tyketto <tyketto@wizard.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 -- aty128fb.c: aty128fb.c:1775: `con' undeclared
In-Reply-To: <20020609094422.GA7007@wizard.com>
Message-ID: <Pine.LNX.4.44.0206141610240.21575-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a fix in the fbdev BK repository. I will soon begin porting that
driver over to the new api.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

On Sun, 9 Jun 2002, A Guy Called Tyketto wrote:

>
>         I'll throw one in too:
>
> make[2]: Entering directory `/usr/src/linux-2.5.20/drivers/video'
>   gcc -Wp,-MD,.aty128fb.o.d -D__KERNEL__ -I/usr/src/linux-2.5.20/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=aty128fb   -c -o aty128fb.o aty128fb.c
> aty128fb.c: In function `aty128_init':
> aty128fb.c:1775: `con' undeclared (first use in this function)
> aty128fb.c:1775: (Each undeclared identifier is reported only once
> aty128fb.c:1775: for each function it appears in.)
> aty128fb.c:1776: incompatible type for argument 1 of `fb_alloc_cmap'
> aty128fb.c:1662: warning: `size' might be used uninitialized in this function
> make[2]: *** [aty128fb.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.20/drivers/video'
> make[1]: *** [_subdir_video] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.20/drivers'
> make: *** [drivers] Error 2
>
>         lines 1775-1776 are:
>
>     size = (fb_display[con].var.bits_per_pixel <= 8) ? 256 : 32;
>     fb_alloc_cmap(info->fb_info.cmap, size, 0);
>
>         fb_display[] seems to be the culprit. It's an array, in which has the
> 'con' field, which is of type int. In all other functions where this array is
> used, 'con' is passed to the function as type int. It seems to be missing for
> this one.
>
>         Backing out of the change seems to work, as this was added in the
> 2.5.21 patch, but I'd rather like to know what the proper solution is..
>
>                                                         BL.
>
>         Relevant parts of config below.
>
> CONFIG_FB=y
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_FB_ATY=y
> CONFIG_FB_ATY_CT=y
> CONFIG_FB_RADEON=y
> CONFIG_FB_ATY128=y
> CONFIG_FBCON_ADVANCED=y
> CONFIG_FBCON_CFB8=y
> CONFIG_FBCON_CFB16=y
> CONFIG_FBCON_CFB24=y
> CONFIG_FBCON_CFB32=y
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
>
> --
> Brad Littlejohn                         | Email:        tyketto@wizard.com
> Unix Systems Administrator,             |           tyketto@ozemail.com.au
> Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
>   PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

