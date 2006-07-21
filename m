Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWGUXMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWGUXMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWGUXMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 19:12:46 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:31621 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750722AbWGUXMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 19:12:46 -0400
Message-ID: <1153523308.44c15e6c9c106@portal.student.luth.se>
Date: Sat, 22 Jul 2006 01:08:28 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][PATCH] A generic boolean (version 3)
References: <1153341500.44be983ca1407@portal.student.luth.se>
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here 

Citerar ricknu-0@student.ltu.se:

> From: Richard Knutsson
> 
> A first step to a generic boolean-type. The patch just introduce the bool
> (in
> arch. i386 only (for the moment)), false and true + fixing some duplications
> in
> the code.
> It is diffed against Linus' git-tree (060718)
> Compiled with my own-, allyesconfig- and allmodconfig-config.h-file.
> 
> -Why would we want it?
> -There is already some how are depending on a "boolean"-type (like NTFS).
> Also,
> it will clearify functions who returns a boolean from one returning a value,
> ex:
> bool it_is_ok();
> char it_is_ok();
> The first one is obvious what it is doing, the secound might return some sort
> of
> status.
> 
> -Why false and not FALSE, why not "enum {...} bool"
> -They are not #define(d) and shouldn't because it is a value, like 'a'. But
> because it is just a value, then bool is just a variable and should be able
> to
> handle 0 and 1 equally well.
> 
> Well, this is _my_ opinion, it may be totally wrong. If so, please tell me
> ;)
> 
> If this takes off, I guess I will spend quite some time at kernel-janitors
> "cleaning" those who use a boolean-type.
> 
> Til' next time...
> /Richard Knutsson
> 
> PS
> Yes, I know about Andrew's try to unify TRUE and FALSE, did read the thread
> with
> interest (that's from where I got to know about _Bool). But mostly (then
> still
> on the subject) was some people did not want FALSE and TRUE instead of 0 and
> 1.
> I look at it as: 'a' = 97, if someone like to write 97 instead of 'a', please
> do
> if you find it easier to read. I, on the other hand, think it is easier with
> 'a', false/FALSE, NULL, etc.
> DS
> 
> PPS
> One thing about _Bool thue:
> _Bool a = 12; results in a = 1
> 
> test( char * t ) { t = 12; }
> main() {
> _Bool a;
> test( (char *) &a ); results in a = 12.
> }
> 
> But I do not think of it as a problem since a "true" is just !false. Doing:
> if (boolvar == true)
> seems odd, after all...
> 
> ... and sorry for the longwinded letter :)
> DDS
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> 
> ---
> 
>  drivers/block/DAC960.h            |    2 +-
>  drivers/media/video/cpia2/cpia2.h |    4 ----
>  drivers/net/dgrs.c                |    1 -
>  drivers/scsi/BusLogic.h           |    5 +----
>  include/asm-i386/types.h          |    9 +++++++++
>  include/linux/stddef.h            |    2 ++
>  6 files changed, 13 insertions(+), 10 deletions(-)
> 
> 
> 
> diff --git a/drivers/block/DAC960.h b/drivers/block/DAC960.h
> index a82f37f..f9217c3 100644
> --- a/drivers/block/DAC960.h
> +++ b/drivers/block/DAC960.h
> @@ -71,7 +71,7 @@ #define DAC690_V2_PciDmaMask	0xfffffffff
>    Define a Boolean data type.
>  */
>  
> -typedef enum { false, true } __attribute__ ((packed)) boolean;
> +typedef bool boolean;
>  
>  
>  /*
> diff --git a/drivers/media/video/cpia2/cpia2.h
> b/drivers/media/video/cpia2/cpia2.h
> index c5ecb2b..8d2dfc1 100644
> --- a/drivers/media/video/cpia2/cpia2.h
> +++ b/drivers/media/video/cpia2/cpia2.h
> @@ -50,10 +50,6 @@ #define CPIA2_PATCH_VER	0
>  /***
>   * Image defines
>   ***/
> -#ifndef true
> -#define true 1
> -#define false 0
> -#endif
>  
>  /*  Misc constants */
>  #define ALLOW_CORRUPT 0		/* Causes collater to discard checksum */
> diff --git a/drivers/net/dgrs.c b/drivers/net/dgrs.c
> index fa4f094..4dbc23d 100644
> --- a/drivers/net/dgrs.c
> +++ b/drivers/net/dgrs.c
> @@ -110,7 +110,6 @@ static char version[] __initdata =
>   *	DGRS include files
>   */
>  typedef unsigned char uchar;
> -typedef unsigned int bool;
>  #define vol volatile
>  
>  #include "dgrs.h"
> diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
> index 9792e5a..d6d1d56 100644
> --- a/drivers/scsi/BusLogic.h
> +++ b/drivers/scsi/BusLogic.h
> @@ -237,10 +237,7 @@ enum BusLogic_BIOS_DiskGeometryTranslati
>    Define a Boolean data type.
>  */
>  
> -typedef enum {
> -	false,
> -	true
> -} PACKED boolean;
> +typedef bool boolean;
>  
>  /*
>    Define a 10^18 Statistics Byte Counter data type.
> diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
> index 4b4b295..e35709a 100644

> --- a/include/asm-i386/types.h
> +++ b/include/asm-i386/types.h
> @@ -10,6 +10,15 @@ typedef unsigned short umode_t;
>   * header files exported to user space
>   */
>  
> +#if defined(__GNUC__) && __GNUC__ >= 3
> +typedef _Bool bool;
> +#else
> +#warning You compiler doesn't seem to support boolean types, will set 'bool'
> as
> an 'unsigned char'
> +typedef unsigned char bool;
> +#endif
> +
> +typedef bool u2;
> +
>  typedef __signed__ char __s8;
>  typedef unsigned char __u8;
>  
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index b3a2cad..5e5c611 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -10,6 +10,8 @@ #else
>  #define NULL ((void *)0)
>  #endif
>  
> +enum { false = 0, true = 1 } __attribute__((packed));
> +
>  #undef offsetof
>  #ifdef __compiler_offsetof
>  #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



