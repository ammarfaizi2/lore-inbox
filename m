Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281561AbRLDRgP>; Tue, 4 Dec 2001 12:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRLDReg>; Tue, 4 Dec 2001 12:34:36 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:15054 "HELO
	mail-smtp.uvsc.edu") by vger.kernel.org with SMTP
	id <S282404AbRLDR37> convert rfc822-to-8bit; Tue, 4 Dec 2001 12:29:59 -0500
Message-Id: <sc0ca5e8.016@mail-smtp.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Tue, 04 Dec 2001 10:30:58 -0700
From: "Tyler BIRD" <BIRDTY@uvsc.edu>
To: <apiggyjj@yahoo.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Insmod problems
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this

¯--------

#define MODULE

#include <linux/module.h>
int init_module(void) { printk("<1>Hello World"); return 0;}
void cleanup_module(void) {printk("<1>Goodbye cruel world\n"); }
¯---

gcc -c -D__KERNEL__ hello.c

compiled and loaded fine on my system

I think linux/module.h defines
the kernel version. Make sure that you have the kernel source headers installed under /usr/include
which is a link to /usr/src/linux/include.

you oughta put the above include/module.h at the begining of your source.



Also there has been a macro lately to
delate which routines will be init_module, cleanup_module22

>>> Michael Zhu <apiggyjj@yahoo.ca> 12/04/01 10:06AM >>>
I've define these two when I compile the module. The
command line is:

gcc -D_KERNEL_ -DMODULE -c hello.c


--- Tyler BIRD <BIRDTY@uvsc.edu> wrote:
> You need to define the __KERNEL__ and MODULE symbols
> 
> #define __KERNEL__
> #define MODULE
> 
> 
> >>> Nav Mundi <nmundi@karthika.com> 12/04/01 09:33AM
> >>>
> What are we doing wrong? - Nav & Michael
> **************************************************
> 
> hello.c Source:
> 
> #include "/home/mzhu/linux/include/linux/config.h" 
> /*retrieve the CONFIG_* macros */
> #if defined(CONFIG_MODVERSIONS) &&
> !defined(MODVERSIONS)
> #define MODVERSIONS  /* force it on */
> #endif
> 
> #ifdef MODVERSIONS
> #include
> "/home/mzhu/linux/include/linux/modversions.h"
> #endif
> 
> #include "/home/mzhu/linux/include/linux/module.h"
> 
> int init_module(void)  { printk("<1>Hello,
> world\n");  return 0; }
> void cleanup_module(void) { printk("<1>Goodbye cruel
> world\n"); }
> 
> Output:
> 
> #>gcc -D_KERNEL_ -DMODULE -c hello.c
> 
> [This builds the hello.o file. ]
> 
> #>insmod hello.o
> 
> hello.o : unresolved symbol printk
> hello.o : Note: modules without a GPL compatible
> license cannot use 
> GPONLY_symbols
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html 
> Please read the FAQ at  http://www.tux.org/lkml/ 
> 


______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca

