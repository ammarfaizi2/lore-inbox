Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268899AbTBZUQC>; Wed, 26 Feb 2003 15:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbTBZUQC>; Wed, 26 Feb 2003 15:16:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21633 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268899AbTBZUP6>; Wed, 26 Feb 2003 15:15:58 -0500
Date: Wed, 26 Feb 2003 15:29:06 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, p_gortmaker@yahoo.com,
       lkml <linux-kernel@vger.kernel.org>, rddunlap@osdl.org
Subject: Re: [2.5.63 PATCH][TRIVIAL]Change rtc.c ioport extend from 10h to 8h
In-Reply-To: <1046288552.4450.13.camel@vmhack>
Message-ID: <Pine.LNX.3.95.1030226152529.5261B-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Feb 2003, Rusty Lynch wrote:

> On Wed, 2003-02-26 at 11:35, Richard B. Johnson wrote:
> > On 26 Feb 2003, Rusty Lynch wrote:
> > 
> > > The real time clock only needs 8 bytes, but rtc.c is reserving 10h bytes.
> > [SNIPPED...]
> > 
> > It only needs two bytes port 0x70 and port 0x71 in ix86. Since the Sparc
> > gets addressed differently and can only read/write words, it needs 8
> > bytes.  Please, if you are going to fix it, please fix it only once by
> > setting a different length for the different machines!
> > Cheers,
> > Dick Johnson
> 
> Actually, it's finer grain then x86, it's a chipset issue.  As Randy
> pointed out in the original thread ==>
> > Some Intel chipset specs list RTC as using 0x70 - 0x77, probably with
> > some aliasing in there, so it looks to me like an EXTENT of 8 would be
> > safer and still allow you access to 0x79.
> > 
> > I'm looking at 82801BA-ICH2, 82801-ICH3, and 82801AA-ICH0 specs.
> > 
> > -- 

Can't see what an IDE chip-set has to do with it. The RTC can only
be accessed as an offset-location and a data-location. You write
an offset at one location and you read/write data at another location.
On an ix86, the locations are adjacent byte-wide ports. On the Sparc
they are adjacent dword-wide memory locations.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


