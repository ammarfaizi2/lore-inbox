Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292943AbSBVSEj>; Fri, 22 Feb 2002 13:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292944AbSBVSEa>; Fri, 22 Feb 2002 13:04:30 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:33410 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292943AbSBVSER>; Fri, 22 Feb 2002 13:04:17 -0500
Date: Fri, 22 Feb 2002 11:21:53 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Steffen Persvold <sp@scali.com>
Cc: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2
Message-ID: <20020222112153.B11081@vger.timpanogas.org>
In-Reply-To: <20020220.093034.112623671.davem@redhat.com> <Pine.LNX.4.30.0202201940480.20082-100000@elin.scali.no> <20020220133619.A729@vger.timpanogas.org> <3C763036.36BB8072@scali.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C763036.36BB8072@scali.com>; from sp@scali.com on Fri, Feb 22, 2002 at 12:49:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:49:10PM +0100, Steffen Persvold wrote:
> "Jeff V. Merkey" wrote:
> > 
> > On Wed, Feb 20, 2002 at 07:44:58PM +0100, Steffen Persvold wrote:
> > > On Wed, 20 Feb 2002, David S. Miller wrote:
> > >
> > > >    From: Jeff Garzik <jgarzik@mandrakesoft.com>
> > > >    Date: Wed, 20 Feb 2002 12:26:12 -0500
> > > >
> > > >    type abuse aside, and alpha bugs aside, this looks ok... what is the
> > > >    value of as->msize?
> > > >
> > > > Jeff and Jeff, the problem is one of two things:
> > > >
> > > > 1) when you have ~2GB of memory the vmalloc pool is very small
> > > >    and this it the same place ioremap allocations come from
> > > >
> > > > 2) the BIOS or Linus is not assigning resources of the device
> > > >    properly, or it simple can't because the available PCI MEM space
> > > >    with this much memory is too small
> > > >
> > > > I note that one of the resources of the card is 16MB or so.
> > >
> > > Hi guys,
> > >
> > > There is actually no need to have all three regions mapped at all times is
> > > there Jeff ? In the Scali ICM driver we actually doesn't ioremap() the
> > > prefetchable space at all because this is done with the mmap() method to
> > > the userspace clients. If you have a kernel space client though ioremap()
> > > is used, but only the parts of it that is needed (based on the number of
> > > nodes in the cluser and the shared memory size per node).
> > >
> > > Regards,
> > >
> > 
> > I am not using the adapters in user space, I am using them in kernel
> > space with a distributed RAID agent and file system.  This is a general
> > issue with Hugo's SISCI and IRM drivers and Linux.  They all need to work
> > in every configuration.  If it works with less than 1 GB is should work
> > with > 1GB of memory.
> > 
> > I am looking through get_vm_area() since this is where the bug is.  Your
> > Scali drivers are not the Dolphin released IRM/SISCI but custom drivers
> > you guys sell with **YOUR** software versions, and they are far from
> > general purpose.
> > 
> 
> Jeff,
> 
> I really don't think you're in a position to say wether the Scali driver is

Why don't you guys just support SISCI so there's not two driver
trees?  I have never seen your source code made public.  If it's
general then where can I download your code.  I also noticed your
implementation of the D335 drivers have some problems with our
applications.  

> general purpose or not, but in any case this issue is OT. My point is that it
> is not a good idea to keep the prefetchable area mapped at all times. The ICM
> driver also has kernel clients (e.g. a ethernet emulation driver) and they only
> ioremap() the areas which is needed based upon the number of nodes in the
> cluster they communicate with (and only a few Kbytes is mapped from each node). 
> 
> Regards,


Not everyone uses the same model you do for cluster membership. I am 
primarily concerned with keeping the same features/behaviors with 
the SISCI driver base.  It's the one I use.

Jeff

> -- 
>   Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
>  mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
> Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
> Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
