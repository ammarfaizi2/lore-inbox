Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267380AbSLERhg>; Thu, 5 Dec 2002 12:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267381AbSLERhg>; Thu, 5 Dec 2002 12:37:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267380AbSLERhe>;
	Thu, 5 Dec 2002 12:37:34 -0500
Date: Thu, 5 Dec 2002 09:45:00 -0800
From: Dave Olien <dmo@osdl.org>
To: Kevin Brosius <cobra@compuserve.com>
Cc: Samium Gromoff <_deepfire@mail.ru>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Monitor utility (was Re: DAC960 at 2.5.50)
Message-ID: <20021205094500.A6769@acpi.pdx.osdl.net>
References: <E18HR1a-0005QL-00@f12.mail.ru> <20021203114201.A32313@acpi.pdx.osdl.net> <3DEF43DE.130064D8@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEF43DE.130064D8@compuserve.com>; from cobra@compuserve.com on Thu, Dec 05, 2002 at 07:17:34AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I hadn't seen it before.  I'll grab it and give it
a look.  I'm assuming it uses ioctl() calls to do
its dirty work.  In that case, it should mostly
still work.  I might have broken something around
the edges.  I also observed some races in the driver
between its ioctl() functions and some timer-driven
health monitoring functions that concerned me.
I'll look those over again more carefully.

Give me a day or so, and I'll let you know how
things look.

I've heard of something Mylex provides called
"global array manager" that runs on Linux.  But, I
think it requires a graphical front end on a windows
box.  I don't think it's open source either.
I'll look it over as a second priority after
this one.

Dave

On Thu, Dec 05, 2002 at 07:17:34AM -0500, Kevin Brosius wrote:
> Dave, all,
>   Did you know about the DAC960 monitor utility?  I just ran across it
> in the SuSE install set.  It's available from
> http://varmon.sourceforge.net/
> 
> Looks like it's not being maintained anymore (and probably won't work
> with the 2.5 driver yet?)
> 
> -- 
> Kevin
> 
> 
> Dave Olien wrote:
> > 
> > 
> > 
> > Let me know if you find any problems at all.  I'll try to
> > address them.
> > 
> > I think the biggest "imperfection" is just the coding style of
> > the whole driver.  I might submit some patches over time to clean
> > up coding style.
> > 
> > The next problem is that it doesn't handle media errors yet.
> > If you have a read or write failure because a sector on your disk
> > is bad, it fails the entire read or write. With all the coalescing
> > of requests that the block layer does, this might fail ALL of a
> > really large transfer just because one sector is bad.
> > 
> > I'm working on a patch that retries failures section at a time,
> > so that the failure will be more closely limited to the sector
> > that is bad.
> > 
> > On Thu, Nov 28, 2002 at 06:56:22PM +0300, Samium Gromoff wrote:
> > >  > Samium Gromoff...
> > > > > > <alan@lxorguk.ukuu.org.uk>
> > > > > >         [PATCH] update to OSDL DAC960 driver
> > > > > >
> > > > > >         Its not perfect but it works
> > > > >    is it supposed to blow my data, or is it relatively safe to use?
> > > >
> > > > There have been a few poeple using this patch for about 5 versions of
> > > > 2.5 so far.  I haven't done heavy testing myself, just booting and doing
> > > > some other testing of modules and drivers.  I am running the DAC960 on
> > > > my root/boot filesystem and haven't seen any problems yet.
> > >   thank you. i`ll join the 2.5 DAC user crowd soon then :-)
> > >
> > > ---
> > > regards,
> > >    Samium Gromoff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
