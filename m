Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSD3CyC>; Mon, 29 Apr 2002 22:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSD3CyC>; Mon, 29 Apr 2002 22:54:02 -0400
Received: from wind.he.net ([216.218.129.2]:16132 "EHLO wind.he.net")
	by vger.kernel.org with ESMTP id <S313027AbSD3CyB>;
	Mon, 29 Apr 2002 22:54:01 -0400
Date: Mon, 29 Apr 2002 19:50:36 -0700
Subject: Re: 2.5.9,2.5.10 kernel compile, +SMP?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: chris.2.dobbs@bt.com, harada@mbr.sphere.ne.jp,
        linux-kernel@vger.kernel.org
To: "Ron Pagani / San Francisco / San Jose, CA" <lists@ronpagani.com>
From: "Ron Pagani / San Francisco / San Jose, CA" <lists@ronpagani.com>
In-Reply-To: <8FA18A0E-5BDF-11D6-A995-0030657B7B46@ronpagani.com>
Message-Id: <0C1F6097-5BE5-11D6-A995-0030657B7B46@ronpagani.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hrmm...  Well, I commented out my funky lines

[ init/main.c -- 2.5.9 ]     <<SNIP>>
#ifndef CONFIG_SMP

#ifdef CONFIG_X86_LOCAL_APIC
static void __init smp_init(void)
{
         APIC_init_uniprocessor();
}
#else
#define smp_init()      do { } while (0)
#endif
/*
** funkiness
*/
//static inline void setup_per_cpu_areas(void)
//{
//}

static inline void setup_per_cpu_areas(void)
{
}

#else

#ifdef __GENERIC_PER_CPU

<<SNIP>>


On Monday, April 29, 2002, at 07:11 PM, Ron Pagani / San Francisco / San 
Jose, CA wrote:

> Make mrproper worked at first (cleaning up after 2.5.10); now when 
> building 2.5.9, I get this failure regardless, even after untarring a 
> fresh source bundle!!
>
>
> [ make bzImage // 2.5.9 ]
>
> gcc -D__KERNEL__ -I/usr/src/redhat/SOURCES/linux-2.5.9/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
> init/main.c:279: redefinition of `setup_per_cpu_areas'
> init/main.c:275: `setup_per_cpu_areas' previously defined here
> make: *** [init/main.o] Error 1
>

