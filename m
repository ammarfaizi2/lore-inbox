Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265694AbSKFPJh>; Wed, 6 Nov 2002 10:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSKFPJh>; Wed, 6 Nov 2002 10:09:37 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45720 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265694AbSKFPJg>; Wed, 6 Nov 2002 10:09:36 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: john stultz <johnstul@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200211061503.gA6F3DW02053@localhost.localdomain>
References: <200211061503.gA6F3DW02053@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 15:38:35 +0000
Message-Id: <1036597115.10238.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 15:03, J.E.J. Bottomley wrote:
> There are certain architectures (voyager is the only one currently supported, 
> but I suspect the Numa machines will have this too) where the TSC cannot be 
> used for cross CPU timings because the processors are driven by separate 
> clocks and may even have different clock speeds.

IBM Summit is indeed another one. 

> What I need is an option simply not to compile in the TSC code and use the PIT 
> instead.  What I'm trying to do with the TSC and PIT options is give three 
> choices:
> 
> 1. Don't use TSC (don't compile TSC code): X86_TSC=n, X86_PIT=y
> 
> 2. May use TSC but check first (blacklist, notsc kernel option).  X86_TSC=y, 
> X86_PIT=y
> 
> 3. TSC is always OK so don't need PIT.  X86_TSC=y, X86_PIT=n

[Plus we need X86_CYCLONE and we may need X86_SOMETHING else for some
pending stuff]

> We probably need to make the notsc and dodgy tsc check contingent on X86_PIT 
> (or a config option that says we have some other timer mechanism compiled in). 
>  Really, the options should probably be handled in timer.c.

The dodgy_tsc check is now obsolete. The known cases are handled with
workarounds and CS5510/20 can now use the TSC

> Do we have an option for a deferred panic that will trip just after we init 
> the console and clean out the printk buffer?

Point to timer_none, check that later on in the boot


