Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290583AbSAYH0S>; Fri, 25 Jan 2002 02:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290585AbSAYH0I>; Fri, 25 Jan 2002 02:26:08 -0500
Received: from svr3.applink.net ([206.50.88.3]:2063 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290584AbSAYHZ7>;
	Fri, 25 Jan 2002 02:25:59 -0500
Message-Id: <200201250720.g0P7KeL09793@home.ashavan.org.>
Content-Type: text/plain;
  charset="koi8-r"
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Alexander Viro <viro@math.psu.edu>, Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: RFC: booleans and the kernel
Date: Sat, 26 Jan 2002 01:22:02 -0600
X-Mailer: KMail [version 1.3.2]
Cc: timothy.covell@ashavan.org, Robert Love <rml@tech9.net>,
        Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 January 2002 00:13, Alexander Viro wrote:
> On 25 Jan 2002, Xavier Bestel wrote:
> > le sam 26-01-2002 à 00:09, Timothy Covell a écrit :
> > > #include <stdio.h>
> > >
> > > int main()
> > > {
> > >         char x;
> > >
> > >         if ( x )
> > >         {
> > >                 printf ("\n We got here\n");
> > >         }
> > >         else
> > >         {
> > >                 // We never get here
> > >                 printf ("\n We never got here\n");
> > >         }
> > >         exit (0);
> > > }
> > > covell@xxxxxx ~>gcc -Wall foo.c
> > > foo.c: In function `main':
> > > foo.c:17: warning: implicit declaration of function `exit'
> >
> > I'm lost. What do you want to prove ? (Al Viro would say you just want
> > to show you don't know C ;)
> > And why do you think you never get there ?
>
> I suspect that our, ah, Java-loving friend doesn't realize that '\0' is
> a legitimate value of type char...
>
> BTW, he's got a funny compiler - I would expect at least a warning about
> use of uninitialized variable.

Java lover's computer gcc -v says:

Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)



I realize that '\0' is a legit character.   And before you start,
I also realize that a string is a null terminated list of characters (yuck).
My point is to be clean about one's code.    For example, Mark
Hahn sent me a bit of C based strlen code, but I prefer the
Linux kernel implementation which is more explicit and doesn't
make funky implicit nor explicit casts.  Kernel code:
(And, of course, glibc uses Assembly for strlen).


#ifndef __HAVE_ARCH_STRLEN
/**
 * strlen - Find the length of a string
 * @s: The string to be sized
 */
size_t strlen(const char * s)
{
    const char *sc;

    for (sc = s; *sc != '\0'; ++sc)
        /* nothing */;
    return sc - s;
}
#endif


-- 
timothy.covell@ashavan.org.
