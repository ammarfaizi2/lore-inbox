Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130970AbRCJKGw>; Sat, 10 Mar 2001 05:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130988AbRCJKGn>; Sat, 10 Mar 2001 05:06:43 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:23368 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S130970AbRCJKG2>; Sat, 10 Mar 2001 05:06:28 -0500
Message-ID: <3AA9FBD7.A3EDD325@mvista.com>
Date: Sat, 10 Mar 2001 02:03:03 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Reinelt <reinelt@eunet.at>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep question
In-Reply-To: <3AA607E7.6B94D2D@eunet.at> <3AA936B2.D2F26847@mvista.com> <3AA9D575.1345EF2@eunet.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reinelt wrote:
> 
> george anzinger wrote:
> >
> > Michael Reinelt wrote:
> > >
> > > At the moment I implemented by own delay loop using a small assembler
> > > loop similar to the one used in the kernel. This has two disadvantages:
> > > assembler isn't that portable, and the loop has to be calibrated.
> >
> > Why not use C?  As long as you calibrate it, it should do just fine.
> Because the compiler might optimize it away.

Not if you use volatile on the data type.
> 
> > On
> > the other hand, since you are looping anyway, why not loop on a system
> > time of day call and have the loop exit when you have the required time
> > in hand.  These calls have microsecond resolution.
> I'm afraid they don't (at least with kernel 2.0, I didn't try this with
> 2.4). 

Gosh, I started with 2.2.14 and it does full microsecond resolution.

They have microsecond resolution, but increment only every 1/HZ.
> 
> Someone gave me a hint to loop on rdtsc. I will look into this.

This ticks at 1/"cpu MHz", which can be found by: "cat /proc/cpuinfo"
> 
> > > - why are small delays only possible up to 2 msec? what if I needed a
> > > delay of say 5msec? I can't get it?
> >
> > If you want other times, you can always make more than one call to
> > nanosleep.
> Good point!

~snip~

George
