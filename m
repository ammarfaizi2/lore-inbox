Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283119AbRLDSXU>; Tue, 4 Dec 2001 13:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283203AbRLDSWL>; Tue, 4 Dec 2001 13:22:11 -0500
Received: from web20206.mail.yahoo.com ([216.136.226.61]:13830 "HELO
	web20206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281547AbRLDSUZ>; Tue, 4 Dec 2001 13:20:25 -0500
Message-ID: <20011204182023.87068.qmail@web20206.mail.yahoo.com>
Date: Tue, 4 Dec 2001 13:20:23 -0500 (EST)
From: Michael Zhu <apiggyjj@yahoo.ca>
Reply-To: apiggyjj@yahoo.ca
Subject: Re: Insmod problems
To: Tyler BIRD <BIRDTY@uvsc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <sc0ca5e8.017@mail-smtp.uvsc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've changed my source file like this:
#define MODULE

#include <linux/module.h>

int init_module(void)  { printk("<1>Hello, world\n");
return 0; }
void cleanup_module(void) { printk("<1>Goodbye cruel
world\n"); }

And I use the following command line to build the
module.

gcc -c -D__KERNEL__ hello.c

But when I use insmod to load the module I got the
following error message:

hello.o : kernel-module version mismatch
         hello.o was compiled for kernel version
2.4.12
         while this kernel is version 2.4.8

What is wrong? My kernel version is 2.4.8. Is there
something wrong with the gcc compilier? My gcc
compilier is gcc-2.95.

Thanks to everyone. Your help is very beneficial to
me.

Michael




--- Tyler BIRD <BIRDTY@uvsc.edu> wrote:
> Try this
> 
> ¯--------
> 
> #define MODULE
> 
> #include <linux/module.h>
> int init_module(void) { printk("<1>Hello World");
> return 0;}
> void cleanup_module(void) {printk("<1>Goodbye cruel
> world\n"); }
> ¯---
> 
> gcc -c -D__KERNEL__ hello.c
> 
> compiled and loaded fine on my system
> 
> I think linux/module.h defines
> the kernel version. Make sure that you have the
> kernel source headers installed under /usr/include
> which is a link to /usr/src/linux/include.
> 
> you oughta put the above include/module.h at the
> begining of your source.
> 
> 
> 
> Also there has been a macro lately to
> delate which routines will be init_module,
> cleanup_module22
> 
> >>> Michael Zhu <apiggyjj@yahoo.ca> 12/04/01 10:06AM
> >>>
> I've define these two when I compile the module. The
> command line is:
> 
> gcc -D_KERNEL_ -DMODULE -c hello.c
> 
> 
> --- Tyler BIRD <BIRDTY@uvsc.edu> wrote:
> > You need to define the __KERNEL__ and MODULE
> symbols
> > 
> > #define __KERNEL__
> > #define MODULE
> > 
> > 
> > >>> Nav Mundi <nmundi@karthika.com> 12/04/01
> 09:33AM
> > >>>
> > What are we doing wrong? - Nav & Michael
> > **************************************************
> > 
> > hello.c Source:
> > 
> > #include "/home/mzhu/linux/include/linux/config.h"
> 
> > /*retrieve the CONFIG_* macros */
> > #if defined(CONFIG_MODVERSIONS) &&
> > !defined(MODVERSIONS)
> > #define MODVERSIONS  /* force it on */
> > #endif
> > 
> > #ifdef MODVERSIONS
> > #include
> > "/home/mzhu/linux/include/linux/modversions.h"
> > #endif
> > 
> > #include "/home/mzhu/linux/include/linux/module.h"
> > 
> > int init_module(void)  { printk("<1>Hello,
> > world\n");  return 0; }
> > void cleanup_module(void) { printk("<1>Goodbye
> cruel
> > world\n"); }
> > 
> > Output:
> > 
> > #>gcc -D_KERNEL_ -DMODULE -c hello.c
> > 
> > [This builds the hello.o file. ]
> > 
> > #>insmod hello.o
> > 
> > hello.o : unresolved symbol printk
> > hello.o : Note: modules without a GPL compatible
> > license cannot use 
> > GPONLY_symbols
> > 
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> 
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html 
> > Please read the FAQ at  http://www.tux.org/lkml/ 
> > 
> 
> 
>
______________________________________________________
> 
> Send your holiday cheer with
> http://greetings.yahoo.ca
> 


______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
