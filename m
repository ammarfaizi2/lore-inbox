Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318375AbSGRW5a>; Thu, 18 Jul 2002 18:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318377AbSGRW5a>; Thu, 18 Jul 2002 18:57:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:61826 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318375AbSGRW53>; Thu, 18 Jul 2002 18:57:29 -0400
Date: Thu, 18 Jul 2002 19:04:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Yann Dirson <ydirson@altern.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       kaos@ocs.com.au
Subject: Re: Generic modules documentation is outdated
In-Reply-To: <20020718232535.GB8165@bylbo.nowhere.earth>
Message-ID: <Pine.LNX.3.95.1020718190106.2233A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002, Yann Dirson wrote:

> On Thu, Jul 18, 2002 at 11:48:41PM +0100, Alan Cox wrote:
> > On Thu, 2002-07-18 at 22:02, Yann Dirson wrote:
> > > - I have installed no proprietary driver, all loaded drivers declare to be
> > > "GPL" or "Dual BSD/GPL". 
> > 
> > Something you loaded was missing a MODULE_LICENSE tag - modern insmod
> > will warn on this one
> 
> I wrote:
> > I found a good candidate in the Apple HFS module
> 
> Hm, no, I found the real one (although HFS has the problem):
> 
> # modprobe ppp_deflate
> Warning: loading /lib/modules/2.4.18+preempt/kernel/drivers/net/ppp_deflate.o will taint the kernel: non-GPL license - BSD without advertisement clause
> 
> I'm pretty sure the "BSD without advertisement clause" license should not
> taint the kernel, should it ?
> 
> And even if there is an obscure license incompatibility, there is a problem
> in that this module is in the stock kernels, and should then be advertised
> as such (or maybe removed).
> 
> Regards,
> -- 
> Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
> Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
> Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
>      http://ydirson.free.fr/        | Check <http://www.debian.org/>

Of course, you can fix all this stuff by executing this ;^)



#!/bin/bash
# Temporarily fixes existing modules to contain the GPL symbol
#

TMPF=/tmp/Abradabrca
VER=`uname -r`

cat >${TMPF}.c <<EOF
#define __KERNEL__
#define MODULE
#include <linux/module.h>
MODULE_LICENSE("GPL");
EOF
gcc -Wall -O2 -c -o ${TMPF}.o ${TMPF}.c
for x in `find /lib/modules/${VER} -name "*.o"` ;
    do echo $x ;
    cp $x /tmp/x.o ;
    ld -r /tmp/x.o ${TMPF}.o -o /tmp/y.o ;
    cp /tmp/y.o $x ;
 done
echo "Fixed!"
rm -f ${TMPF} /tmp/x.o /tmp/y.o

Don't you love it when somebody undoes all this "lawyer" stuff!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
                 Windows-2000/Professional isn't.

