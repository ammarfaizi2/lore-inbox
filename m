Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRCKLWA>; Sun, 11 Mar 2001 06:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131403AbRCKLVu>; Sun, 11 Mar 2001 06:21:50 -0500
Received: from mlist.austria.eu.net ([193.81.83.3]:17396 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S131402AbRCKLVb>; Sun, 11 Mar 2001 06:21:31 -0500
Message-ID: <3AAB5F8F.D93E5B47@eunet.at>
Date: Sun, 11 Mar 2001 12:20:47 +0100
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep question
In-Reply-To: <3AA607E7.6B94D2D@eunet.at> <3AA936B2.D2F26847@mvista.com> <3AA9D575.1345EF2@eunet.at> <3AA9FBD7.A3EDD325@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> > > > At the moment I implemented by own delay loop using a small assembler
> > > > loop similar to the one used in the kernel. This has two disadvantages:
> > > > assembler isn't that portable, and the loop has to be calibrated.
> > >
> > > Why not use C?  As long as you calibrate it, it should do just fine.
> > Because the compiler might optimize it away.
> 
> Not if you use volatile on the data type.
I did a lost of testing and experimenting, and found the assembler loop
the best solution (it has the finest granualrity even on slower
systems).

> > > the other hand, since you are looping anyway, why not loop on a system
> > > time of day call and have the loop exit when you have the required time
> > > in hand.  These calls have microsecond resolution.
> > I'm afraid they don't (at least with kernel 2.0, I didn't try this with
> > 2.4).
> 
> Gosh, I started with 2.2.14 and it does full microsecond resolution.

Oh! Shame on me! I must have missed something here!

I could swear that this didn't work for me. I tried it yesterday, you
are right, there is microsecond resolution. Even on an old 2.0.38
kernel...

This solves all my problems. I'll loop on gettimeofday().

Thanks a lot!

                 Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
