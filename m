Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291716AbSBTJ7R>; Wed, 20 Feb 2002 04:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291717AbSBTJ7G>; Wed, 20 Feb 2002 04:59:06 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:516 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S291716AbSBTJ6y>; Wed, 20 Feb 2002 04:58:54 -0500
Date: Wed, 20 Feb 2002 10:58:48 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tom Holroyd <tomh@po.crl.go.jp>
cc: Andreas Schwab <schwab@suse.de>,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <Pine.LNX.4.44.0202201101080.1972-100000@holly.crl.go.jp>
Message-ID: <Pine.LNX.4.33.0202201055010.708-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Tom Holroyd wrote:

> > |> 	jif * smp_num_cpus - (user + nice + system)
> >
> > Changing the line to this:
> >
> >  	jif * smp_num_cpus - user - nice - system
> >
> > should avoid the overflow.
> 
> True.  It still might be a good idea to make them longs, though,
> because they are really totals of all the CPUs, as in:
>                 user += kstat.per_cpu_user[cpu];
> 
> Now ultimately, kstat.per_cpu_user[cpu] will overflow, and I don't
> know what to do about that, but making user, nice, and system unsigned
> long will at least allow SMP systems to last a little while longer.
> (Actually I don't know why Procps needs these values at all -- the
> claim in the code is that all of this is just to compute the HZ value,
> which is presumably needed to be able to interpret jiffies.  It'd be a
> lot simpler just to have /proc/stat export the HZ value directly.)
> 

I'd still prefer to export only 32 bit of user, nice, and system. This 
way they overflow in a clearly defined way - the 32 bits we export are
exact, only the higher bits are missing. 

Tim

