Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310400AbSCBQzr>; Sat, 2 Mar 2002 11:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310402AbSCBQzh>; Sat, 2 Mar 2002 11:55:37 -0500
Received: from ol1-24.217.42.23.charter-stl.com ([24.217.42.23]:62912 "EHLO
	thepeel.org") by vger.kernel.org with ESMTP id <S310400AbSCBQz2>;
	Sat, 2 Mar 2002 11:55:28 -0500
Date: Sat, 2 Mar 2002 10:54:44 -0600 (CST)
From: John Peel <jrp@thepeel.org>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: make menuconfig fails 
In-Reply-To: <2009.1015032085@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0203021050340.12726-100000@thepeel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, Keith Owens wrote:

> On Fri, 1 Mar 2002 11:26:02 -0600 (CST), 
> John Peel <jrp@thepeel.org> wrote:
> >I just setup a new box running RH7.2 and I am trying to compile kernel 
> >2.4.18. I did a minimal install on this box as it is only going to function as a router. When I 
> >initially did a 'make menuconfig' it gave me an error regarding ncurses 
> >being missing. I installed ncurses, ncurses4, and ncurses-devel. Now when 
> >I do a 'make menuconfig' I get the following output:
> >
> >[root@localhost linux]# make menuconfig
> >rm -f include/asm
> >( cd include ; ln -sf asm-i386 asm)
> >make -C scripts/lxdialog all
> >make[1]: Entering directory `/usr/src/linux/scripts/lxdialog'
> >gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -DLOCALE  
> >-I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o checklist.o 
> >checklist.c
> >checklist.c: In function `dialog_checklist':
> >checklist.c:154: `TRUE' undeclared (first use in this function)
> 
> TRUE should be defined in /usr/include/ncurses/ncurses.h, like this
> 
> /* XSI and SVr4 specify that curses implements 'bool'.  However, C++ may also
>  * implement it.  If so, we must use the C++ compiler's type to avoid conflict
>  * with other interfaces.
>  */
> 
> #undef TRUE
> #define TRUE    1
> 
> #undef FALSE
> #define FALSE   0
> 
Mine looks very similar to this. I'm not sure if you just snipped info or 
if I need to change something to get it to work right. Here's the output:

/* XSI and SVr4 specify that curses implements 'bool'.  However, C++ may also
 * implement it.  If so, we must use the C++ compiler's type to avoid conflict 
 *with other interfaces.
 *
 * A further complication is that <stdbool.h> may declare 'bool' to be a
 * different type, such as an enum which is not necessarily compatible with
 * C++.  If we have <stdbool.h>, make 'bool' a macro, so users may #undef it.
 * Otherwise, let it remain a typedef to avoid conflicts with other #define's.
 * In either case, make a typedef for NCURSES_BOOL which can be used if needed
 * from either C or C++.
 */

#ifdef SVR4_CURSES
#undef TRUE
#define TRUE    1

#undef FALSE
#define FALSE   0
#endif

Like I said everything else looks pretty much the same. I'm jus ttrying to 
figure this out wihtout having to do any scewy upgrading on the system. 
Thanks, -peel


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

