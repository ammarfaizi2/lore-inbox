Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRGLUDd>; Thu, 12 Jul 2001 16:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbRGLUDX>; Thu, 12 Jul 2001 16:03:23 -0400
Received: from intranet.resilience.com ([209.245.157.33]:13242 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S266539AbRGLUDH>; Thu, 12 Jul 2001 16:03:07 -0400
Message-ID: <3B4E02BD.7A9087E2@resilience.com>
Date: Thu, 12 Jul 2001 13:04:13 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Davis <tadavis@lbl.gov>
CC: Laurent Itti <itti@java.usc.edu>, linux-kernel@vger.kernel.org
Subject: Re: receive stats null for bond0 in 2.4.6
In-Reply-To: <Pine.SV4.3.96.1010711163709.5481B-100000@java.usc.edu> <3B4CF00C.5B62DDBA@resilience.com> <3B4DF1A8.BDE85995@lbl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis wrote:
> 
> Jeff Golds wrote:
> >
> > Laurent Itti wrote:
> > >
> > > Hi all:
> > >
> > > just installed 2.4.6 and all is well except that all stats in
> > > /proc/net/dev are at zero on the receive side for our 3x100Mbps
> > > channel-bonded network interface (bond0, using kernel module "bonding").
> > > The interface works great (we do receive packets).  Transmit side stats
> > > appear ok. All stats also ok on the 3 ethernet boards that are enslaved
> > > into the bond.
> > >
> > > any idea? thanks!
> > >
> >
> > It's always zero because the bonding driver included with the Linux
> > kernel is pretty broken.  The comments say that its stats are collected
> > from the slaves, but this is untrue.  See the source code at
> > http://sourceforge.net/projects/bonding for how the stats should be
> > collected.
> >
> 
> No, in 2.2, bonding collected stats by adding up the slave's stats, and
> presenting that.
> 
> In 2.4, the stats was changed to be exactly what the bonding device has
> seen.
> 
> Bonding device will never ever see anything to do with recieve packets.
> 

So what's wrong with collecting the slaves' receive stats and reporting
them as stats for the bonding driver?  At least then you can quickly see
the total for all devices currently owned by the bonding device.

Stats are just a tool so that you can see if things are behaving
properly, you can report back whatever you like.  I prefer to have the
bonding driver collect the slaves' stats so you can easily see if
enslaved devices are receiving packets.  If you want to see which device
is getting more traffic, that's easy to see by looking at the individual
slave.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
