Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbRGLOQK>; Thu, 12 Jul 2001 10:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265120AbRGLOPu>; Thu, 12 Jul 2001 10:15:50 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:56800 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S265051AbRGLOPo>; Thu, 12 Jul 2001 10:15:44 -0400
Date: Thu, 12 Jul 2001 10:15:13 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
Message-ID: <20010712101513.A439@alcove.wittsend.com>
Mail-Followup-To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
	root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200107121211.NAA10270@mauve.demon.co.uk> <200107121254.HAA89768@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <200107121254.HAA89768@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Thu, Jul 12, 2001 at 07:54:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 07:54:10AM -0500, Jesse Pollard wrote:

> > > On Wed, 11 Jul 2001, C. Slater wrote:
> > > >Would anyone else like to point out some other task somewhat related 
> > > >and have me do it? :-)
> > > >
> > > >> > Before you even try switching kernels, first implement a process
> > > >> > checkpoint/restart. The process must be resumed after a boot
> > > >> > using the same
> > > >> > kernel, with all I/O resumed. Now get it accepted into the kernel.
> > > >> 
> > > >> Hear, hear!  That would be a useful feature, maybe not network servers, 
> > > >> but for pure number crunching apps it would save people having to write 
> > > >> all the state saving and recovery that is needed now for long term 
> > > >> computations.
> > > >
> > > >Get a computer with hibernation support. That's just about what it is.
> > > 
> > > Bzzzt wrong anser. Hibernation stops the entire kernel. checkpoint restart
> > > stops processes, saves the entire state of the process. hibernation
> > > is just halt the processor.
> > 
> > Hibernation may not be.
> > I've just suspended to disk after the list line, pulled the power supplies,
> > taken the RAM chip out, shorted the pins to make really sure, then powered
> > back up.
> > Everything just resumed fine.
> > 
> > All I'd need to do kernel migration is a quick vi of the
> > disk file.
> > 
> > (well, almost)

> That sounds more like a memory dump to disk, and reload after power restored.
> Either that or possibly a separate power supply for RAM (something like a
> trickle discharge capacitor; I've read that some capacitors can hold a charge
> for about 3 days. Whether that would work for a large RAM or not, I have no
> idea).

	It's a suspend to disk.  Lots of Laptops can do it and my Toshiba
Tecra 8100 can do it from the BIOS if I have a magic Windows partition with
an appropriate suspend file in it (which would be unencrypted, which would
be unacceptable - so I had to look for a Linux solution for the suspend
to disk problem).

	Check out the swsusp project up at Source Forge
<http://sourceforge.net/projects/swsusp/>.  It allows me to suspend
into the swap space by hitting Alt-SysRQ-D.  Great for changing
batteries on laptops (and, no, normal suspend does not survive a battery
change) but also REALLY GREAT for forensic security analysis of compromised
systems.  I hit the console of a compromised system and hit Alt-SysRq-D
and it flushs the dirty buffers, dumps memory to swap (preserving all
my "volatiles") and the shuts down.  I can snapshot the hard drive and
then restart the system where it left off for live running analysis.  If
that gets screwed up, I can restore the image again and restart again from
the same spot again.  I've also got all the memory and CPU state in that
disk image for "in-vitro" analysis by tools like Weitse's "The Coroner's
Toolkit".

	But that doesn't solve ANY of the problems with changing the kernel
itself.  Suspending and restoring the system is the easy part (and swsusp
still has some problems restoring X Windows).  Restoring a system to
a different kernel is orders of magnitude worse, if not down right
impossible for all the reasons given over internal structures and
interfaces.

	I would LOVE to have something like swsusp in the main line kernel,
however, just so I didn't have to convince IT departments to apply this
custom kernel patch to their production systems BEFORE they get their butts
kicked by some snott nosed script kiddie.  :-/

> -------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: pollard@navo.hpc.mil
> 
> Any opinions expressed are solely my own.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

