Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313139AbSDYOWQ>; Thu, 25 Apr 2002 10:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313160AbSDYOWP>; Thu, 25 Apr 2002 10:22:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:32384 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313139AbSDYOWO>; Thu, 25 Apr 2002 10:22:14 -0400
Date: Thu, 25 Apr 2002 10:22:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: rpm <rajendra.mishra@timesys.com>
cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, Nikita@Namesys.COM,
        Andrey Ulanov <drey@rt.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
In-Reply-To: <200204251310.g3PD9dI00738@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1020425095821.6728B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2002, rpm wrote:

> On Wednesday 17 April 2002 08:10 pm, Jesse Pollard wrote:
> > ---------  Received message begins Here  ---------
> >
> 
> > if (int(1/h * 100) == int(5.0 * 100))
> >
> > will give a "proper" result within two decimal places. This is still
> > limited since there are irrational numbers within that range that COULD
> > still come out with a wrong answer, but is much less likely to occur.
> >
> > Exact match of floating point is not possible - 1/h is eleveated to a
> > float.
> >
> > If your 1/h was actually num/h, and num computed by summing .01 100 times
> > I suspect the result would also be "wrong".
> >
> 
> why is exact match of floating point not possible ?

Because many (read most) numbers are not exactly representable
in floating-point. The purpose of floating-point it to represent
real numbers with a large dynamic range. The trade-off is that
few such internal representations are exact.

As a simple example, 0.33333333333.....  can't be represented exactly
even with paper-and-pencil. However, as the ratio of two integers
it can be represented exactly, i.e., 1/3 . Both 1 and 3 must
be integers to represent this ratio exactly.

All real numbers (except trancendentials) can represented exactly
as the ratio of two integers but floating-point uses only one
value, not two integers, to represent the value. So, an exact
representation of a real number, when using a single variable
in a general-purpose way, is, for all practical purposes, not
possible. Instead, we get very close.

When it comes to '==' close is not equal. There are macros in
<math.h> that can be used for most floating-point logic. You
should check them out. If we wanted to check for '==' we really
need to do something like this:

    double a, b;
    some_loop() {
       if(fabs(a-b) < 1.0e-38)
           break;
     }
Where we get the absolute value of the difference between two
FP variables and compare against some very small number.

To use the math macros, the comparison should be something like:

        if (isless(fabs(a-b), 1.0e-38))
             break;


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

