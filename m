Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276689AbRJGVOr>; Sun, 7 Oct 2001 17:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276691AbRJGVOh>; Sun, 7 Oct 2001 17:14:37 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:14467 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S276689AbRJGVOU>; Sun, 7 Oct 2001 17:14:20 -0400
Message-ID: <3BC0C655.6C35DF43@oracle.com>
Date: Sun, 07 Oct 2001 23:17:09 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.11-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.11-pre5
In-Reply-To: <Pine.NEB.4.40.0110072235410.3783-200000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> I get the error below. Must likely there's a problem when you build a
> kernel without module support (my .config is attached).
> 
> ...
> gcc -D__KERNEL__ -I/home/bunk/linux/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o exec_domain.o exec_domain.c

[snip]

> This seems to be triggered by the following change in pre5:
> 
> --- linux/include/linux/module.h
> +++ linux/include/linux/module.h
> @@ -348,6 +348,13 @@
>  #define EXPORT_SYMBOL_NOVERS(var)  error config_must_be_included_before_module
>  #define EXPORT_SYMBOL_GPL(var)  error config_must_be_included_before_module
> 
> +#elif !defined(EXPORT_SYMTAB)
> +
> +#define __EXPORT_SYMBOL(sym,str)   error this_object_must_be_defined_as_export_objs_in_the_Makefile
> +#define EXPORT_SYMBOL(var)        error this_object_must_be_defined_as_export_objs_in_the_Makefile
> +#define EXPORT_SYMBOL_NOVERS(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
> +#define EXPORT_SYMBOL_GPL(var)  error this_object_must_be_defined_as_export_objs_in_the_Makefile
> +
>  #elif !defined(CONFIG_MODULES)
> 
>  #define __EXPORT_SYMBOL(sym,str)

Happens also for ieee1394 when built as module.

--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')
