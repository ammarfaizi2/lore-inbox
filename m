Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTBLSou>; Wed, 12 Feb 2003 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267581AbTBLSot>; Wed, 12 Feb 2003 13:44:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:62336 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267583AbTBLSor>; Wed, 12 Feb 2003 13:44:47 -0500
Date: Wed, 12 Feb 2003 13:56:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: Panic `cat /proc/ioports`
In-Reply-To: <20030212102540.7fe1e55d.rddunlap@osdl.org>
Message-ID: <Pine.LNX.3.95.1030212135439.8872A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, Randy.Dunlap wrote:

> On Wed, 12 Feb 2003 09:22:24 -0800
> Andrew Morton <akpm@digeo.com> wrote:
> 
> | "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> | >
> | > On Tue, 11 Feb 2003, Andrew Morton wrote:
> | > 
> | > > "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> | > > >
> | > > > Linux version 2.4.18, after it runs for a few days, will panic
> | > > > if I do `cat /proc/ioports`. Has this been reported/fixed in
> | > > > later versions?
> | > > > 
> | > > > : Unable to handle kernel paging request at virtual address d48e2fa0 
> | > > 
> | > > This means that some driver which was previously loaded forgot to do a
> | > > release_region().  Later, the /proc code tries to read stuff from within the
> | > > driver which isn't there any more and oopses.
> | > > 
> | > 
> | > Yes. I just noticed that most network board drivers in version 2.4.18
> | > do not execute release_region() after they have done a request_region(),
> | > if they fail to install because of some error.
> | 
> | Fairly common error.
> | 
> | > The error in this case was
> | > the failure to allocate memory because I told the kernel I only had 4
> | > megabytes (exprimental ioremap() of the rest in another module).
> | > 
> | > Is somebody fixing these drivers (do you know).
> | 
> | There is ongoing janitorial work, and things are getting better.
> | But I'm not aware of anyone specifically auditing for missing
> | release_region()s.  And given that it is a box-killer rather than
> | just a memory leak, yes, it is worth an audit.
> 
> Dick,
> Did you ever determine which driver (or module) was causing this problem?
> 

Yes! pcnet32 to start. Practically all the network drivers end up
doing this if they fail somewhere in the initialization. I didn't
get a chance to look at others. I got called away for a "work break".


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


