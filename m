Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTBLNPG>; Wed, 12 Feb 2003 08:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTBLNPD>; Wed, 12 Feb 2003 08:15:03 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52096 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267089AbTBLNOi>; Wed, 12 Feb 2003 08:14:38 -0500
Date: Wed, 12 Feb 2003 08:25:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Panic `cat /proc/ioports`
In-Reply-To: <20030211154413.19a172f4.akpm@digeo.com>
Message-ID: <Pine.LNX.3.95.1030212081934.6864A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003, Andrew Morton wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >
> > Linux version 2.4.18, after it runs for a few days, will panic
> > if I do `cat /proc/ioports`. Has this been reported/fixed in
> > later versions?
> > 
> > : Unable to handle kernel paging request at virtual address d48e2fa0 
> 
> This means that some driver which was previously loaded forgot to do a
> release_region().  Later, the /proc code tries to read stuff from within the
> driver which isn't there any more and oopses.
> 

Yes. I just noticed that most network board drivers in version 2.4.18
do not execute release_region() after they have done a request_region(),
if they fail to install because of some error. The error in this case was
the failure to allocate memory because I told the kernel I only had 4
megabytes (exprimental ioremap() of the rest in another module).

Is somebody fixing these drivers (do you know).  I could download the
latest of the 2.4.n series and clean some of these up if they have not
already been done by somebody else.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


