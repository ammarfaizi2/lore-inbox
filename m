Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbREUHuW>; Mon, 21 May 2001 03:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbREUHuE>; Mon, 21 May 2001 03:50:04 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:38724 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S261823AbREUHtu>; Mon, 21 May 2001 03:49:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: const __init 
In-Reply-To: Your message of "Sun, 20 May 2001 17:34:48 -0400."
             <3B083878.1785C27D@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 13:07:50 +1000
Message-ID: <13469.990414470@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001 17:34:48 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>(let me know if the following test is flawed)
>
> [jgarzik@rum tmp]$ cat > sectest.c
> #include <linux/module.h>
> #include <linux/init.h>
> static const char version[] __initdata = "foo";
> [jgarzik@rum tmp]$ gcc -D__KERNEL__ -I/spare/cvs/linux_2_4/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o sectest.o sectest.c
> [jgarzik@rum tmp]$ 
>
>No section type conflict appears.

With just one variable in initdata there is no conflict, it takes two
to conflict.

static const char var1[] __attribute__ ((__section__ (".data.init"))) = "foo";
int main(void) { return(0); }
static       int  var2[] __attribute__ ((__section__ (".data.init"))) = {0,1};

does cause a section conflict, egcs 1.1.2.

Interestingly enough, if var[12] are together, without the intervening
text, then gcc does not flag an error, instead it puts both variables
in section .data.init and marks it as read only.  This looks like a bug
in gcc.

