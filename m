Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273245AbTG3Spt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273246AbTG3Spt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:45:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19707 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S273245AbTG3Sph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:45:37 -0400
Date: Wed, 30 Jul 2003 20:45:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030730184529.GE21734@fs.tum.de>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730183033.GA970@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 11:30:33AM -0700, Mike Fedyk wrote:
> On Wed, Jul 30, 2003 at 08:10:06PM +0200, Adrian Bunk wrote:
> > On Wed, Jul 30, 2003 at 03:56:23PM +0200, Jan-Benedict Glaw wrote:
> > >...
> > > Please apply. Worst to say, even Debian seems to start using i486+
> > > features (ie. libstdc++5 is SIGILLed on Am386 because there's no
> > > "lock" insn available)...
> > 
> > Shouldn't the 486 emulation in the latest 386 kernel images in Debian
> > unstable take care of this?
> 
> What emulation?

486 emulation
CONFIG_CPU_EMU486
  When used on a 386, Linux can emulate 3 instructions from the 486 set.
  This allows user space programs compiled for 486 to run on a 386
  without crashing with a SIGILL. As any emulation, performance will be
 very low, but since these instruction are not often used, this might
  not hurt.  The emulated instructions are:
     - bswap (does the same as htonl())
     - cmpxchg (used in multi-threading, mutex locking)
     - xadd (rarely used)

  Note that this can also allow Step-A 486's to correctly run multi-thread
  applications since cmpxchg has a wrong opcode on this early CPU.

  Don't use this to enable multi-threading on an SMP machine, the lock
  atomicity can't be guaranted!

  Although it's highly preferable that you only execute programs targetted
  for your CPU, it may happen that, consecutively to a hardware replacement,
  or during rescue of a damaged system, you have to execute such programs
  on an inadapted processor.  In this case, this option will help you get
  your programs working, even if they will be slower.

  It is recommended that you say N here in any case, except for the
  kernels that you will use on your rescue disks.
  
  This option should not be left on by default, because it means that
  you execute a program not targetted for your CPU.  You should recompile
  your applications whenever possible.

  If you are not sure, say N.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

