Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285484AbRL2Uge>; Sat, 29 Dec 2001 15:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285472AbRL2UgY>; Sat, 29 Dec 2001 15:36:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:34060 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285484AbRL2UgM>; Sat, 29 Dec 2001 15:36:12 -0500
Message-ID: <3C2E2875.8E2EF36D@zip.com.au>
Date: Sat, 29 Dec 2001 12:32:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Bernhard Rosenkraenzer <bero@redhat.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exporting seq_* stuff
In-Reply-To: <Pine.LNX.4.42.0112291626430.23274-200000@bochum.stuttgart.redhat.com> <Pine.GSO.4.21.0112291328160.5671-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> [snip the attached horror]

[ replace with a different one :-) ]
 
> diff -urN C2-pre3/kernel/ksyms.c C2-pre3-fix/kernel/ksyms.c
> --- C2-pre3/kernel/ksyms.c      Thu Dec 27 19:48:04 2001
> +++ C2-pre3-fix/kernel/ksyms.c  Sat Dec 29 13:48:12 2001
> @@ -46,6 +46,7 @@
>  #include <linux/tty.h>
>  #include <linux/in6.h>
>  #include <linux/completion.h>
> +#include <linux/seq_file.h>
>  #include <asm/checksum.h>
> 
>  #if defined(CONFIG_PROC_FS)
> @@ -480,6 +481,12 @@
>  EXPORT_SYMBOL(reparent_to_init);
>  EXPORT_SYMBOL(daemonize);
>  EXPORT_SYMBOL(csum_partial); /* for networking and md */
> +EXPORT_SYMBOL(seq_escape);
> +EXPORT_SYMBOL(seq_printf);
> +EXPORT_SYMBOL(seq_open);
> +EXPORT_SYMBOL(seq_release);
> +EXPORT_SYMBOL(seq_read);
> +EXPORT_SYMBOL(seq_lseek);

Personally, I prefer to see the EXPORT_SYMBOL() near the
definition of the thing being exported.  For functions, the
convention I like is:

void foo()
{
}
EXPORT_SYMBOL(foo);

It's nicer, and prevents patch conflicts.

I'd propose that we drop the concept of EXPORT_OBJ by making all
files eligible for exporting symbols, and that the janitors be given
a mandate to scrap the ksyms files.

Is this acceptable?

-
