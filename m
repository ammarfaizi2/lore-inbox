Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQKUIDX>; Tue, 21 Nov 2000 03:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbQKUIDN>; Tue, 21 Nov 2000 03:03:13 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:38155 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S129732AbQKUIDD>; Tue, 21 Nov 2000 03:03:03 -0500
Message-ID: <3A1A252D.462B991A@home.com>
Date: Tue, 21 Nov 2000 01:33:01 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Assembler warnings
In-Reply-To: <5600.974782160@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 20 Nov 2000 22:11:04 -0600,
> Matthew Vanecek <linux4us@home.com> wrote:
> >Hi.  I see these warnings while compiling modules in 2.4.0-test10.  This
> >is with RH 7.0's kgcc (why-oh-why did they base their system on
> >2.96!!).  It doesn't seem to break anything--I'm just curious as to what
> >the warnings signify.
> >
> >{standard input}: Assembler messages:
> >{standard input}:8: Warning: Ignoring changed section attributes for
> >.modinfo
> 
> Firstly you should not be compiling the kernel with gcc 2.96, you
> should be using kgcc.  Search recent l-k archives for kgcc.
> 

I said above the compiler I'm using, which is kgcc. =P  AFAICT, a 2.96
kernel wouldn't even boot properly (well, I listened to others, so I've
only had the benefit of *other* people's experience!).

> Secondly that is a warning that section .modinfo was initially created
> without the allocation bit but later usage of the section implies that
> the allocation bit should be set.  Creating .modinfo as non-allocated
> was an old kludge to stop the module descriptive data being loaded into
> memory as part of the module.  modutils 2.3.19 onwards force .modinfo
> to be non-allocated (and hence not loaded into kernel memory), even if
> the allocate bit is set.  Feel free to try this patch, it is not urgent
> so I have not sent it to Linus "code freeze" Torvalds yet.
> 

I'll give your patch a try on the morrow, or day after.  Gotta get my
new Visor working w/USB cradle first!  I just wanted to find out if
those messages indicated a problem, or if they are harmless. 
Personally, I hate seeing even warnings--I'd rather the code compiled
without any at all (although with some compilers, that's just not
possible!!).

Thanks for the reply.

> Against 2.4.0-test11-pre6, it might fit 2.4.0-test11.
> 
> Index: 0-test11-pre6.1/include/linux/module.h
> --- 0-test11-pre6.1/include/linux/module.h Sun, 12 Nov 2000 14:59:01 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
> +++ 0-test11-pre6.1(w)/include/linux/module.h Tue, 21 Nov 2000 15:46:58 +1100 kaos (linux-2.4/W/33_module.h 1.1.2.1.2.1.2.1.2.1.1.3 644)
> @@ -247,12 +247,6 @@ static const struct gtype##_id * __modul
>    __attribute__ ((unused)) = name
>  #define MODULE_DEVICE_TABLE(type,name)         \
>    MODULE_GENERIC_TABLE(type##_device,name)
> -/* not put to .modinfo section to avoid section type conflicts */
> -
> -/* The attributes of a section are set the first time the section is
> -   seen; we want .modinfo to not be allocated.  */
> -
> -__asm__(".section .modinfo\n\t.previous");
> 
>  /* Define the module variable, and usage macros.  */
>  extern struct module __this_module;

-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
